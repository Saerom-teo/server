package com.saeromteo.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.client.web.AuthenticatedPrincipalOAuth2AuthorizedClientRepository;
import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;

@Configuration
@EnableWebSecurity
public class OAuthConfig {
	// Google OAuth 클라이언트 ID를 설정 파일로부터 주입받습니다.
	@Value("${google.clientId}")
	private String googleClientId;

	// Google OAuth 클라이언트 시크릿을 설정 파일로부터 주입받습니다.
	@Value("${google.clientSecret}")
	private String googleClientSecret;

	// Autowire를 통해 주입된 AuthenticationManager 빈을 참조합니다.
	@Qualifier("authenticationManager")
	private final AuthenticationManager authenticationManager;

	// 생성자를 통해 AuthenticationManager를 주입받습니다.
	@Autowired
	public OAuthConfig(AuthenticationManager authenticationManager) {
		this.authenticationManager = authenticationManager;
	}

	/**
	 * 클라이언트 등록 리포지토리를 생성합니다. 여러 클라이언트 등록 정보를 저장하고 관리합니다.
	 * 
	 * @return ClientRegistrationRepository 객체
	 */
	@Bean
	public ClientRegistrationRepository clientRegistrationRepository() {
		// InMemoryClientRegistrationRepository를 사용하여 Google 클라이언트 등록 정보를 저장합니다.
		return new InMemoryClientRegistrationRepository(this.googleClientRegistration());
	}

	/**
	 * Google OAuth 클라이언트 등록 정보를 생성합니다.
	 * 
	 * @return Google 클라이언트 등록 정보
	 */
	@Bean
	public ClientRegistration googleClientRegistration() {
		// Google 클라이언트 등록 정보를 구성합니다.
		System.out.println(googleClientId);
		System.out.println(googleClientSecret);
		return ClientRegistration.withRegistrationId("google").clientId(googleClientId) // Google 클라이언트 ID
				.clientSecret(googleClientSecret) // Google 클라이언트 시크릿
				.clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC) // 클라이언트 인증 방법
				.authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE) // 인증 코드 그랜트 타입
				.redirectUri("http://localhost:9090/saeromteo/") // 리디렉션 URI
				.scope("openid", "profile", "email") // 요청할 OAuth 범위
				.authorizationUri("https://accounts.google.com/o/oauth2/auth") // 인증 요청 URI
				.tokenUri("https://oauth2.googleapis.com/token") // 토큰 요청 URI
				.userInfoUri("https://www.googleapis.com/oauth2/v3/userinfo") // 사용자 정보 요청 URI
				.userNameAttributeName("sub") // 사용자 이름 속성
				.jwkSetUri("https://www.googleapis.com/oauth2/v3/certs") // JSON Web Key Set URI
				.clientName("Google") // 클라이언트 이름
				.build();
	}

	/**
	 * OAuth2AuthorizedClientRepository 빈을 생성합니다. OAuth2 클라이언트를 인증된 사용자와 연관짓는 역할을
	 * 합니다.
	 * 
	 * @return OAuth2AuthorizedClientRepository 객체
	 */
	@Bean
	public OAuth2AuthorizedClientRepository authorizedClientRepository() {
		// InMemoryOAuth2AuthorizedClientService를 사용하여 인가된 클라이언트를 저장하고 관리합니다.
		return new AuthenticatedPrincipalOAuth2AuthorizedClientRepository(authorizedClientService());
	}

	/**
	 * OAuth2AuthorizedClientService 빈을 생성합니다. OAuth2 클라이언트의 인가된 정보를 관리합니다.
	 * 
	 * @return OAuth2AuthorizedClientService 객체
	 */
	@Bean
	public OAuth2AuthorizedClientService authorizedClientService() {
		// 클라이언트 등록 리포지토리를 사용하여 InMemoryOAuth2AuthorizedClientService를 생성합니다.
		return new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository());
	}
}
