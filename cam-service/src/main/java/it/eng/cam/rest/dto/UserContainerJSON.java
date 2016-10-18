package it.eng.cam.rest.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 12/10/2016.
 */
public class UserContainerJSON implements Serializable{

    private List<UserJSON> users;
    private Object links;

    public Object getLinks() {
        return links;
    }

    public void setLinks(Object links) {
        this.links = links;
    }

    public UserContainerJSON(List<UserJSON> users) {
        this.users = users;
    }

    public UserContainerJSON() {
        this.users = new ArrayList<UserJSON>();
    }

    public List<UserJSON> getUsers() {
        return users;
    }

    public void setUsers(List<UserJSON> users) {
        this.users = users;
    }
}
