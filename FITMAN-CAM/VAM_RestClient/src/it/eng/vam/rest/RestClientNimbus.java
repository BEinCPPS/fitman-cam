package it.eng.vam.rest;

import java.util.List;
import java.util.Map;

public interface RestClientNimbus {

	public List<String> getServiceTemplates(); //REST XML
	public List<String> getTemplateVariables(String nameService); //REST JSON

	public Boolean instantiateTemplates(String nameService, Map<String, String> templates ); 
	
	
}
