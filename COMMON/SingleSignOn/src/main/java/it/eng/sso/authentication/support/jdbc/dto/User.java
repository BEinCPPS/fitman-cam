package it.eng.sso.authentication.support.jdbc.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User {
	private String username;
	private String password;
	private Date registrationDate;
	private Date lastChangeDate;
	private Boolean fgDisabled;
	private Boolean fgAdministrator;
	private List<Attribute> attributes;
	private List<Role> roles;
	private Attempt attempt;
	private String role;
	private Attribute attribute;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public Date getLastChangeDate() {
		return lastChangeDate;
	}

	public void setLastChangeDate(Date lastChangeDate) {
		this.lastChangeDate = lastChangeDate;
	}

	public Boolean getFgDisabled() {
		return fgDisabled;
	}

	public void setFgDisabled(Boolean fgDisabled) {
		this.fgDisabled = fgDisabled;
	}

	public List<Attribute> getAttributes() {
		return attributes;
	}

	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public Attempt getAttempt() {
		return attempt;
	}

	public void setAttempt(Attempt attempt) {
		this.attempt = attempt;
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
		User other = (User) obj;
		if (getUsername() == null) {
			if (other.getUsername() != null) {
				return false;
			}
		} else if (!getUsername().equals(other.getUsername())) {
			return false;
		}
		if (!getPassword().equals(other.getPassword())) {
			return false;
		}
		return true;
	}

	public String getRole() {
		return role;
	}

	// public void setRole(String role) {
	// this.roles = new ArrayList<Ruolo>();
	// Ruolo r = new Ruolo();
	// r.setRole(getRole());
	// this.roles.add(r);
	// }

	public Attribute getAttribute() {
		if (attribute == null)
			attribute = new Attribute();
		return attribute;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public void setAttribute(Attribute attribute) {
		this.attributes = new ArrayList<Attribute>();
		this.attributes.add(attribute);

	}

	public void setFgAdministrator(Boolean fgAdministrator) {
		this.fgAdministrator = fgAdministrator;
	}

	public Boolean getFgAdministrator() {
		return fgAdministrator;
	}

}