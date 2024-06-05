package com.saeromteo.app.user;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.security.JWTUtil;

@RestController
public class UserController {
	@Autowired
	@Qualifier("userLoginService")
	UserLoginService uService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JWTUtil jwtUtil;
	
	@GetMapping(value = "auth/login")
	public String login() {
		UserDetails test = new UserLoginDTO("test1@example.com","1234");
		String token = jwtUtil.generateToken(test);
		System.out.println(jwtUtil.validateToken(token));
		System.out.println(token);
		return "auth/login";
	}

	@GetMapping(value = "auth/register")
	public String register() {
		return "auth/register";
	}

	@PostMapping("user/login")
	public @ResponseBody String login(UserLoginDTO mem) {
		System.out.println("@PostMapping:" + mem);
		
		
		UserDetails user = uService.loadUserByUsername(mem.getUsername());
		
		if (user == null)
			throw new IllegalArgumentException("가입되지 않은 유저입니다.");
		System.out.println("user:" + user);

		if (!passwordEncoder.matches(mem.getPassword(), user.getPassword())) {
			throw new IllegalArgumentException("잘못된 비밀번호");
		}

		List<String> roles = user.getAuthorities().stream().map((a) -> a.getAuthority()).collect(Collectors.toList());
		String token = jwtUtil.generateToken(mem);
		System.out.println(token);
		// return "redirect:/board/selectAll.do";
		return token;
	}
	
	@GetMapping(value = "admin/login")
	public String aogin(UserLoginDTO mem) {
		
		return null;
	}



}
