package com.saeromteo.app.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.saeromteo.app.dto.user.UserLoginDTO;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.service.user.EmailService;
import com.saeromteo.app.service.user.OAuthLoginService;
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
	
	@Autowired
	OAuthLoginService oAuthLoginService;

	/*
	 * 로그인
	 */
	//login url
	@GetMapping(value = "/login")
	public String login() {
		return "auth/login";
	}
	//일반 유저 로그인 process
	@PostMapping(value = "/loginProcess")
	public ResponseEntity<String> login(@RequestBody UserLoginDTO mem) {
		try {
			UserDetails user = uService.loadUserByUsername(mem.getUsername());
			if (user == null)
				throw new IllegalArgumentException("가입되지 않은 유저입니다.");
			if (!passwordEncoder.matches(mem.getPassword(), user.getPassword())) {
				throw new IllegalArgumentException("잘못된 비밀번호");
			}
			String token = jwtUtil.generateToken(mem);
			return ResponseEntity.ok(token);
		} catch (IllegalArgumentException e) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
		}
	}
	
	//여기가 oAuthLogin 성공시 redirect URL 인데 여기서  
	//http://localhost:9090/saeromteo/auth/oAuthLoginSuccess?state=1qkPh6OC5bU-6gOeZoI-ehB83wESG1Rg9vVQKUt61js%3D&code=4%2F0ATx3LY6-coRa-PHENxRoS2GkH9K4FzbRLcpegwVisywQG-6X6e_o-K55pBSxj1JMH_ieAg&scope=email+profile+openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email&authuser=0&prompt=consent
	//이 데이터 처리해야 할거 같은데 
	@GetMapping("/oAuthLoginSuccess")
	public String oAuthLoginSuccess(@RequestParam("token") String token, Model model) {
		// token을 model에 추가하여 JSP 페이지로 전달
		oAuthLoginService.loadUser(null);
		model.addAttribute("token", token);
		return "loginSuccess"; // loginSuccess.jsp 페이지를 반환
	}
	//oAuth login Success jsp (토큰 저장)
	@GetMapping(value = "auth/loginSuccess")
	public String oAuthLogin() {
		return "auth/oAuthLoign-success";
	}
	


	// 로그인 END

	/*
	 * 회원가입
	 */
	// 회원가입 약관 동의화면

	@GetMapping(value = "/registration")
	public String registerationStep1() {
		return "auth/registration/serviceAgreement_1";
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
		return "auth/registration/emailInput_2";
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
			emailService.sendSimpleMessage(userEmail, "새롬터 회원가입 인증 이메일입니다.",
					"새롬터 회원가입 인증 번호는" + verificationCode + "입니다.");
			session.setAttribute("registrationUserEmail", userEmail);
			session.setAttribute("verificationCode", verificationCode);
			return "new_user";
		}
	}

	@PostMapping(value = "registration/verification")
	public String verification(HttpSession session) {
		return "auth/registration/verificationCode_3";
	}

	// 이메일 인증
	@PostMapping(value = "/registration/verification_process")
	public void verification(HttpSession session, String code) {
		String verificationCode = (String) session.getAttribute("verificationCode");

		// 인증성공
		if (verificationCode.equals(code)) {

		} else { // 인증 실패

		}
	}

	// 재발송 요구 할때
	@GetMapping(value = "registration/reSend")
	public void reSendEmail(HttpSession session) {
		String email = (String) session.getAttribute("registrationUserEmail");
		session.removeAttribute("verificationCode");
		String verificationCode = emailService.randomNumber();
		emailService.sendSimpleMessage(email, "새롬터 회원가입 인증 이메일입니다.", "새롬터 회원가입 인증 번호는" + verificationCode + "입니다.");
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
