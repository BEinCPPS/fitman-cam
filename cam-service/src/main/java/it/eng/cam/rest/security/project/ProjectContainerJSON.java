package it.eng.cam.rest.security.project;

import it.eng.cam.rest.security.user.User;

import java.io.Serializable;
import java.util.List;

/**
 * Created by ascatolo on 02/11/2016.
 */
public class ProjectContainerJSON implements Serializable {

    private Object links;
    private List<Project> projects;

    public List<Project> getProjects() {
        return projects;
    }

    public void setProjects(List<Project> projects) {
        this.projects = projects;
    }

    public Object getLinks() {
        return links;
    }

    public void setLinks(Object links) {
        this.links = links;
    }
}
