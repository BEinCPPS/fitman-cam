package it.eng.cam.rest.dto;

import java.io.Serializable;

public class AssetModelJSON implements Serializable {

	private static final long serialVersionUID = 8792064516069822208L;
	
	private String name;
	private String className;
	private String ownerName;

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
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

}
