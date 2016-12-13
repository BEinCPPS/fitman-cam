package it.eng.ontorepo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;

/**
 * Created by ascatox on 06/12/16.
 */
public class OrionConfig implements Serializable {

    private String id;
    private String url;
    private String service;
    private String servicePath;

    //Constants
    public static final String hasURL = "hasURL";
    public static final String hasService = "hasService";
    public static final String hasServicePath = "hasServicePath";


    public OrionConfig(String id, String url, String service, String servicePath) {
        this.id = id;
        this.url = url;
        this.service = service;
        this.servicePath = servicePath;
    }

    public OrionConfig() {
    }

    public OrionConfig(String id, String url) {
        this.id = id;
        this.url = url;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getServicePath() {
        return servicePath;
    }

    public void setServicePath(String servicePath) {
        this.servicePath = servicePath;
    }

    @JsonIgnore
    public boolean isEmpty() {
        if (StringUtils.isBlank(getId()) || StringUtils.isBlank(getUrl()))
            return true;
        return false;
    }
}
