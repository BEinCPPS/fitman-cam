package it.eng.cam.rest.sesame.dto;

import java.io.Serializable;

public class AttributeJSON implements Serializable {

	private static final long serialVersionUID = 3414014156777972530L;

	private String name;
	private String value;
	private String type;

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
