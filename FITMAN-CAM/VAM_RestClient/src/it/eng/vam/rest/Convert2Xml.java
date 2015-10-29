package it.eng.vam.rest;


import java.io.StringWriter;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class Convert2Xml {
	
	public String makeXML(Map<String, String> data) 
	{
		String output = "";
		try {
			
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	 
			// root elements
			Document doc = docBuilder.newDocument();
			Element rootElement = doc.createElement("instantiateRequest");
			doc.appendChild(rootElement);
	 
			// staff elements
			Element variable = doc.createElement("variableValues");
			rootElement.appendChild(variable);

			
			for (String object : data.keySet()) {

				Element el = doc.createElement(object.replace(": ", ""));
				el.appendChild(doc.createTextNode(data.get(object)));
				variable.appendChild(el);
			}
			
	 
			
			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
			DOMSource source = new DOMSource(doc);
			StringWriter sw = new StringWriter();
			StreamResult result = new StreamResult(sw);
			transformer.transform(source, result);
	 
			output = sw.toString();
			
		  } catch (ParserConfigurationException pce) {
			  pce.printStackTrace();
		  }  catch (TransformerException tfe) {
				tfe.printStackTrace();
		  }
		
		return output;
	}

}

