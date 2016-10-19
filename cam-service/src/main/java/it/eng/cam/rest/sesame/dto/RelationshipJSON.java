package it.eng.cam.rest.sesame.dto;

import java.io.Serializable;

public class RelationshipJSON implements Serializable {

	private static final long serialVersionUID = -1595754105699770572L;

	private String name;
	private String referredName;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getReferredName() {
		return referredName;
	}

	public void setReferredName(String referredName) {
		this.referredName = referredName;
	}

}
