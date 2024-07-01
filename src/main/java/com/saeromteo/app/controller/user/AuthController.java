package com.saeromteo.app.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.user.PrincipalDetail;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.user.EmailService;
import com.saeromteo.app.service.user.UserLoginService;

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

	/*
	 * 비밀번호 찾기
	 */
	// 비밀번호 찾기 페이지로 이동
	@GetMapping(value = "find-password")
	public String findPassword() {
		return "auth/find-password/find-password";
	}

	// 비밀번호 찾기 처리 (아직 구현되지 않음)
	@PostMapping(value = "find-password-process")
	public String findPasswordProcess() {
		
		return "auth/find-password/find-password";
	}

	// 비밀번호 확인 및 회원가입 처리
	@RequestMapping(value = "registration/password-check", method = RequestMethod.POST, produces = "application/json;charset=utf-8" , consumes = "application/json")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> passwordCheck(HttpSession session, @RequestBody Map<String, String> request) {
		
		System.out.println("registration/password-check");
	    String confirmPassword = request.get("confirmPassword");
	    Map<String, Object> response = new HashMap<>();

	    // 세션에서 저장된 비밀번호 가져오기
	    String userPassword = (String) session.getAttribute("userPassword");
	    String userEmail = (String) session.getAttribute("registrationUserEmail");
	    String marketingTOS = (String) session.getAttribute("marketingTOS");
	    String thirdPartyTOS = (String) session.getAttribute("thirdPartyTOS");

	    // 비밀번호 일치 여부 확인
	    if (userPassword != null && userPassword.equals(confirmPassword)) {
	        // 회원가입 처리
	        UserDTO userDTO = new UserDTO();
	        String nickname = userEmail.substring(0, userEmail.indexOf('@'));
	        userDTO.setUserEmail(userEmail);
	        userDTO.setUserPassword(passwordEncoder.encode(userPassword));
	        userDTO.setUserNickname(nickname);
	        // 약관 동의 여부 설정
	        userDTO.setUserMAgree(marketingTOS != null);
	        userDTO.setUserTAgree(thirdPartyTOS != null);

	        int result = uService.registrationUser(userDTO);

	        if (result == 1) {
	            // 회원가입 성공 시 응답 설정
	        	 response.put("status", "success");
	            response.put("message", "회원가입이 완료되었습니다.");
	            return ResponseEntity.ok(response);
	        } else {
	            // 회원가입 실패 시 응답 설정
	        	  response.put("status", "error");
	            response.put("message", "회원가입 중 오류가 발생했습니다.");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    } else {
	        // 비밀번호 불일치 시 응답 설정
	        response.put("message", "비밀번호가 일치하지 않습니다.");
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
	    }
	}


	/*
	 * 로그인
	 */
	// 로그인 페이지로 이동
	@GetMapping(value = "/login")
	public String login() {
		return "auth/login";
	}

	// 로그인 처리
	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public void loginProcess(@RequestBody PrincipalDetail mem, HttpServletResponse response) throws IOException {
		Map<String, Object> responseData = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();

		try {
			PrincipalDetail dataUser = uService.loadUserByUsername(mem.getUsername());
			System.out.println(mem.toString());

			// 사용자 존재 여부 확인
			if (dataUser.getUser() == null) {
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
			String token = jwtUtil.generateToken(dataUser);
			responseData.put("token", token);
			response.setStatus(HttpStatus.OK.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));

		} catch (IllegalArgumentException e) {
			System.out.println("IllegalArgumentException");
			e.printStackTrace();
			responseData.put("message", e.getMessage());
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		} catch (JsonProcessingException e) {
			System.out.println("JSON 처리 중 오류 발생");
			e.printStackTrace();
			responseData.put("message", "JSON 처리 중 오류 발생");
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("서버 에러 발생");

			responseData.put("message", "서버 에러 발생");
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		}
	}

	/*
	 * 회원가입
	 */
	// 회원가입 약관 동의 화면으로 이동
	@GetMapping(value = "/registration")
	public String registerationStep1(HttpServletRequest request) {
		return "auth/registration/serviceAgreement-1";
	}

	// 회원가입 이메일 입력 화면으로 이동
	@PostMapping(value = "registration/emailInput")
	public String registerationStep2(HttpSession session, String serviceTOS, String personalTOS, String marketingTOS,
			String thirdPartyTOS) {
		// 각 약관 동의 여부를 세션에 저장
		session.setAttribute("marketingTOS", marketingTOS);
		session.setAttribute("thirdPartyTOS", thirdPartyTOS);
		return "auth/registration/emailInput-2";
	}

	// 회원가입 이메일 인증 화면으로 이동
	@PostMapping(value = "registration/verification")
	public String testverification(HttpSession session) {
		return "auth/registration/verificationCode-3";
	}

	// 회원가입 비밀번호 입력 화면으로 이동
	@PostMapping(value = "registration/passwordInput")
	public String passwordInput() {
		return "auth/registration/password-input-4";
	}

	// 이메일 중복 확인 및 인증 이메일 발송
	@PostMapping(value = "registration/checkEmailDuplicate")
	@ResponseBody
	public String checkEmailDuplicate(HttpSession session, String userEmail, RedirectAttributes redirectAttributes) {
		UserDetails registrationUser = uService.loadUserByUsername(userEmail);

		// 회원가입 유저가 이미 있을 때
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

	// 이메일 인증 코드 확인
	@PostMapping(value = "/registration/verification-process", consumes = "application/json")
	public ResponseEntity<Map<String, Object>> verification(HttpSession session,
			@RequestBody Map<String, String> request) {
		String code = request.get("code");
		String verificationCode = (String) session.getAttribute("verificationCode");

		Map<String, Object> response = new HashMap<>();

		// 인증 코드 확인
		if (verificationCode != null && verificationCode.equals(code)) {
			response.put("success", true);
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "인증번호가 올바르지 않습니다.");
			return ResponseEntity.ok(response);
		}
	}

	// 인증 이메일 재발송 요청 처리
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
	
	// 회원가입 비밀번호 재입력 화면으로 이동
	@PostMapping(value = "registration/password-reinput")
	public String passwordReInput(HttpSession session, String userPassword) {
		// 비밀번호를 세션에 저장
		session.setAttribute("userPassword", userPassword);
		return "auth/registration/password-reInput-5";
	}
	
	

	/*
	 * 회원가입 정보 동의서 보기
	 */
	// [선택] 홍보 및 마케팅 이용 동의
	@GetMapping(value = "TOS/marketingTOS")
	public String readmarketingTOS() {
		return "auth/TOS/marketingTOS";
	}

	// [필수] 개인정보 수집 및 이용 동의
	@GetMapping(value = "TOS/personalTOS")
	public String readpersonalTOS() {
		return "auth/TOS/personalTOS";
	}

	// [필수] 새롬터 서비스 이용약관 동의
	@GetMapping(value = "TOS/serviceTOS")
	public String readserviceTOS() {
		return "auth/TOS/serviceTOS";
	}

	// [선택] 마케팅 개인정보 3자 제공 동의
	@GetMapping(value = "TOS/thirdPartyTOS")
	public String readthirdPartyTOS() {
		return "auth/TOS/thirdPartyTOS";
	}

	// 회원가입 END
}
