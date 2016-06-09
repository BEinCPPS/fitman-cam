package it.eng.cam.rest.dto;

import java.io.Serializable;

public class OwnerJSON implements Serializable {

	private static final long serialVersionUID = -284213782713312073L;
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
