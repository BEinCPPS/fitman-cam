package it.eng.cam.rest.security.authentication;

import it.eng.cam.rest.security.authentication.credentials.Credentials;
import it.eng.cam.rest.security.roles.Role;
import it.eng.cam.rest.security.user.User;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class CAMPrincipal extends User implements Serializable, java.security.Principal {

    private List<String> roles;
    private List<Organization> organizations;

    public CAMPrincipal() {
        roles = new ArrayList<>();
        organizations = new ArrayList<>();
    }

    @Override
    public String getName() {
        return super.getName();
    }

    public List<String> getRoles() {
        return roles;
    }

    public List<Organization> getOrganizations() {
        return organizations;
    }

    public boolean isAdmin() {
        if (getRoles().contains(Role.ADMIN))
            return true;
        return false;
    }


    public static class Organization implements Serializable {
        private int id;
        private String name;
        private List<String> roles;

        public Organization() {
            this.roles = new ArrayList<>();
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public List<String> getRoles() {
            return roles;
        }

    }

}
