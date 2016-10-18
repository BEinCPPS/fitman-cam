package it.eng.cam.rest.dto;

import java.io.Serializable;

/**
 * Created by ascatolo on 17/10/2016.
 */
public class UserLoginJSON implements Serializable{

    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
