package it.eng.cam.rest.sesame;

import java.io.Serializable;

public class Attribute implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String name;
	private String individualName;
	private String value;
	private String type;

	
	
	public Attribute(String name, String individualName, String value, String type) {
		super();
		this.name = name;
		this.individualName = individualName;
		this.value = value;
		this.type = type;
	}

	public Attribute() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIndividualName() {
		return individualName;
	}

	public void setIndividualName(String individualName) {
		this.individualName = individualName;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	
	public void setType(String type) {
		this.type = type;
	}
	
		
	public String getType() {
		return type;
	}

	public Class<?> getClassType() throws ClassNotFoundException{
		return Class.forName(type);
	}
}
