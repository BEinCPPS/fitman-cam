package it.eng.cam.rest.security.authentication.credentials.json;

import java.io.Serializable;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class Credentials implements Serializable{

    Auth auth;

    public Auth getAuth() {
        return auth;
    }

    public void setAuth(Auth auth) {
        this.auth = auth;
    }
}
