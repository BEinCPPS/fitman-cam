package it.eng.cam.rest.security.authentication.credentials.json;

import java.io.Serializable;

/**
 * Created by ascatolo on 13/10/2016.
 */

public class User implements Serializable {
    private String name;
    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public User(String name, Domain domain, String password) {
        this.name = name;
        this.domain = domain;
        this.password = password;
    }

    public User() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Domain getDomain() {
        return domain;
    }

    public void setDomain(Domain domain) {
        this.domain = domain;
    }

    private Domain domain;

}