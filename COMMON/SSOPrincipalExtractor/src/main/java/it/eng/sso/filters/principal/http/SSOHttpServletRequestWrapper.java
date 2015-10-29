package it.eng.sso.filters.principal.http;

import it.eng.sso.filters.principal.bean.SSOPrincipal;
import it.eng.sso.filters.principal.bean.SSOPrincipalImpl;

import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.jasig.cas.client.authentication.AttributePrincipal;
import org.jasig.cas.client.util.CommonUtils;

public class SSOHttpServletRequestWrapper extends HttpServletRequestWrapper {

		private AttributePrincipal attributePrincipal;
		private SSOPrincipal principal;
		
		/** Name of the attribute used to answer role membership queries */
		private String roleAttribute;

		/** Whether or not to ignore case in role membership queries */
		private boolean ignoreCase;

		public SSOHttpServletRequestWrapper(final HttpServletRequest request, final AttributePrincipal principal) {
			super(request);
			this.attributePrincipal = principal;
			this.principal = new SSOPrincipalImpl(principal.getName(), principal.getAttributes());
		}

		public SSOPrincipal getUserPrincipal() {
			return this.principal;
		}

		public String getRemoteUser() {
			return principal != null ? this.principal.getName() : null;
		}

		public boolean isUserInRole(final String role) {
			if (CommonUtils.isBlank(role)) {
				// log.debug("No valid role provided.  Returning false.");
				return false;
			}

			if (this.principal == null) {
				// log.debug("No Principal in Request.  Returning false.");
				return false;
			}

			if (CommonUtils.isBlank(roleAttribute)) {
				// log.debug("No Role Attribute Configured. Returning false.");
				return false;
			}

			final Object value = this.attributePrincipal.getAttributes().get(roleAttribute);

			if (value instanceof Collection<?>) {
				for (final Object o : (Collection<?>) value) {
					if (rolesEqual(role, o)) {
						// log.debug("User [" + getRemoteUser() +
						// "] is in role [" + role + "]: " + true);
						return true;
					}
				}
			}
			final boolean isMember = rolesEqual(role, value);
			// log.debug("User [" + getRemoteUser() + "] is in role [" + role +
			// "]: " + isMember);
			return isMember;
		}

		/**
		 * Determines whether the given role is equal to the candidate role
		 * attribute taking into account case sensitivity.
		 * 
		 * @param given
		 *            Role under consideration.
		 * @param candidate
		 *            Role that the current user possesses.
		 * 
		 * @return True if roles are equal, false otherwise.
		 */
		private boolean rolesEqual(final String given, final Object candidate) {
			return ignoreCase ? given.equalsIgnoreCase(candidate.toString()) : given.equals(candidate);
		}

	}
