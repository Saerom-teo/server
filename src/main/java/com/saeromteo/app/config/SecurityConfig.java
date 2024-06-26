package com.saeromteo.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = "com.saeromteo.app")
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    // OAuthConfig에서 정의한 클라이언트 등록 리포지토리와 인증된 클라이언트 리포지토리를 주입받습니다.
    @Autowired
    private OAuthConfig oAuthConfig;

    // HTTP 방화벽 설정을 위한 빈 정의
    @Bean
    public HttpFirewall httpFirewall() {
        DefaultHttpFirewall firewall = new DefaultHttpFirewall();
        firewall.setAllowUrlEncodedSlash(true); // URL 인코딩된 슬래시 허용 설정
        return firewall;
    }

    // PasswordEncoder 빈 정의
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // HttpSecurity 설정을 통해 보안 구성을 정의합니다.
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable() // CSRF 보호 비활성화
            .authorizeRequests()
                .antMatchers("/resources/**").permitAll() // /resources/** 패턴에 대한 보안 비활성화
                .antMatchers("/**", "/login**", "/webjars/**").permitAll() //
                .antMatchers("/auth/**").permitAll() // /auth/** 패턴에 대한 접근 권한 허용
                .antMatchers("/admin/**").hasRole("ADMIN") // /admin/** 패턴에 대한 접근 권한 관리자에게만 허용
                .antMatchers("/swagger-ui.html", "/swagger-resources/**", "/v2/api-docs", "/webjars/**").permitAll() // Swagger 경로에 대한 접근 허용
                .anyRequest().authenticated() // 그 외 모든 요청에 대해 인증 요구
            .and().formLogin().loginPage("/auth/login").permitAll().and()
            .oauth2Login()
                .clientRegistrationRepository(oAuthConfig.clientRegistrationRepository()) // OAuth2 로그인 설정 - 클라이언트 등록 리포지토리
                .authorizedClientRepository(oAuthConfig.authorizedClientRepository())
                .defaultSuccessUrl("/")
                .userInfoEndpoint();

        http.setSharedObject(HttpFirewall.class, httpFirewall()); // HTTP 방화벽 설정 적용
    }
    
    @Override
    public void configure(WebSecurity web) throws Exception {
        // 정적 리소스 무시 설정
        web.ignoring().antMatchers("/resources/**", "/static/**");
    }

    // AuthenticationManager 빈 정의
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
