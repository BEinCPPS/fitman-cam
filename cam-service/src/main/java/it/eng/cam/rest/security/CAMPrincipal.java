package it.eng.cam.rest.security;

import it.eng.cam.rest.security.user.User;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class CAMPrincipal extends User implements Serializable, java.security.Principal {

    private List<String> roles;

    public CAMPrincipal() {
        roles = new ArrayList<>();
    }

    @Override
    public String getName() {
        return super.getName();
    }

    public List<String> getRoles() {return roles;}


}
