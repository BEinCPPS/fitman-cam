package it.eng.sso.filters.principal.bean;

import java.io.Serializable;
import java.security.Principal;
import java.util.List;
import java.util.Map;

public interface SSOPrincipal extends Principal, Serializable{

	public List<String> getRoles();
	public List<String> getOrganizations();
	public List<String> getVirtualEnterprises();
	public String getEcosystem();
	public String getEmail();
	public Map<String,Object> getAttributes();
	
	
}
