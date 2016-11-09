package it.eng.cam.rest.security.project;

import org.eclipse.rdf4j.query.algebra.Str;

import java.io.Serializable;
import java.util.List;

/**
 * Created by ascatolo on 02/11/2016.
 */
public class Project implements Serializable {

    private String description;
    private Link links;
    private Boolean enabled;
    private String id;
    private Boolean is_default;
    private String domain_id;
    private String name;
    private String website;
    private String is_cloud_project;

    public String getIs_cloud_project() {
        return is_cloud_project;
    }

    public void setIs_cloud_project(String is_cloud_project) {
        this.is_cloud_project = is_cloud_project;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Link getLinks() {
        return links;
    }

    public void setLinks(Link links) {
        this.links = links;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Boolean getIs_default() {
        return is_default;
    }

    public void setIs_default(Boolean is_default) {
        this.is_default = is_default;
    }

    public String getDomain_id() {
        return domain_id;
    }

    public void setDomain_id(String domain_id) {
        this.domain_id = domain_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public static class Link {
        private String self;

        public Link(String self) {
            this.self = self;
        }

        public Link() {
        }

        public String getSelf() {
            return self;
        }

        public void setSelf(String self) {
            this.self = self;
        }
    }


    @Override
    public int hashCode() {
        return this.id.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        Project proj = (Project) obj;
        return this.id.equals(proj.getId());
    }
}
