/*
 * Licensed to Jasig under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Jasig licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License.  You may obtain a
 * copy of the License at the following location:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package it.eng.sso.authentication.support.jdbc;

import it.eng.sso.authentication.support.jdbc.dto.Attribute;
import it.eng.sso.authentication.support.jdbc.dto.Role;
import it.eng.sso.authentication.support.jdbc.dto.User;
import it.eng.sso.authentication.util.SSOConstant;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.AuthenticationHandler;
import org.jasig.cas.authentication.principal.Credentials;
import org.jasig.cas.authentication.principal.CredentialsToPrincipalResolver;
import org.jasig.cas.authentication.principal.Principal;
import org.jasig.cas.authentication.principal.SimplePrincipal;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.RowMapper;

/**
 * Class that if provided a query that returns a password (parameter of query
 * must be username) will compare that password to a translated version of the
 * password provided by the user. If they match, then authentication succeeds.
 * Default password translator is plaintext translator.
 * 
 * @author Scott Battaglia
 * @author Dmitriy Kopylenko
 * @version $Revision$ $Date$
 * @since 3.0
 */
public class LubInstanceAuthenticationHandler extends
		AbstractJdbcUsernamePasswordAuthenticationHandler implements
		AuthenticationHandler, CredentialsToPrincipalResolver {

	@NotNull
	private String sql;
	public static final ThreadLocal<Principal> principalThreadLocal = new ThreadLocal<Principal>();
	private final Logger log = LoggerFactory.getLogger(getClass());

	protected final boolean authenticateUsernamePasswordInternal(
			final UsernamePasswordCredentials credentials)
			throws AuthenticationException {
		final String username = getPrincipalNameTransformer().transform(
				credentials.getUsername());
		final String password = credentials.getPassword();

		try { // TODO
			Collection users = getJdbcTemplate().query(this.sql,
					new RowMapper() {
						public Object mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							User utente = new User();
							List<Attribute> attributi = new ArrayList<Attribute>();
							List<Role> ruoli = new ArrayList<Role>();
							utente.setUsername(rs.getString("MSEE_USERNAME"));
							utente.setPassword(rs.getString("MSEE_PASSWORD"));
							utente.setFgDisabled(rs
									.getBoolean("MSEE_FG_DISABLED"));
							utente.setFgAdministrator(rs
									.getBoolean("MSEE_FG_ADMINISTRATOR"));
							do {
								Attribute a = new Attribute();
								Role r = new Role();
								a.setAttributeKey(rs
										.getString("MSEE_ATTRIBUTE_KEY"));
								a.setAttributeValue(rs
										.getString("MSEE_ATTRIBUTE_VALUE"));
								r.setRole(rs.getString("MSEE_ROLE"));
								if (!attributi.contains(a))
									attributi.add(a);
								if (!ruoli.contains(r))
									ruoli.add(r);
							} while (rs.next());
							utente.setAttributes(attributi);
							utente.setRoles(ruoli);
							return utente;
						}
					}, username);

			if (users.size() != 1)
				return false;
			User usr = (User) users.toArray()[0];
			// Controllo password
			if (!encryptData(credentials.getPassword()).equalsIgnoreCase(
					usr.getPassword()))
				return false;
			// Controllo disabilitato
			if (usr.getFgDisabled())
				return false;
			if (usr.getFgAdministrator())
				return false;
			// Costruiamo il principal
			principalThreadLocal.set(new SimplePrincipal(username, extractData(
					usr.getAttributes(), usr.getRoles())));
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

	private HashMap<String, Object> extractData(List<Attribute> attributes,
			List<Role> roles) {
		if (attributes == null)
			return null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		for (Attribute attr : attributes) {
			map.put(attr.getAttributeKey(),attr.getAttributeValue());
		}
		for (Role role : roles) {
			map.put(SSOConstant.ROLE_KEY,role.getRole());
		}
		return map;
	}

	private String encryptData(String data) {
		MessageDigest mdEnc = null;
		String dataEncrypt = new String();
		try {
			mdEnc = MessageDigest.getInstance("MD5");
			mdEnc.update(data.getBytes(), 0, data.length());
			dataEncrypt = new BigInteger(1, mdEnc.digest()).toString(16);
		} catch (NoSuchAlgorithmException ex) {
			log.error(ex.getMessage());
		}
		return dataEncrypt;
	}

}
