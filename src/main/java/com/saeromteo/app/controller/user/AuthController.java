package com.saeromteo.app.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.user.UserLoginDTO;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.service.user.UserLoginService;

@Controller
@RequestMapping("/auth")
public class AuthController {
	@Autowired
	@Qualifier("userLoginService")
	UserLoginService uService;

	@Qualifier("passwordEncoder")
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JWTUtil jwtUtil;
	
	
	/*
	 * 회원가입 
	 */
	@GetMapping(value = "/registration")
	public String registeration() {
		return "auth/registration/serviceAgreement_1";
	}
	
	/*
	 * 회원가입 정보 동의서 보여주기 
	 */
	//[선택] 홍보 및 마케팅 이용 동의
	@GetMapping(value = "TOS/marketingTOS")
	public String readmarketingTOS() {
		return "auth/TOS/marketingTOS";
	}
	//[필수] 개인정보 수집 · 이용 동의
	@GetMapping(value = "TOS/personalTOS")
	public String readpersonalTOS() {
		return "auth/TOS/personalTOS";
	}
	//[필수] 새롬터 서비스 이용약관 동의
	@GetMapping(value = "TOS/serviceTOS")
	public String readserviceTOS() {
		return "auth/TOS/serviceTOS";
	}
	//[선택] 마케팅 개인정보 3자 제공 동의
	@GetMapping(value = "TOS/thirdPartyTOS")
	public String readthirdPartyTOS() {
		return "auth/TOS/thirdPartyTOS";
	}
	
	@GetMapping(value="registration/personalVerification_2")
	public String registeration2() {
		
		return "auth/registration/personalVerification_2";
	}
	//회원가입 END

	
	
	/*
	 * 로그인
	 */
	@GetMapping(value = "/login")
	public String login() {
		return "auth/login";
	}

	@PostMapping(value = "/login")
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
	
	//로그인 END
}
