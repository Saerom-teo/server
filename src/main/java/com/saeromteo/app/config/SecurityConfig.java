package com.saeromteo.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

import com.saeromteo.app.handler.OAuth2AuthenticationSuccessHandler;
import com.saeromteo.app.jwt.JwtAuthenticationFilter;
import com.saeromteo.app.service.user.OAuthLoginService;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = "com.saeromteo.app")
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    @Autowired
    private final ClientRegistrationRepository clientRegistrationRepository;
    @Autowired
    @Qualifier("oAuthService")
    private final OAuthLoginService OAuthLoginService;
    @Autowired
    private OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler;

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
            .httpBasic(AbstractHttpConfigurer::disable)
            .formLogin(AbstractHttpConfigurer::disable)
            .logout(AbstractHttpConfigurer::disable)
            .authorizeRequests()
                .antMatchers("/resources/**").permitAll()
                .antMatchers("/**", "/auth/**", "/webjars/**").permitAll()
                .antMatchers("/swagger-ui.html", "/swagger-resources/**", "/v2/api-docs", "/webjars/**").permitAll()
                .anyRequest().authenticated()
                .and()
            .oauth2Login()
            .clientRegistrationRepository(clientRegistrationRepository)
            	.successHandler(oAuth2AuthenticationSuccessHandler)
                .userInfoEndpoint()
                .userService(OAuthLoginService)
                .and()
                .and()
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**", "/static/**");
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
