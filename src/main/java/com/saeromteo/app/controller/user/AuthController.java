package com.saeromteo.app.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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
import com.saeromteo.app.dto.user.PrincipalDetail;
import com.saeromteo.app.dto.user.UserDTO;
import com.saeromteo.app.jwt.JWTUtil;
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
	 * 로그인
	 */
	// login url
	@GetMapping(value = "/login")
	public String login() {
		return "auth/login";
	}

	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public void loginProcess(@RequestBody PrincipalDetail mem, HttpServletResponse response) throws IOException {
		Map<String, Object> responseData = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();

		try {
			PrincipalDetail dataUser = uService.loadUserByUsername(mem.getUsername());
			UserDTO user = dataUser.getUser();
			if (user == null) {
				responseData.put("message", "not_user");
				response.setStatus(HttpStatus.NOT_FOUND.value());
				response.setContentType("application/json");
				response.getWriter().write(mapper.writeValueAsString(responseData));
				return;
			}
			if (!passwordEncoder.matches(mem.getPassword(), user.getUserPassword())) {
				responseData.put("message", "not_Match");
				response.setStatus(HttpStatus.UNAUTHORIZED.value());
				response.setContentType("application/json");
				response.getWriter().write(mapper.writeValueAsString(responseData));
				return;
			}
			String token = jwtUtil.generateToken(mem);
			responseData.put("token", token);
			response.setStatus(HttpStatus.OK.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		} catch (IllegalArgumentException e) {
			System.out.println("IllegalArgumentException");
			responseData.put("message", e.getMessage());
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		} catch (JsonProcessingException e) {
			System.out.println("JSON 처리 중 오류 발생");
			responseData.put("message", "JSON 처리 중 오류 발생");
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		} catch (Exception e) {
			System.out.println("서버 에러 발생");
			responseData.put("message", "서버 에러 발생");
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			response.setContentType("application/json");
			response.getWriter().write(mapper.writeValueAsString(responseData));
		}
	}

	// 로그인 END

	/*
	 * 회원가입
	 */
	// 회원가입 약관 동의화면

	@GetMapping(value = "/registration")
	public String registerationStep1() {
		return "auth/registration/serviceAgreement-1";
	}

	// 회원가입 이메일 입력 화면
	@PostMapping(value = "registration/emailInput")
	public String registerationStep2(HttpSession session, String serviceTOS, String personalTOS, String marketingTOS,
			String thirdPartyTOS) {
		// agree => on , disagree => null
		session.setAttribute("serviceTOS", serviceTOS);
		session.setAttribute("personalTOS", personalTOS);
		session.setAttribute("marketingTOS", marketingTOS);
		session.setAttribute("thirdPartyTOS", thirdPartyTOS);
		return "auth/registration/emailInput-2";
	}
	
	@PostMapping(value = "registration/verification")
	public String testverification(HttpSession session) {
		return "auth/registration/verificationCode-3";
	}

	@PostMapping(value = "registration/passwordInput")
	public String passwordInput() {
		return "auth/registration/password-input-4";
	}

	@PostMapping(value = "registration/passwordReInput")
	public String passwordReInput() {
		return "auth/registration/password-reInput-5";
	}

	// 이메일 인증
	@PostMapping(value = "registration/checkEmailDuplicate")
	@ResponseBody
	public String checkEmailDuplicate(HttpSession session, String userEmail, RedirectAttributes redirectAttributes) {
		UserDetails registrationUser = uService.loadUserByUsername(userEmail);
		// 회원가입 유저가 이미 있을때
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

	// 이메일 인증
	@PostMapping(value = "/registration/verification-process", consumes = "application/json")
	public ResponseEntity<Map<String, Object>> verification(HttpSession session,
			@RequestBody Map<String, String> request) {
		String code = request.get("code");
		String verificationCode = (String) session.getAttribute("verificationCode");

		Map<String, Object> response = new HashMap<>();
		if (verificationCode != null && verificationCode.equals(code)) {
			session.setAttribute("isVerified", true);
			response.put("success", true);
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "인증번호가 올바르지 않습니다.");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}
	}

	// 재발송 요구 할때
	@GetMapping(value = "registration/reSend")
	public void reSendEmail(HttpSession session) {
		String email = (String) session.getAttribute("registrationUserEmail");
		session.removeAttribute("verificationCode");
		String verificationCode = emailService.randomNumber();
		emailService.sendSimpleMessage(email, "새롬터 회원가입 인증 이메일입니다.", verificationCode);
		session.setAttribute("verificationCode", verificationCode);
	}

	/*
	 * 회원가입 정보 동의서 보여주기
	 */
	// [선택] 홍보 및 마케팅 이용 동의
	@GetMapping(value = "TOS/marketingTOS")
	public String readmarketingTOS() {
		return "auth/TOS/marketingTOS";
	}

	// [필수] 개인정보 수집 · 이용 동의
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
