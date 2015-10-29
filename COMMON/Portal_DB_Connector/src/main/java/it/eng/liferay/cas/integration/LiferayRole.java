package it.eng.liferay.cas.integration;

import java.io.Serializable;

public class LiferayRole implements Serializable, Cloneable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8582827984272378704L;
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
		LiferayRole role = (LiferayRole) obj;
		return (role.getId() == null && this.id == null) || (role.getId() != null && role.getId().equals(this.id));
	}

}
