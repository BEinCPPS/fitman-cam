package it.eng.sso.authentication.support.jdbc.dto;

public class Attribute {

	private String username;
	private String attributeKey;
	private String attributeValue;
	private String attributeDescription;
	
	

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAttributeKey() {
		return attributeKey;
	}

	public void setAttributeKey(String attributeKey) {
		this.attributeKey = attributeKey;
	}

	public String getAttributeValue() {
		return attributeValue;
	}

	public void setAttributeValue(String attributeValue) {
		this.attributeValue = attributeValue;
	}

	public String getAttributeDescription() {
		return attributeDescription;
	}

	public void setAttributeDescription(String attributeDescription) {
		this.attributeDescription = attributeDescription;
	}
	
	@Override
	public boolean equals(Object obj) {

		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Attribute other = (Attribute) obj;
		if (getAttributeKey() == null) {
			if (other.getAttributeKey() != null) {
				return false;
			}
		} else if (getAttributeKey().equals(other.getAttributeKey())) {
			return true;
		}
		return false;
	}
}
