package com.saeromteo.app.controller.user;

import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@Controller
public class OAuth2Controller {

    private final ClientRegistrationRepository clientRegistrationRepository;
    private final RestTemplate restTemplate = new RestTemplate();

    public OAuth2Controller(ClientRegistrationRepository clientRegistrationRepository) {
        this.clientRegistrationRepository = clientRegistrationRepository;
    }

    @GetMapping("/oauth2/authorization/google")
    public void googleLogin(HttpServletResponse response) throws IOException {
        String authorizationUri = getAuthorizationUri("google");
        System.out.println("Redirecting to Google for authorization: " + authorizationUri);
        response.sendRedirect(authorizationUri);
    }

    @GetMapping("/oauth2/authorization/kakao")
    public void kakaoLogin(HttpServletResponse response) throws IOException {
        String authorizationUri = getAuthorizationUri("kakao");
        System.out.println("Redirecting to Kakao for authorization: " + authorizationUri);
        response.sendRedirect(authorizationUri);
    }

    private String getAuthorizationUri(String registrationId) {
        var clientRegistration = clientRegistrationRepository.findByRegistrationId(registrationId);
        String authorizationUri = UriComponentsBuilder.fromUriString(clientRegistration.getProviderDetails().getAuthorizationUri())
            .queryParam("response_type", "code")
            .queryParam("client_id", clientRegistration.getClientId())
            .queryParam("redirect_uri", clientRegistration.getRedirectUri())
            .queryParam("scope", String.join(" ", clientRegistration.getScopes()))
            .queryParam("state", "some_random_state")
            .build().toUriString();
        System.out.println("Authorization URI for " + registrationId + ": " + authorizationUri);
        return authorizationUri;
    }

    @GetMapping("/login/oauth2/code/google")
    public String googleCallback(@RequestParam String code, HttpServletRequest request) {
        System.out.println("Received Google callback with code: " + code);
        return handleOAuth2Callback("google", code, request);
    }

    @GetMapping("/login/oauth2/code/kakao")
    public String kakaoCallback(@RequestParam String code, HttpServletRequest request) {
        System.out.println("Received Kakao callback with code: " + code);
        return handleOAuth2Callback("kakao", code, request);
    }

    private String handleOAuth2Callback(String registrationId, String code, HttpServletRequest request) {
        var clientRegistration = clientRegistrationRepository.findByRegistrationId(registrationId);

        System.out.println("Exchanging code for access token for " + registrationId);
        var tokenResponse = restTemplate.postForEntity(
            clientRegistration.getProviderDetails().getTokenUri(),
            Map.of(
                "grant_type", "authorization_code",
                "code", code,
                "redirect_uri", clientRegistration.getRedirectUri(),
                "client_id", clientRegistration.getClientId(),
                "client_secret", clientRegistration.getClientSecret()
            ),
            Map.class
        ).getBody();

        String accessToken = (String) tokenResponse.get("access_token");
        System.out.println("Received access token: " + accessToken);

        System.out.println("Fetching user info from " + clientRegistration.getProviderDetails().getUserInfoEndpoint().getUri());
        var userInfoResponse = restTemplate.getForEntity(
            UriComponentsBuilder.fromUriString(clientRegistration.getProviderDetails().getUserInfoEndpoint().getUri())
                .queryParam("access_token", accessToken)
                .build().toUriString(),
            Map.class
        ).getBody();

        System.out.println("Received user info: " + userInfoResponse);

        // 여기서 사용자 정보를 처리하고 세션을 설정합니다.
        request.getSession().setAttribute("user", userInfoResponse);

        return "redirect:/";
    }
}
