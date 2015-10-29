package it.eng.sso.filters.principal.bean;

import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.jasig.cas.client.authentication.AttributePrincipal;

public class SSOPrincipalImpl implements SSOPrincipal {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1615433358562626421L;
	private Map<String, Object> attributes;
	private String name;
	private static ResourceBundle finder = ResourceBundle.getBundle("attributes-config");

	public SSOPrincipalImpl(String name, Map<String, Object> attributes) {
		super();
		this.attributes = attributes;
		this.name = name; 
	}

	public SSOPrincipalImpl(String name) {
		super();
		this.name = name;
	}

	public SSOPrincipalImpl(String name, AttributePrincipal princ) {
		super();
		this.name = name;
		if (princ.getAttributes() != null && princ.getAttributes().size() >= 0)
			this.attributes = princ.getAttributes();

	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public List<String> getRoles() {
		if (attributes == null)
			return null;
		return (List<String>) attributes.get(finder.getObject("role_attribute"));
	}

	@Override
	public List<String> getOrganizations() {
		if (attributes == null)
			return null;
		return (List<String>) attributes.get(finder.getObject("organization_attribute"));
	}

	@Override
	public List<String> getVirtualEnterprises() {
		if (attributes == null)
			return null;
		return (List<String>) attributes.get(finder.getObject("virtualenterprise_attribute"));
	}

	@Override
	public String getEcosystem() {
		if (attributes == null)
			return null;
		return (String) attributes.get(finder.getObject("ecosystem_attribute"));
	}

	@Override
	public String getEmail() {
		if (attributes == null)
			return null;
		return (String) attributes.get(finder.getObject("email_attribute"));
	}

	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}

}
