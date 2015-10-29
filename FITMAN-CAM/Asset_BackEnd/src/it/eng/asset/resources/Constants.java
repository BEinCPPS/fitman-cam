package it.eng.asset.resources;

import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;


public class Constants {

	public static final String INTESTAZIONE_XML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
			+ "\n";
	public static final int RESPONSE_OK = 200;
	public static final int RESPONSE_ERROR = 500;
	public static final String BREADCRUMB_CSS = "breadcrumb_vaad";
	
	
	
	private static ResourceBundle finder = ResourceBundle.getBundle("user");

	
	//Ontology_Property
	public static final String CREATED_ON = "createdOn";
	public static final String IS_INSTANCE_ON = "instanceOf";
	public static final String OWNERD_BY = "ownedBy";
	
	public static final String ONTOLOGY_SYSTEM = getOntologySystem();

	public static String getSesameUrl(){
		
		return getConfigurationFileProperties().getProperty("sesame.url");
		
	}

	public static String getSesameRepository(){
		
		return getConfigurationFileProperties().getProperty("sesame.repository");
		
	}

	public static String getOntologySystem(){
		
		return getConfigurationFileProperties().getProperty("ontology.system");
		
	}

	public static String getSesameNamespace(){
		
		return getConfigurationFileProperties().getProperty("sesame.namespace");
		
	}
	
	private static Properties configurationProperties;
	
	private static Properties getConfigurationFileProperties(){
		 
		 if(configurationProperties==null){
			 
			 try {
				configurationProperties = new Properties();
				 configurationProperties.load(Constants.class.getResourceAsStream("jdbc.properties"));
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			}
			 
		 }
		 
		 return configurationProperties;
		 
	 }
	
	
	
}
