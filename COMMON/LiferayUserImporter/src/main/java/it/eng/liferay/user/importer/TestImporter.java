package it.eng.liferay.user.importer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import it.eng.sso.filters.principal.bean.SSOPrincipal;
import it.eng.sso.filters.principal.bean.SSOPrincipalImpl;

public class TestImporter {

	public static void main(String[] args) {
		testImport();

	}

	private static void testImport() {
		
		LiferayUserImporterImpl liferayUserImporterImpl = new LiferayUserImporterImpl();

	    String name = "mantuano";
	    Map<String,Object> map = new HashMap<String,Object>();
	    List<String> roles = new ArrayList<String>(); //Role	
		roles.add("Administrator");
		roles.add("Power User");
		roles.add("FITMAN_User");
	    map.put("Role",roles);
		map.put("Ecosystem", "Bivolino");
		map.put("Email", "mantuano@eng.it");
		SSOPrincipal principal = new SSOPrincipalImpl(name,map);
        boolean ok = liferayUserImporterImpl.manageLiferayUser(principal);
        if (ok) { 
        	System.out.println("it works"); 
        } else {
        	System.out.println("disaster"); 
        }
 	}
}
