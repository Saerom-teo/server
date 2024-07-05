package com.saeromteo.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.client.web.AuthenticatedPrincipalOAuth2AuthorizedClientRepository;
import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

import com.saeromteo.app.handler.CustomAuthenticationSuccessHandler;
import com.saeromteo.app.handler.OAuth2AuthenticationFailureHandler;
import com.saeromteo.app.handler.OAuth2AuthenticationSuccessHandler;
import com.saeromteo.app.jwt.JwtAuthenticationFilter;
import com.saeromteo.app.service.user.OAuthLoginService;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    // 구글 OAuth2 클라이언트 ID
    @Value("${google.clientId}")
    private String googleClientId;

    // 구글 OAuth2 클라이언트 시크릿
    @Value("${google.clientSecret}")
    private String googleClientSecret;

    // 카카오 OAuth2 클라이언트 ID
    @Value("${kakao.clientId}")
    private String kakaoClientId;

    // 카카오 OAuth2 클라이언트 시크릿
    @Value("${kakao.clientSecret}")
    private String kakaoClientSecret;

    // 구글 OAuth2 리다이렉트 URL
    @Value("${google.redirect.url}")
    private String googleRedirectUrl;

    // 카카오 OAuth2 리다이렉트 URL
    @Value("${kakao.redirect.url}")
    private String kakaoRedirectUrl;

    @Autowired
    private JwtAuthenticationFilter jwtAuthenticationFilter;
    @Autowired
    private OAuthLoginService oAuthLoginService;
    @Autowired
    private OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler;
    @Autowired
    private OAuth2AuthenticationFailureHandler oAuth2AuthenticationFailureHandler;

    /**
     * URL 인코딩된 슬래시를 허용하는 HTTP 방화벽 설정을 반환합니다.
     *
     * @return HttpFirewall 인스턴스
     */
    @Bean
    public HttpFirewall httpFirewall() {
        DefaultHttpFirewall firewall = new DefaultHttpFirewall();
        firewall.setAllowUrlEncodedSlash(true);
        return firewall;
    }

    /**
     * 비밀번호 인코더를 반환합니다.
     *
     * @return PasswordEncoder 인스턴스
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * HttpSecurity 설정을 구성합니다.
     *
     * @param http HttpSecurity 인스턴스
     * @throws Exception 설정 오류 시 발생
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
        .csrf().disable()
        .formLogin()
        .loginPage("/auth/login")
        .and()
        .logout().disable()
        .authorizeRequests()
            .antMatchers("/swagger-ui.html", "/swagger-resources/**", "/v2/api-docs", "/webjars/**", "/resources/**", "/auth/**").permitAll()
            .antMatchers("/collection/intro", "/collection/regist", "/collection/request").permitAll() // 민교
            .antMatchers("/notice/readAll", "/faq/read", "/question/readAll").permitAll() // 대현
            .antMatchers("/products/**").permitAll() // 유라
            .antMatchers("/dashboard/**", "/news", "/envdata/**").permitAll() // 현지
            
            .antMatchers("/admin/**").hasRole("ADMIN") // 개발용
            	
            .anyRequest().authenticated()
            .and()
        .oauth2Login(oAuth -> oAuth
            .defaultSuccessUrl("/")
            .failureUrl("/fail")
            .clientRegistrationRepository(clientRegistrationRepository())
            .authorizedClientRepository(authorizedClientRepository())
            .userInfoEndpoint(userInfo -> userInfo
                .userService(oAuthLoginService))
            .successHandler(oAuth2AuthenticationSuccessHandler)
            .failureHandler(oAuth2AuthenticationFailureHandler))
        .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
    }

    /**
     * WebSecurity 설정을 구성합니다.
     *
     * @param web WebSecurity 인스턴스
     * @throws Exception 설정 오류 시 발생
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers(
                "/resources/**",
                "/static/**",
                "/swagger-ui.html",
                "/swagger-resources/**",
                "/v2/api-docs",
                "/webjars/**",
                "/collection/intro",
                "/collection/regist",
                "/collection/request",
                "/notice/readAll",
                "/faq/read",
                "/question/readAll",
                "/products/**",
                "/dashboard/**",
                "/news/**",
                "/envdata/**",
                "/"
            );
    }

    /**
     * AuthenticationManager 빈을 반환합니다.
     *
     * @return AuthenticationManager 인스턴스
     * @throws Exception 설정 오류 시 발생
     */
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    /**
     * OAuth2 클라이언트 등록 정보를 저장하는 ClientRegistrationRepository 빈을 반환합니다.
     *
     * @return ClientRegistrationRepository 인스턴스
     */
    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        return new InMemoryClientRegistrationRepository(
            createClientRegistration("google", googleClientId, googleClientSecret, googleRedirectUrl,
                "https://accounts.google.com/o/oauth2/auth",
                "https://oauth2.googleapis.com/token",
                "https://www.googleapis.com/oauth2/v3/userinfo",
                "sub", "Google",
                "https://www.googleapis.com/oauth2/v3/certs",
                "openid", "profile", "email"),
            createClientRegistration("kakao", kakaoClientId, kakaoClientSecret, kakaoRedirectUrl,
                "https://kauth.kakao.com/oauth/authorize",
                "https://kauth.kakao.com/oauth/token",
                "https://kapi.kakao.com/v2/user/me",
                "id", "Kakao", null,
                "profile_nickname", "profile_image", "account_email")
        );
    }

    /**
     * OAuth2 클라이언트 등록 정보를 생성합니다.
     *
     * @param registrationId           클라이언트 등록 ID
     * @param clientId                 클라이언트 ID
     * @param clientSecret             클라이언트 시크릿
     * @param redirectUri              리다이렉트 URI
     * @param authorizationUri         인증 URI
     * @param tokenUri                 토큰 URI
     * @param userInfoUri              사용자 정보 URI
     * @param userNameAttributeName    사용자 이름 속성 이름
     * @param clientName               클라이언트 이름
     * @param jwkSetUri                JWK 세트 URI (선택 사항)
     * @param scopes                   OAuth2 범위들
     * @return ClientRegistration 인스턴스
     */
    private ClientRegistration createClientRegistration(
        String registrationId, String clientId, String clientSecret, String redirectUri,
        String authorizationUri, String tokenUri, String userInfoUri,
        String userNameAttributeName, String clientName, String jwkSetUri, String... scopes) {

        ClientRegistration.Builder builder = ClientRegistration.withRegistrationId(registrationId)
            .clientId(clientId)
            .clientSecret(clientSecret)
            .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_POST)
            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
            .redirectUri(redirectUri)
            .authorizationUri(authorizationUri)
            .tokenUri(tokenUri)
            .userInfoUri(userInfoUri)
            .userNameAttributeName(userNameAttributeName)
            .clientName(clientName)
            .scope(scopes);

        if (jwkSetUri != null) {
            builder.jwkSetUri(jwkSetUri);
        }

        return builder.build();
    }

    /**
     * OAuth2AuthorizedClientService 빈을 반환합니다.
     *
     * @return OAuth2AuthorizedClientService 인스턴스
     */
    @Bean
    public OAuth2AuthorizedClientService authorizedClientService() {
        return new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository());
    }

    /**
     * OAuth2AuthorizedClientRepository 빈을 반환합니다.
     *
     * @return OAuth2AuthorizedClientRepository 인스턴스
     */
    @Bean
    public OAuth2AuthorizedClientRepository authorizedClientRepository() {
        return new AuthenticatedPrincipalOAuth2AuthorizedClientRepository(authorizedClientService());
    }
}