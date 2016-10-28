package it.eng.cam.rest.security.roles;


import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ascatolo on 19/10/2016.
 */
public class RoleManager {
    private static final Logger logger = LogManager.getLogger(RoleManager.class.getName());

    private Map<String, String> rolesLookup;

    public Map<String, String> getRolesLookup() {
        return rolesLookup;
    }

    public RoleManager() {
        readRolesFile();
    }


    private void readRolesFile() {
        try {
            rolesLookup = new HashMap<>();
            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            URL url = getClass().getResource("/roles.xml");
            File file = new File(url.toURI());
            Document doc = docBuilder.parse(file);
            doc.getDocumentElement().normalize();
            NodeList roles = doc.getElementsByTagName("role");
            for (int i = 0; i < roles.getLength(); i++) {
                Node nNode = roles.item(i);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element role = (Element) nNode;
                    if (role.getAttribute("name").equalsIgnoreCase(Role.ADMIN)) {
                        NodeList externalRoles = role.getElementsByTagName("external-role");
                        for (int j = 0; j < externalRoles.getLength(); j++) {
                            getRolesLookup().put(externalRoles.item(j).getTextContent(), Role.ADMIN);
                        }
                    } else if (role.getAttribute("name").equalsIgnoreCase(Role.BASIC)) {
                        NodeList externalRoles = role.getElementsByTagName("external-role");
                        for (int j = 0; j < externalRoles.getLength(); j++) {
                            getRolesLookup().put(externalRoles.item(j).getTextContent(), Role.BASIC);
                        }
                    }
                }
            }
        } catch (ParserConfigurationException e) {
            logger.error(e);
        } catch (IOException e) {
            logger.error(e);
        } catch (SAXException e) {
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }
    }


    public static void main(String[] args) {
        //Use for test
        // Infos here http://www.developerfusion.com/code/2064/a-simple-way-to-read-an-xml-file-in-java/
        RoleManager manager = new RoleManager();
        for (String role :
                manager.getRolesLookup().keySet()) {
            System.out.println(role);
        }
    }
}
