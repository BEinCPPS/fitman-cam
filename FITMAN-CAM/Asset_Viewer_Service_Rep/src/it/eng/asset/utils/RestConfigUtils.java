package it.eng.asset.utils;

import java.util.ResourceBundle;

public class RestConfigUtils {
	
	private RestConfigUtils() {
		super();
	}
	
	public static String getAssetRestBaseUrl(){
		return ResourceBundle.getBundle("rest-config").getString("vam-rest-base-url");
	}

}
