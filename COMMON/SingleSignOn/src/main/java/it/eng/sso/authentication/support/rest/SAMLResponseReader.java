package it.eng.sso.authentication.support.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.jasig.cas.util.SamlUtils;
import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;

public class SAMLResponseReader {

	public static HashMap<String, Object> extractAttributesFromResponse(String response, Object obj) {

		HashMap<String, Object> attributesMap = new HashMap<String, Object>();
		Document document = SamlUtils.constructDocumentFromXmlString(response);
		Element rootNode = document.getRootElement();
		List attributeList = rootNode.getChildren();
		for (Object ele : attributeList) {
			Element node = (Element) ele;
			if (node.getName().equalsIgnoreCase("AttributeStatement")) {
				for (Object childNode : node.getChildren()) {
					Element elem = (Element) childNode;
					String nome = "";
					String valore = "";
					List<String> arr = new ArrayList<String>();
					for (Object attr : elem.getAttributes()) {
						Attribute attrib = (Attribute) attr;
						nome = attrib.getValue();
					}
					for (Object childNephew : elem.getChildren()) {
						Element elem2 = (Element) childNephew;
						valore = elem2.getValue();
						if (elem.getChildren().size() > 1) {
							arr.add(valore);
						}
					}
					if (arr.size() > 0) {
						attributesMap.put(nome, arr);
					} else {
						attributesMap.put(nome, valore);
					}
				}
			}
		}
		attributesMap.put("ecosystem", obj);
		return attributesMap;
	}

}
