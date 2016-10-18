package it.eng.cam.rest.security.oauth2;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class AuthConstants {

    public static final String KEYROCK_INSTANCE_OAUTH2_BASE_URL = "http://161.27.159.76/oauth2";
    // Client ID
    public static final String KEYROCK_CLIENT_ID = "f1298c46b29c478da511234a5864636a";

    // Client Secret
    public static final String KEYROCK_CLIENT_SECRET = "e621175748c14919b6c303b99fc911f8";

    // Redirect URI
    public static final String KEYROCK_REDIRECT_URL = "http://fc97568a.ngrok.io/CAMService/login";

    public static final String KEYROCK_GET_USER = KEYROCK_INSTANCE_OAUTH2_BASE_URL+"/user?access_token=";

}

