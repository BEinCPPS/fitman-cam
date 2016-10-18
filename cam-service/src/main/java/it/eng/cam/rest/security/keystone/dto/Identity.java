package it.eng.cam.rest.security.keystone.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class Identity implements Serializable {
    private List<String> methods;
    private Password password;

    public Identity() {
        this.methods = new ArrayList<String>();
        methods.add("password");
    }


    public List<String> getMethods() {
        return methods;
    }

    public void setMethods(List<String> methods) {
        this.methods = methods;
    }

    public Password getPassword() {
        return password;
    }

    public void setPassword(Password password) {
        this.password = password;
    }
}