//package it.eng.cam.rest.security.oauth2;
//
//
//import org.scribe.builder.ServiceBuilder;
//import org.scribe.oauth.OAuthService;
//import org.scribe.model.OAuthRequest;
//import org.scribe.model.Response;
//import org.scribe.model.Token;
//import org.scribe.model.Verb;
//import org.scribe.model.Verifier;
//
///**
// * Created by ascatolo on 13/10/2016.
// */
//public class OAuth2Authorization {
//
//    private static final Token EMPTY_TOKEN = null;
//
//    public static Response authorize(String authorizationCode) {
//        String apiKey = AuthConstants.KEYROCK_CLIENT_ID;
//        String apiSecret = AuthConstants.KEYROCK_CLIENT_SECRET;
//        String callbackUrl = AuthConstants.KEYROCK_REDIRECT_URL;
//        OAuthService service = new ServiceBuilder().provider(KeyrockApi.class)
//                .apiKey(apiKey).apiSecret(apiSecret).callback(callbackUrl)
//                .build();
//        // Obtain the Authorization URL
//        String authorizationUrl = service.getAuthorizationUrl(EMPTY_TOKEN);
//        Verifier verifier = new Verifier(authorizationCode);
//        Token accessToken = service.getAccessToken(EMPTY_TOKEN, verifier);
//        OAuthRequest request = new OAuthRequest(Verb.GET, AuthConstants.KEYROCK_GET_USER);
//        service.signRequest(accessToken, request);
//        Response response = request.send();
//        return response;
//    }
//
//
//}
