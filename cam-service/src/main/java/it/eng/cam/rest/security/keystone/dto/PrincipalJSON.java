package it.eng.cam.rest.security.keystone.dto;

import java.io.Serializable;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class PrincipalJSON implements Serializable{

    Auth auth;

    public Auth getAuth() {
        return auth;
    }

    public void setAuth(Auth auth) {
        this.auth = auth;
    }
}
