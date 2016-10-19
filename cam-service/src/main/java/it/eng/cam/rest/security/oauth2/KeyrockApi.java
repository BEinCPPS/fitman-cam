//
//package it.eng.cam.rest.security.oauth2;
//
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
//
//import org.scribe.builder.api.DefaultApi20;
//import org.scribe.exceptions.OAuthException;
//import org.scribe.extractors.AccessTokenExtractor;
//import org.scribe.model.OAuthConfig;
//import org.scribe.model.OAuthConstants;
//import org.scribe.model.OAuthRequest;
//import org.scribe.model.Response;
//import org.scribe.model.Token;
//import org.scribe.model.Verb;
//import org.scribe.model.Verifier;
//import org.scribe.oauth.OAuth20ServiceImpl;
//import org.scribe.oauth.OAuthService;
//import org.scribe.utils.OAuthEncoder;
//import org.scribe.utils.Preconditions;
//
///**
// * Google OAuth2.0 Released under the same license as scribe (MIT License)
// *
// * @author yincrash
// */
//public class KeyrockApi extends DefaultApi20 {
//
//    private static final String AUTHORIZE_URL = AuthConstants.KEYROCK_INSTANCE_OAUTH2_BASE_URL +
//            "/authorize?response_type=code&client_id=%s&redirect_uri=%s";
//
//    @Override
//    public String getAccessTokenEndpoint() {
//        return AuthConstants.KEYROCK_INSTANCE_OAUTH2_BASE_URL + "/token";
//    }
//
//    @Override
//    public AccessTokenExtractor getAccessTokenExtractor() {
//        return new AccessTokenExtractor() {
//
//            @Override
//            public Token extract(String response) {
//                Preconditions
//                        .checkEmptyString(response,
//                                "Response body is incorrect. Can't extract a token from an empty string");
//
//                Matcher matcher = Pattern.compile(
//                        "\"access_token\" : \"([^&\"]+)\"").matcher(response);
//                if (matcher.find()) {
//                    String token = OAuthEncoder.decode(matcher.group(1));
//                    return new Token(token, "", response);
//                } else {
//                    throw new OAuthException(
//                            "Response body is incorrect. Can't extract a token from this: '"
//                                    + response + "'", null);
//                }
//            }
//        };
//    }
//
//    @Override
//    public String getAuthorizationUrl(OAuthConfig config) {
//        return String.format(AUTHORIZE_URL, config.getApiKey(),
//                OAuthEncoder.encode(config.getCallback()));
//    }
//
//    @Override
//    public Verb getAccessTokenVerb() {
//        return Verb.POST;
//    }
//
//    @Override
//    public OAuthService createService(OAuthConfig config) {
//        return new KeyrockAuth2Service(this, config);
//    }
//
//    private class KeyrockAuth2Service extends OAuth20ServiceImpl {
//
//        private static final String GRANT_TYPE_AUTHORIZATION_CODE = "authorization_code";
//        private static final String GRANT_TYPE = "grant_type";
//        private DefaultApi20 api;
//        private OAuthConfig config;
//
//        public KeyrockAuth2Service(DefaultApi20 api, OAuthConfig config) {
//            super(api, config);
//            this.api = api;
//            this.config = config;
//        }
//
//        @Override
//        public Token getAccessToken(Token requestToken, Verifier verifier) {
//            OAuthRequest request = new OAuthRequest(api.getAccessTokenVerb(),
//                    api.getAccessTokenEndpoint());
//            switch (api.getAccessTokenVerb()) {
//                case POST:
//                    request.addBodyParameter(OAuthConstants.CLIENT_ID,
//                            config.getApiKey());
//                    request.addBodyParameter(OAuthConstants.CLIENT_SECRET,
//                            config.getApiSecret());
//                    request.addBodyParameter(OAuthConstants.CODE,
//                            verifier.getValue());
//                    request.addBodyParameter(OAuthConstants.REDIRECT_URI,
//                            config.getCallback());
//                    request.addBodyParameter(GRANT_TYPE,
//                            GRANT_TYPE_AUTHORIZATION_CODE);
//                    break;
//                case GET:
//                default:
//                    request.addQuerystringParameter(OAuthConstants.CLIENT_ID,
//                            config.getApiKey());
//                    request.addQuerystringParameter(OAuthConstants.CLIENT_SECRET,
//                            config.getApiSecret());
//                    request.addQuerystringParameter(OAuthConstants.CODE,
//                            verifier.getValue());
//                    request.addQuerystringParameter(OAuthConstants.REDIRECT_URI,
//                            config.getCallback());
//                    if (config.hasScope())
//                        request.addQuerystringParameter(OAuthConstants.SCOPE,
//                                config.getScope());
//            }
//            Response response = request.send();
//            return api.getAccessTokenExtractor().extract(response.getBody());
//        }
//    }
//
//}