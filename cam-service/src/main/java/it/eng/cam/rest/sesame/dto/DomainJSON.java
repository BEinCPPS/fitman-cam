package it.eng.cam.rest.sesame.dto;

import java.io.Serializable;

public class DomainJSON implements Serializable {

	private static final long serialVersionUID = -284213782713312073L;
	private String name;

	
	public DomainJSON() {
		super();
	}

	public DomainJSON(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
