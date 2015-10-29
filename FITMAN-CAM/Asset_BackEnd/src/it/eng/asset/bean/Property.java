package it.eng.asset.bean;

public class Property {
	
	private String type;
	private String namespace;
	private String name;
	private String value;
	private String type_value;
	
	
	public String getType_value() {
		return type_value;
	}
	public void setType_value(String type_value) {
		this.type_value = type_value;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getNamespace() {
		return namespace;
	}
	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}
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
