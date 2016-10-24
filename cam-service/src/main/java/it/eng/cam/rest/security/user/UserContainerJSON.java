package it.eng.cam.rest.security.user;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 12/10/2016.
 */
public class UserContainerJSON implements Serializable{

    private List<User> users;
    private Object links;

    public Object getLinks() {
        return links;
    }

    public void setLinks(Object links) {
        this.links = links;
    }

    public UserContainerJSON(List<User> users) {
        this.users = users;
    }

    public UserContainerJSON() {
        this.users = new ArrayList<User>();
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
}
