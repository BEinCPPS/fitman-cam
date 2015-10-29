package it.eng.liferay.user.importer;

import it.eng.sso.filters.principal.bean.SSOPrincipal;

public interface LiferayUserImporter {

	
	public boolean manageLiferayUser(SSOPrincipal principal);
	
}
