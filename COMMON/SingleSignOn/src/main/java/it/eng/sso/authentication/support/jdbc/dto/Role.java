package it.eng.sso.authentication.support.jdbc.dto;

public class Role {

	private String role;
	private String roleDescription;

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return role;
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
		Role other = (Role) obj;
		if (getRole() == null) {
			if (other.getRole() != null) {
				return false;
			}
		} else if (getRole().equals(other.getRole())) {
			return true;
		}
		return false;
	}
}
