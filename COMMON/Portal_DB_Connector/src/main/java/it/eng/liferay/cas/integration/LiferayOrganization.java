package it.eng.liferay.cas.integration;

import java.io.Serializable;

public class LiferayOrganization implements Serializable, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8587144424493600627L;

	private Long id;
	private String name;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public boolean equals(Object obj) {
		LiferayOrganization org = (LiferayOrganization) obj;
		return (org.getId() == null && this.id == null) || (org.getId() != null && org.getId().equals(this.id));
	}

}
