package it.eng.sso.filters.principal.http;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jasig.cas.client.authentication.AttributePrincipal;
import org.jasig.cas.client.util.AbstractCasFilter;
import org.jasig.cas.client.util.AbstractConfigurationFilter;
import org.jasig.cas.client.validation.Assertion;

public class HttpServletRequestSSOWrapper extends AbstractConfigurationFilter {

	/** Name of the attribute used to answer role membership queries */
	private String roleAttribute;

	/** Whether or not to ignore case in role membership queries */
	private boolean ignoreCase;

	public void destroy() {
		// nothing to do
	}

	/**
	 * Wraps the HttpServletRequest in a wrapper class that delegates
	 * <code>request.getRemoteUser</code> to the underlying Assertion object
	 * stored in the user session.
	 */
	public void doFilter(final ServletRequest servletRequest, final ServletResponse servletResponse,
			final FilterChain filterChain) throws IOException, ServletException {
		final AttributePrincipal principal = retrievePrincipalFromSessionOrRequest(servletRequest);

		filterChain.doFilter(new SSOHttpServletRequestWrapper((HttpServletRequest) servletRequest, principal),
				servletResponse);
	}

	protected AttributePrincipal retrievePrincipalFromSessionOrRequest(final ServletRequest servletRequest) {
		final HttpServletRequest request = (HttpServletRequest) servletRequest;
		final HttpSession session = request.getSession(false);
		final Assertion assertion = (Assertion) (session == null ? request
				.getAttribute(AbstractCasFilter.CONST_CAS_ASSERTION) : session
				.getAttribute(AbstractCasFilter.CONST_CAS_ASSERTION));

		return assertion == null ? null : assertion.getPrincipal();
	}

	public void init(final FilterConfig filterConfig) throws ServletException {
		this.roleAttribute = getPropertyFromInitParams(filterConfig, "roleAttribute", null);
		this.ignoreCase = Boolean.parseBoolean(getPropertyFromInitParams(filterConfig, "ignoreCase", "false"));
	}

	}
