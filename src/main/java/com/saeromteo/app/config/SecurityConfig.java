package com.saeromteo.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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

import com.saeromteo.app.handler.OAuth2AuthenticationFailureHandler;
import com.saeromteo.app.handler.OAuth2AuthenticationSuccessHandler;
import com.saeromteo.app.jwt.JwtAuthenticationFilter;
import com.saeromteo.app.service.user.OAuthLoginService;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
    @Value("${google.clientId}")
    private String googleClientId;

    @Value("${google.clientSecret}")
    private String googleClientSecret;

    @Value("${kakao.clientId}")
    private String kakaoClientId;

    @Value("${kakao.clientSecret}")
    private String kakaoClientSecret;

    @Value("${google.redirect.url}")
    private String googleRedirectUrl;

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
    @Bean
    public HttpFirewall httpFirewall() {
        DefaultHttpFirewall firewall = new DefaultHttpFirewall();
        firewall.setAllowUrlEncodedSlash(true);
        return firewall;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .httpBasic().disable()
            .formLogin().disable()
            .logout().disable()
            .authorizeRequests()
                .antMatchers("/resources/**").permitAll()
                .antMatchers("/**", "/auth/**", "/webjars/**").permitAll()
                .antMatchers("/swagger-ui.html", "/swagger-resources/**", "/v2/api-docs", "/webjars/**").permitAll()
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
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**", "/static/**");
    }

    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

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

    @Bean
    public OAuth2AuthorizedClientService authorizedClientService() {
        return new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository());
    }

    @Bean
    public OAuth2AuthorizedClientRepository authorizedClientRepository() {
        return new AuthenticatedPrincipalOAuth2AuthorizedClientRepository(authorizedClientService());
    }
}
