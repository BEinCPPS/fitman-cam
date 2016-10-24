package it.eng.cam.rest.security.user;

import java.io.Serializable;

/**
 * Created by ascatolo on 12/10/2016.
 */
public class User implements Serializable {

    private String username;
    private String name;
    private Boolean enabled;
    private String domain_id;
    private String default_project_id;
    private String cloud_project_id;
    private String id;
    private String trial_started_at;
    private String trial_duration;
    private Object links;

    public String getTrial_started_at() {
        return trial_started_at;
    }

    public void setTrial_started_at(String trial_started_at) {
        this.trial_started_at = trial_started_at;
    }

    public String getTrial_duration() {
        return trial_duration;
    }

    public void setTrial_duration(String trial_duration) {
        this.trial_duration = trial_duration;
    }


    public Object getLinks() {
        return links;
    }

    public void setLinks(Object links) {
        this.links = links;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getDomain_id() {
        return domain_id;
    }

    public void setDomain_id(String domain_id) {
        this.domain_id = domain_id;
    }

    public String getDefault_project_id() {
        return default_project_id;
    }

    public void setDefault_project_id(String default_project_id) {
        this.default_project_id = default_project_id;
    }

    public String getCloud_project_id() {
        return cloud_project_id;
    }

    public void setCloud_project_id(String cloud_project_id) {
        this.cloud_project_id = cloud_project_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


}
