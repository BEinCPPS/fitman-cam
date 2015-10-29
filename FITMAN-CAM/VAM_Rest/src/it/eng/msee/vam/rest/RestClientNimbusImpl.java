package it.eng.msee.vam.rest;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class RestClientNimbusImpl implements RestClientNimbus {
	private static final String URL1 = getUrl();
	private static final String USER_AGENT = "Mozilla/5.0";

	@Override
	public List<String> getTemplateVariables(String nameService) {
		List<String> vars = new ArrayList<String>();
		try {
			String url = createURL(nameService, "variables");
			String data = getRESTData(url, "application/json");
			JSONParser parser = new JSONParser();
			Object obj;
			obj = parser.parse(data);
			JSONObject jsonObject = (JSONObject) obj;
			JSONArray variables = (JSONArray) jsonObject.get("variables");
			Iterator<String> iterator = variables.iterator();
			while (iterator.hasNext()) {
				vars.add(iterator.next());
			}
		} catch (ParseException e) {
			throw new RuntimeException(e.getMessage());
		}
		return vars;
	}

	public static String createURL(String nameService, String operation) {
		String encodedUrl = null;
		String url = null;
		try {
			encodedUrl = URLEncoder.encode(nameService, "UTF-8");
			encodedUrl = encodedUrl.replace("+", "%20"); // TODO FIX
			url = URL1 + "/" + encodedUrl + "/" + operation;

		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e.getMessage());
		}
		return url;
	}

	@Override
	public List<String> getServiceTemplates() {
		String data = getRESTData(URL1, "application/xml");
		System.out.println(data);
		DocumentBuilder builder = null;
		try {
			builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		} catch (ParserConfigurationException e1) {
			throw new RuntimeException(e1.getMessage());
		}
		List<String> templates = new ArrayList<String>();
		try {
			if (data == null || "".equalsIgnoreCase(data))
				return null;
			Document document = builder.parse(new InputSource(new ByteArrayInputStream(data.getBytes("utf-8"))));
			XPath xPath = XPathFactory.newInstance().newXPath();
			String expression = "/pagedServiceTemplates";
			try {
				NodeList nodeList = (NodeList) xPath.compile(expression).evaluate(document, XPathConstants.NODESET);
				for (int i = 0; null != nodeList && i < nodeList.getLength(); i++) {
					Node nod = nodeList.item(i);
					if (nod.getNodeType() == Node.ELEMENT_NODE) {
						NamedNodeMap map = nod.getFirstChild().getAttributes();
						Node name = map.getNamedItem("name");
						templates.add(name.getNodeValue());
					}
				}
			} catch (XPathExpressionException e) {
				throw new RuntimeException(e.getMessage());
			}
		} catch (SAXException e) {
			throw new RuntimeException(e.getMessage());
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
		return templates;
	}

	public static String getRESTData(String url, String contentType) {
		HttpURLConnection conn = null;
		try {
			URL URL = new URL(url);
			conn = (HttpURLConnection) URL.openConnection();
			System.out.println(conn.usingProxy());
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", contentType);

			if (conn.getResponseCode() != 200) {
				// System.out.print(conn.getResponseCode());
				return null;
			}
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String output;
			String out = "";

			while ((output = br.readLine()) != null) {
				out += output;
			}
			conn.disconnect();
			return out;
		} catch (MalformedURLException e) {
			throw new RuntimeException(e.getMessage());

		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			if (conn != null)
				conn.disconnect();
		}
	}

	public static boolean postRESTData(String nameService, String contentType, Map<String, String> data) {
		Boolean retVal = null;
		HttpURLConnection con = null;
		try {
			String url = createURL(nameService, "instance");
			URL obj = new URL(url);
			con = (HttpURLConnection) obj.openConnection();
			// add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", USER_AGENT);
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
			con.setRequestProperty("Content-Type", contentType);

			JSONObject jsonMain = new JSONObject();
			JSONObject jsonParams = new JSONObject();
			for (String object : data.keySet()) {
				jsonParams.put(object, data.get(object));
			}
			jsonMain.put("instantiationRequest", jsonParams);
			// Send post request
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(jsonMain.toJSONString());
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			System.out.println("\nSending 'POST' request to URL : " + url);
			System.out.println("Post parameters : " + jsonMain.toJSONString());
			System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			retVal = true;
			// print result
		} catch (Exception ex) {
			retVal = false;
			throw new RuntimeException();

		} finally {
			if (con != null)
				con.disconnect();
		}
		return retVal;
	}

	@Override
	public Boolean instantiateTemplates(String nameService, Map<String, String> templates) {
		return postRESTData(nameService, "application/json", templates);

	}
	
	private static String getUrl(){
		try {
			ResourceBundle finder = ResourceBundle.getBundle("vam_rest");
			return finder.getString("url");
		} catch (Exception e) {
			return "http://localhost:8081/cm-api/api/v1/servicetemplates";
		}
	}

}
