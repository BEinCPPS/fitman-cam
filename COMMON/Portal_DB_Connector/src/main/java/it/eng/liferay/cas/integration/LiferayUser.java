package it.eng.liferay.cas.integration;

import java.io.Serializable;
import java.util.List;

public class LiferayUser implements Serializable, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2304520982229071885L;
	private String password;
	private String screenName;
	private String emailAddress = new String();
	private String firstName;
	private String middleName;
	private String lastName;
	private List<LiferayOrganization> organizations;
	private List<LiferayRole> roles;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getScreenName() {
		return screenName;
	}

	public void setScreenName(String screenName) {
		this.screenName = screenName;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public List<LiferayOrganization> getOrganizations() {
		return organizations;
	}

	public void setOrganizations(List<LiferayOrganization> organizations) {
		this.organizations = organizations;
	}

	public List<LiferayRole> getRoles() {
		return roles;
	}

	public void setRoles(List<LiferayRole> roles) {
		this.roles = roles;
	}

	@Override
	public boolean equals(Object usr) {
		LiferayUser user = (LiferayUser) usr;

		if (user.getEmailAddress().equalsIgnoreCase(this.getEmailAddress()))
			return true;
		return false;

	}

}
