//package com.saeromteo.app.config;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
//import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
//import org.springframework.security.oauth2.client.registration.ClientRegistration;
//import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
//import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
//import org.springframework.security.oauth2.client.web.AuthenticatedPrincipalOAuth2AuthorizedClientRepository;
//import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
//import org.springframework.security.oauth2.core.AuthorizationGrantType;
//import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
//
//@Configuration
//@EnableWebSecurity
//public class OAuthConfig {
//
//    @Value("${google.clientId}")
//    private String googleClientId;
//
//    @Value("${google.clientSecret}")
//    private String googleClientSecret;
//
//    @Value("${kakao.clientId}")
//    private String kakaoClientId;
//
//    @Value("${kakao.clientSecret}")
//    private String kakaoClientSecret;
//
//    @Value("${google.redirect.url}")
//    private String googleRedirectUrl;
//
//    @Value("${kakao.redirect.url}")
//    private String kakaoRedirectUrl;
//
//    @Bean
//    public ClientRegistrationRepository clientRegistrationRepository() {
//        return new InMemoryClientRegistrationRepository(
//            createClientRegistration("google", googleClientId, googleClientSecret, googleRedirectUrl,
//                "https://accounts.google.com/o/oauth2/auth", 
//                "https://oauth2.googleapis.com/token",
//                "https://www.googleapis.com/oauth2/v3/userinfo", 
//                "sub", "Google", 
//                "https://www.googleapis.com/oauth2/v3/certs",
//                "openid", "profile", "email"),
//            createClientRegistration("kakao", kakaoClientId, kakaoClientSecret, kakaoRedirectUrl,
//                "https://kauth.kakao.com/oauth/authorize", 
//                "https://kauth.kakao.com/oauth/token",
//                "https://kapi.kakao.com/v2/user/me", 
//                "id", "Kakao", null,
//                "profile_nickname", "profile_image", "account_email")
//        );
//    }
//
//    private ClientRegistration createClientRegistration(
//        String registrationId, String clientId, String clientSecret, String redirectUri,
//        String authorizationUri, String tokenUri, String userInfoUri, 
//        String userNameAttributeName, String clientName, String jwkSetUri, String... scopes) {
//
//        ClientRegistration.Builder builder = ClientRegistration.withRegistrationId(registrationId)
//            .clientId(clientId)
//            .clientSecret(clientSecret)
//            .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
//            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
//            .redirectUri(redirectUri)
//            .authorizationUri(authorizationUri)
//            .tokenUri(tokenUri)
//            .userInfoUri(userInfoUri)
//            .userNameAttributeName(userNameAttributeName)
//            .clientName(clientName)
//            .scope(scopes);
//
//        if (jwkSetUri != null) {
//            builder.jwkSetUri(jwkSetUri);
//        }
//
//        return builder.build();
//    }
//
//    @Bean
//    public OAuth2AuthorizedClientService authorizedClientService() {
//        return new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository());
//    }
//
//    @Bean
//    public OAuth2AuthorizedClientRepository authorizedClientRepository() {
//        return new AuthenticatedPrincipalOAuth2AuthorizedClientRepository(authorizedClientService());
//    }
//
//}
