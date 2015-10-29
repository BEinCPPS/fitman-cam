package it.eng.liferay.cas.integration;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.jasig.cas.adaptors.jdbc.AbstractJdbcUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.AuthenticationHandler;
import org.jasig.cas.authentication.principal.Credentials;
import org.jasig.cas.authentication.principal.CredentialsToPrincipalResolver;
import org.jasig.cas.authentication.principal.Principal;
import org.jasig.cas.authentication.principal.SimplePrincipal;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.RowMapper;

public class LiferayAuthenticationHandler extends AbstractJdbcUsernamePasswordAuthenticationHandler implements AuthenticationHandler,
		CredentialsToPrincipalResolver {

	
	
	@NotNull
	private String sql;
	private LiferayPasswordEncoder passwordEncoder;

	public static final ThreadLocal<Principal> principalThreadLocal = new ThreadLocal<Principal>();

	@SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
	protected final boolean authenticateUsernamePasswordInternal(final UsernamePasswordCredentials credentials) throws AuthenticationException {
		final String username = getPrincipalNameTransformer().transform(credentials.getUsername());
		try {
			Collection users = getJdbcTemplate().query(this.sql, new RowMapper() {
				public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
					LiferayUser user = new LiferayUser();
					user.setEmailAddress(rs.getString("emailAddress"));
					user.setPassword(rs.getString("password_"));
					user.setFirstName(rs.getString("firstName"));
					user.setMiddleName(rs.getString("middleName"));
					user.setLastName(rs.getString("lastName"));
					user.setScreenName(rs.getString("screenName"));
					do {
						if (user.getRoles() == null)
							user.setRoles(new ArrayList<LiferayRole>());
						if (user.getOrganizations() == null)
							user.setOrganizations(new ArrayList<LiferayOrganization>());
						LiferayOrganization org = new LiferayOrganization();
						org.setId(rs.getLong("organizationId"));
						org.setName(rs.getString("organization"));
						LiferayRole role = new LiferayRole();
						role.setId(rs.getLong("roleId"));
						role.setName(rs.getString("role"));
						if (!user.getOrganizations().contains(org) && org.getId() != null && !org.getId().equals(""))
							user.getOrganizations().add(org);
						if (!user.getRoles().contains(role) && role.getId() != null && !role.getId().equals(""))
							user.getRoles().add(role);
					} while (rs.next());

					return user;
				}
			}, username);

			if (users.size() != 1)
				return false;
			LiferayUser usr = (LiferayUser) users.toArray()[0];
			// This control checks if the password is correct
			if (!passwordEncoder.encode(credentials.getPassword()).equalsIgnoreCase(usr.getPassword()))
				return false;
			// Here we prepare the principal object
			principalThreadLocal.set(new SimplePrincipal(username, extractData(usr)));
			return true;
		} catch (final IncorrectResultSizeDataAccessException e) {
			// this means the username was not found.
			return false;
		}
	}

	/**
	 * @param sql
	 *            The sql to set.
	 */
	public void setSql(final String sql) {
		this.sql = sql;
	}

	public Principal resolvePrincipal(Credentials arg0) {
		Principal principal = principalThreadLocal.get();
		principalThreadLocal.remove();
		return principal;

	}
	public static Principal getPrincipal() {
		Principal principal = principalThreadLocal.get();
		principalThreadLocal.remove();
		return principal;

	}

	private HashMap<String, Object> extractData(LiferayUser usr) {
		if(usr == null) return null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		String name = usr.getFirstName() == null || usr.getFirstName().equals("")?"":usr.getFirstName();
		String surname = usr.getLastName() == null || usr.getLastName().equals("")?"":usr.getLastName();
		String nm = name+" "+surname;
		if(!nm.trim().equals(""))
			map.put(AttributeNames.NAME, nm.trim());
		String email = usr.getEmailAddress() == null?"":usr.getEmailAddress();
		if(email != null && !email.equals(""))
			map.put(AttributeNames.EMAIL, email.trim());
		if (usr.getOrganizations() != null)
			map.put(AttributeNames.ROLE, usr.getRoles());
		if(usr.getRoles() !=null)
			map.put(AttributeNames.ORGANIZATION, usr.getOrganizations());
		return map;
	}

	public void setPasswordEncoder(LiferayPasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

}
