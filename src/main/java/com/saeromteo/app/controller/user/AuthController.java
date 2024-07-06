package com.saeromteo.app.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.admin.AdminDTO;
import com.saeromteo.app.model.user.PrincipalDetail;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.point.PointService;
import com.saeromteo.app.service.user.EmailService;
import com.saeromteo.app.service.user.UserLoginService;
import com.saeromteo.app.service.user.UserService;

@Controller
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	@Qualifier("userLoginService")
	UserLoginService uService;

	@Autowired
	@Qualifier("passwordEncoder")
	private PasswordEncoder passwordEncoder;

	@Autowired
	private JWTUtil jwtUtil;

	@Autowired
	EmailService emailService;
	
	@Autowired
	PointService pointService;
	
	@Autowired
	private UserService userService;

	/**
	 * 비밀번호 재설정 이메일 입력 페이지로 이동합니다.
	 * 
	 * @return 비밀번호 재설정 이메일 입력 페이지
	 */
	@PostMapping(value = "reset-password-input")
	public String resetPasswordInput() {
		return "auth/reset-password/reset-password-input";
	}

	/**
	 * 비밀번호 재설정 페이지로 이동합니다.
	 * 
	 * @param userPassword 새로운 비밀번호
	 * @param session      현재 세션
	 * @return 비밀번호 재설정 페이지
	 */
	@PostMapping(value = "reset-password-reinput")
	public String resetPasswordReInput(String userPassword, HttpSession session) {
		session.setAttribute("userPassword", passwordEncoder.encode(userPassword));
		return "auth/reset-password/reset-password-reinput";
	}

	/**
	 * 비밀번호 재설정 확인 프로세스를 처리합니다.
	 * 
	 * @param session 현재 세션
	 * @param request 요청 데이터
	 * @return 비밀번호 재설정 결과
	 */
	@RequestMapping(value = "reset-passwordCheck-proccess", method = RequestMethod.POST, produces = "application/json;charset=utf-8", consumes = "application/json")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> resetPasswordCheckProcess(HttpSession session,
			@RequestBody Map<String, String> request) {
		Map<String, Object> response = new HashMap<>();
		String confirmPassword = request.get("confirmPassword");

		String userPassword = (String) session.getAttribute("userPassword");
		String userEmail = (String) session.getAttribute("userEmail");

		// 비밀번호 일치 여부 확인
		if (userPassword != null && passwordEncoder.matches(confirmPassword, userPassword)) {
			UserDTO userDTO = new UserDTO();
			userDTO.setUserEmail(userEmail);
			userDTO.setUserPassword(userPassword);

			int result = uService.resetPassword(userDTO);

			if (result == 1) {
				session.removeAttribute("userPassword");
				session.removeAttribute("userEmail");
				session.removeAttribute("resetVerificationCode");
				response.put("status", "success");
				response.put("message", "비밀번호 재설정이 완료되었습니다.");
				return ResponseEntity.ok(response);
			} else {
				response.put("status", "error");
				response.put("message", "비밀번호 재설정 중 오류가 발생했습니다.");
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
			}
		} else {
			response.put("message", "비밀번호가 일치하지 않습니다.");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}
	}

	/**
	 * 비밀번호 재설정 이메일 입력 페이지로 이동합니다.
	 * 
	 * @return 비밀번호 재설정 이메일 입력 페이지
	 */
	@GetMapping(value = "reset-password-email")
	public String resetPasswordEmail() {
		return "auth/reset-password/reset-password-email";
	}

	/**
	 * 비밀번호 재설정 이메일 인증 페이지로 이동합니다.
	 * 
	 * @return 비밀번호 재설정 이메일 인증 페이지
	 */
	@PostMapping(value = "reset-email-verification")
	public String resetEmailVerification() {
		return "auth/reset-password/reset-email-vaildatecode";
	}

	/**
	 * 비밀번호 재설정 인증 코드 확인 프로세스를 처리합니다.
	 * 
	 * @param session 현재 세션
	 * @param request 요청 데이터
	 * @return 인증 코드 확인 결과
	 */
	@PostMapping(value = "/reset-verification-process", consumes = "application/json")
	public ResponseEntity<Map<String, Object>> resetVerificationProcess(HttpSession session,
			@RequestBody Map<String, String> request) {
		String code = request.get("code");
		String verificationCode = (String) session.getAttribute("resetVerificationCode");

		Map<String, Object> response = new HashMap<>();

		if (verificationCode != null && verificationCode.equals(code)) {
			response.put("success", true);
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "인증번호가 올바르지 않습니다.");
			return ResponseEntity.ok(response);
		}
	}

	/**
	 * 인증 이메일 재발송 요청을 처리합니다.
	 * 
	 * @param session 현재 세션
	 * @return 이메일 재발송 결과
	 */
	@PostMapping(value = "/reSend")
	@ResponseBody
	public Map<String, Object> verificationResendEmail(HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		try {
			String email = (String) session.getAttribute("userEmail");
			session.removeAttribute("resetVerificationCode");
			String verificationCode = emailService.randomNumber();
			emailService.sendSimpleMessage(email, "새롬터 회원가입 인증 이메일입니다.", verificationCode);
			session.setAttribute("resetVerificationCode", verificationCode);
			response.put("success", true);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}
		return response;
	}

	/**
	 * 비밀번호 재설정 사용자 인증 프로세스를 처리합니다.
	 * 
	 * @param request 요청 데이터
	 * @param session 현재 세션
	 * @return 사용자 인증 결과
	 */
	@PostMapping(value = "userVerificationProcess")
	public ResponseEntity<Map<String, Object>> userVerification(@RequestBody Map<String, String> request,
			HttpSession session) {
		String userEmail = request.get("userEmail");
		PrincipalDetail registrationUser = uService.loadUserByUsername(userEmail);
		Map<String, Object> response = new HashMap<>();

		if (registrationUser != null && registrationUser.getPassword().length() != 50) {
			String verificationCode = emailService.randomNumber();
			emailService.sendSimpleMessage(userEmail, "새롬터 비밀번호 재설정 인증 이메일입니다.", verificationCode);
			session.setAttribute("userEmail", userEmail);
			session.setAttribute("resetVerificationCode", verificationCode);
			response.put("status", "success");
			response.put("message", "인증 코드가 이메일로 전송되었습니다.");
			return ResponseEntity.ok(response);
		} else {
			response.put("status", "error");
			response.put("message", "회원가입된 유저가 아닙니다.");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}
	}

	/**
	 * 회원가입 비밀번호 확인 및 처리 프로세스를 처리합니다.
	 * 
	 * @param session 현재 세션
	 * @param request 요청 데이터
	 * @return 비밀번호 확인 및 회원가입 처리 결과
	 */
	@RequestMapping(value = "/registration/password-check", method = RequestMethod.POST, produces = "application/json;charset=utf-8", consumes = "application/json")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> passwordCheck(HttpSession session,
			@RequestBody Map<String, String> request) {
		String confirmPassword = request.get("confirmPassword");
		Map<String, Object> response = new HashMap<>();

		String userPassword = (String) session.getAttribute("userPassword");
		String userEmail = (String) session.getAttribute("registrationUserEmail");
		String marketingTOS = (String) session.getAttribute("marketingTOS");
		String thirdPartyTOS = (String) session.getAttribute("thirdPartyTOS");

		if (userPassword != null && passwordEncoder.matches(confirmPassword, userPassword)) {
			UserDTO userDTO = new UserDTO();
			String nickname = userEmail.substring(0, userEmail.indexOf('@'));
			userDTO.setUserEmail(userEmail);
			userDTO.setUserPassword(userPassword);
			userDTO.setUserStatus(true);
			userDTO.setUserNickname(nickname);
			userDTO.setUserMAgree(marketingTOS != null);
			userDTO.setUserTAgree(thirdPartyTOS != null);
			// default 이미지 셋팅
			userDTO.setUserImgPath("https://saerom-teo.s3.ap-northeast-2.amazonaws.com/mypage-profile.png");
			int result = uService.registrationUser(userDTO);

			if (result == 1) {
				session.removeAttribute("userPassword");
				session.removeAttribute("registrationUserEmail");
				session.removeAttribute("marketingTOS");
				session.removeAttribute("thirdPartyTOS");
				session.removeAttribute("verificationCode");
				PrincipalDetail principalRegiUser = uService.loadUserByUsername(userEmail);
				UserDTO regiUser = principalRegiUser.getUser();
				pointService.insertPoint(regiUser.getUserId(),100,"earned", "admin", "신규 가입 웰컴 포인트");
				response.put("status", "success");
				response.put("message", "회원가입이 완료되었습니다.");
				
				//포인트 지급 
				return ResponseEntity.ok(response);
			} else {
				response.put("status", "error");
				response.put("message", "회원가입 중 오류가 발생했습니다.");
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
			}
		} else {
			response.put("message", "비밀번호가 일치하지 않습니다.");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}
	}

	/**
	 * 로그인 페이지로 이동합니다.
	 * 
	 * @return 로그인 페이지
	 */
	@GetMapping(value = "/login")
	public String login() {
		return "auth/login";
	}

	/**
	 * 로그인 프로세스를 처리합니다.
	 * 
	 * @param mem      사용자 정보
	 * @param response HTTP 응답
	 * @throws IOException 입출력 예외
	 */
	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public void loginProcess(@RequestBody PrincipalDetail mem, HttpServletResponse response) throws IOException {
		Map<String, Object> responseData = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
		try {
			// 관리자 부터 판단.
			AdminDTO admin = uService.adminLogin(mem.getUsername());

			if (admin != null && passwordEncoder.matches(mem.getPassword(),admin.getAdminPassword())) {
				// 관리자 역할 부여 및 리다이렉트
				String token = jwtUtil.generateAdminToken(admin, "ADMIN");
				Cookie jwtCookie = new Cookie("jwtToken", token);
				jwtCookie.setPath("/");
				jwtCookie.setHttpOnly(false);
				jwtCookie.setMaxAge(100 * 24 * 60 * 60);
				
				responseData.put("message", "admin");
				
				response.setStatus(HttpStatus.OK.value());
				response.setContentType("application/json");
				response.getWriter().write(mapper.writeValueAsString(responseData));
				response.addCookie(jwtCookie);
				return;
			} else {

				PrincipalDetail dataUser = uService.loadUserByUsername(mem.getUsername());
				// 사용자 존재 여부 확인
				if (dataUser == null || dataUser.getUser() == null) {
					responseData.put("message", "not_user");
					response.setStatus(HttpStatus.NOT_FOUND.value());
					response.setContentType("application/json");
					response.getWriter().write(mapper.writeValueAsString(responseData));
					return;
				}

				// 비밀번호 일치 여부 확인
				if (!passwordEncoder.matches(mem.getPassword(), dataUser.getUser().getUserPassword())) {
					responseData.put("message", "not_Match");
					response.setStatus(HttpStatus.UNAUTHORIZED.value());
					response.setContentType("application/json");
					response.getWriter().write(mapper.writeValueAsString(responseData));
					return;
				}

				// JWT 토큰 생성
				String token = jwtUtil.generateToken(dataUser, "USER");
				Cookie jwtCookie = new Cookie("jwtToken", token);
				jwtCookie.setPath("/");
				jwtCookie.setHttpOnly(false);
				jwtCookie.setMaxAge(24 * 60 * 60);
				response.addCookie(jwtCookie);

			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
			responseData.put("message", e.getMessage());
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		} catch (Exception e) {
			e.printStackTrace();
			responseData.put("message", "서버 에러 발생");
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		}
	}

	/**
	 * 회원가입 약관 동의 화면으로 이동합니다.
	 * 
	 * @return 회원가입 약관 동의 화면
	 */
	@GetMapping(value = "/registration")
	public String registerationStep1(HttpServletRequest request) {
		return "auth/registration/serviceAgreement-1";
	}

	/**
	 * 회원가입 이메일 입력 화면으로 이동합니다.
	 * 
	 * @param session       현재 세션
	 * @param serviceTOS    서비스 이용 약관 동의 여부
	 * @param personalTOS   개인정보 수집 및 이용 동의 여부
	 * @param marketingTOS  마케팅 정보 수신 동의 여부
	 * @param thirdPartyTOS 제3자 정보 제공 동의 여부
	 * @return 회원가입 이메일 입력 화면
	 */
	@PostMapping(value = "registration/emailInput")
	public String registerationStep2(HttpSession session, String serviceTOS, String personalTOS, String marketingTOS,
			String thirdPartyTOS) {
		session.setAttribute("marketingTOS", marketingTOS);
		session.setAttribute("thirdPartyTOS", thirdPartyTOS);
		return "auth/registration/emailInput-2";
	}

	/**
	 * 회원가입 이메일 인증 화면으로 이동합니다.
	 * 
	 * @param session 현재 세션
	 * @return 회원가입 이메일 인증 화면
	 */
	@PostMapping(value = "registration/verification")
	public String testverification(HttpSession session) {
		return "auth/registration/verificationCode-3";
	}

	/**
	 * 회원가입 비밀번호 입력 화면으로 이동합니다.
	 * 
	 * @return 회원가입 비밀번호 입력 화면
	 */
	@PostMapping(value = "registration/passwordInput")
	public String passwordInput() {
		return "auth/registration/password-input-4";
	}

	/**
	 * 이메일 중복 확인 및 인증 이메일 발송을 처리합니다.
	 * 
	 * @param session            현재 세션
	 * @param userEmail          사용자 이메일
	 * @param redirectAttributes 리다이렉트 속성
	 * @return 중복 확인 및 인증 이메일 발송 결과
	 */
	@PostMapping(value = "registration/checkEmailDuplicate")
	@ResponseBody
	public String checkEmailDuplicate(HttpSession session, String userEmail, RedirectAttributes redirectAttributes) {
		UserDetails registrationUser = uService.loadUserByUsername(userEmail);

		if (registrationUser != null) {
			return "existing_user";
		} else {
			String verificationCode = emailService.randomNumber();
			emailService.sendSimpleMessage(userEmail, "새롬터 회원가입 인증 이메일입니다.", verificationCode);
			session.setAttribute("registrationUserEmail", userEmail);
			session.setAttribute("verificationCode", verificationCode);
			return "new_user";
		}
	}

	/**
	 * 회원가입 이메일 인증 코드 확인 프로세스를 처리합니다.
	 * 
	 * @param session 현재 세션
	 * @param request 요청 데이터
	 * @return 이메일 인증 코드 확인 결과
	 */
	@PostMapping(value = "/registration/verification-process", consumes = "application/json")
	public ResponseEntity<Map<String, Object>> verification(HttpSession session,
			@RequestBody Map<String, String> request) {
		String code = request.get("code");
		String verificationCode = (String) session.getAttribute("verificationCode");

		Map<String, Object> response = new HashMap<>();

		if (verificationCode != null && verificationCode.equals(code)) {
			response.put("success", true);
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "인증번호가 올바르지 않습니다.");
			return ResponseEntity.ok(response);
		}
	}

	/**
	 * 회원가입 인증 이메일 재발송 요청을 처리합니다.
	 * 
	 * @param session 현재 세션
	 * @return 이메일 재발송 결과
	 */
	@PostMapping(value = "registration/reSend")
	@ResponseBody
	public Map<String, Object> reSendEmail(HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		try {
			String email = (String) session.getAttribute("registrationUserEmail");
			session.removeAttribute("verificationCode");
			String verificationCode = emailService.randomNumber();
			emailService.sendSimpleMessage(email, "새롬터 회원가입 인증 이메일입니다.", verificationCode);
			session.setAttribute("verificationCode", verificationCode);
			response.put("success", true);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}
		return response;
	}

	/**
	 * 회원가입 비밀번호 재입력 화면으로 이동합니다.
	 * 
	 * @param session      현재 세션
	 * @param userPassword 사용자 비밀번호
	 * @return 회원가입 비밀번호 재입력 화면
	 */
	@PostMapping(value = "registration/password-reinput")
	public String passwordReInput(HttpSession session, String userPassword) {
		userPassword = passwordEncoder.encode(userPassword);
		session.setAttribute("userPassword", userPassword);
		return "auth/registration/password-reInput-5";
	}

	/**
	 * [선택] 홍보 및 마케팅 이용 동의서 보기 페이지로 이동합니다.
	 * 
	 * @return 홍보 및 마케팅 이용 동의서 페이지
	 */
	@GetMapping(value = "TOS/marketingTOS")
	public String readmarketingTOS() {
		return "auth/TOS/marketingTOS";
	}

	/**
	 * [필수] 개인정보 수집 및 이용 동의서 보기 페이지로 이동합니다.
	 * 
	 * @return 개인정보 수집 및 이용 동의서 페이지
	 */
	@GetMapping(value = "TOS/personalTOS")
	public String readpersonalTOS() {
		return "auth/TOS/personalTOS";
	}

	/**
	 * [필수] 새롬터 서비스 이용약관 동의서 보기 페이지로 이동합니다.
	 * 
	 * @return 새롬터 서비스 이용약관 동의서 페이지
	 */
	@GetMapping(value = "TOS/serviceTOS")
	public String readserviceTOS() {
		return "auth/TOS/serviceTOS";
	}

	/**
	 * [선택] 마케팅 개인정보 제3자 제공 동의서 보기 페이지로 이동합니다.
	 * 
	 * @return 마케팅 개인정보 제3자 제공 동의서 페이지
	 */
	@GetMapping(value = "TOS/thirdPartyTOS")
	public String readthirdPartyTOS() {
		return "auth/TOS/thirdPartyTOS";
	}
}
