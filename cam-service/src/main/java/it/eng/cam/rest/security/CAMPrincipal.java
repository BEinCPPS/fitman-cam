package it.eng.cam.rest.security;

import it.eng.cam.rest.dto.UserJSON;

import java.io.Serializable;
import java.util.List;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class CAMPrincipal extends UserJSON implements Serializable, java.security.Principal {

    private List<String> role;

    @Override
    public String getName() {
        return super.getName();
    }

    public List<String> getRole() {return role;}
    public void setRole(List<String> role) {this.role = role;}

}
