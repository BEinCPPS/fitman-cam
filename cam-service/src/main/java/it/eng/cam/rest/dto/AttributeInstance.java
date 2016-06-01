package it.eng.cam.rest.dto;

import java.io.Serializable;

public class AttributeInstance implements Serializable {

	private static final long serialVersionUID = 3414014156777972530L;

	private String name;
	private String value;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
