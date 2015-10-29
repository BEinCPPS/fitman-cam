package it.eng.vam.rest;

import java.util.ResourceBundle;

public class Constants {

	//private static final String URL = "http://localhost:8092/cm-api/api/v1/servicetemplates";
	
//	private static final String URL = "http://msee.nimbus-ware.com:8082/cm-api/api/v1/servicetemplates";
	// private static final String URL = "http://localhost:8081/cm-api/api/v1/servicetemplates";
	
	public static String getUrl() {
		try {
			ResourceBundle finder = ResourceBundle.getBundle("vam_rest");
			return finder.getString("url");
		} catch (Exception e) {
			return "http://localhost:8081/cm-api/api/v1/servicetemplates";
		}
	}
	
}
