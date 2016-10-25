package it.eng.cam.rest.sesame.dto;

import java.io.Serializable;

public class AssetModelJSON implements Serializable {

	private static final long serialVersionUID = 8792064516069822208L;
	
	private String name;
	private String className;
	private String domainName;

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getDomainName() {
		return domainName;
	}
	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}

}
