package it.eng.cam.rest.sesame.dto;

import java.io.Serializable;

public class AssetJSON implements Serializable {

    private static final long serialVersionUID = 3740815439735864561L;

    private String name;
    private String className;
    private String modelName;
    private String domainName;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getDomainName() {
        return domainName;
    }

    public void setDomainName(String domainName) {
        this.domainName = domainName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }


}
