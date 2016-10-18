package it.eng.cam.rest.security.keystone.dto;

import java.io.Serializable;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class Auth implements Serializable {
    private Identity identity;

    public Identity getIdentity() {
        return identity;
    }

    public void setIdentity(Identity identity) {
        this.identity = identity;
    }
}