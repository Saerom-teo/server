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
	
	@Autowired
	ClientRegistrationRepository clientRepository;
	
	@GetMapping(value = "/login")
	public String login() {
		return "auth/login";
	}

	@GetMapping(value = "/registration")
	public String register() {
		return "registration";
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
	
    @GetMapping("/oauth2/authorization/google")
    public String oauth2Authorization() {
    	return "redirect:/oauth2/authorization/google";
    }
}
