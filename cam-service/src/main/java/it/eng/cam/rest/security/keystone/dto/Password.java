package it.eng.cam.rest.security.keystone.dto;

import java.io.Serializable;

/**
 * Created by ascatolo on 13/10/2016.
 */


public class Password implements Serializable {
    private User user;


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }


}