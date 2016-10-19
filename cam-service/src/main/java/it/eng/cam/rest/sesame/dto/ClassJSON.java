package it.eng.cam.rest.sesame.dto;

import java.io.Serializable;

public class ClassJSON implements Serializable{

	private static final long serialVersionUID = 2881164817261980430L;

	private String name;
	private String parentName;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	
}
