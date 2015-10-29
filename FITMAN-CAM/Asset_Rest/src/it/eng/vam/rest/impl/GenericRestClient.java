package it.eng.vam.rest.impl;

import it.eng.vam.util.WarningException;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response.Status;

import org.jboss.resteasy.client.ClientRequest;
import org.jboss.resteasy.client.ClientResponse;
import org.slf4j.Logger;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

public class GenericRestClient {
	private static final Logger logger = org.slf4j.LoggerFactory
			.getLogger(GenericRestClient.class);

	public String conformUrl(String urlStr){

		URL url;
		try {
			url = new URL(urlStr);
			URI uri = new URI(url.getProtocol(), url.getUserInfo(), url.getHost(), url.getPort(), url.getPath(), url.getQuery(), url.getRef());
			url = uri.toURL();
			return url.toString();
		} catch (MalformedURLException e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage(), e);
		} catch (URISyntaxException  use) {
			use.printStackTrace();
			throw new RuntimeException(use.getMessage(), use);
		}
	}
	
	
	
	protected JsonNode getJson(String url) {
		ClientRequest clientRequest = new ClientRequest(conformUrl(url));
		clientRequest.accept(MediaType.APPLICATION_JSON);
		ClientResponse<String> clientResponse = null;
		try {
			clientResponse = clientRequest.get();
			Status status = clientResponse.getResponseStatus();

			logger.info("get JSON Status [" + status.toString() + "]");
			String s = (String) clientResponse.getEntity(String.class);
			
			int intStatus = status.getStatusCode();
			if (intStatus >= 400 && intStatus < 500)
				throw new WarningException(s);
			
			if (intStatus >= 500)
				throw new RuntimeException(status.toString() + "["+s+"]");
			
			ObjectMapper m = new ObjectMapper();
			JsonNode rootNode = m.readTree(s);
			return rootNode;
		} catch (RuntimeException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			clientResponse.releaseConnection();
		}
	}

	protected JsonNode postJson(String url, String json) {
		ClientRequest clientRequest = new ClientRequest(conformUrl(url));
		clientRequest.accept(MediaType.APPLICATION_JSON);
		ClientResponse<String> clientResponse = null;
		try {
			clientRequest.body(MediaType.APPLICATION_JSON, json);
			clientResponse = clientRequest.post();
			Status status = clientResponse.getResponseStatus();

			logger.info("post JSON Status [" + status.toString() + "]");
			String s = (String) clientResponse.getEntity(String.class);
			
			int intStatus = status.getStatusCode();
			
			if (intStatus >= 400 && intStatus < 500)
				throw new WarningException(s);
			
			if (intStatus >= 500)
				throw new RuntimeException(status.toString() + "["+s+"]");
		
			if ( status  == Status.CREATED ) {
				MultivaluedMap<String, String> mValueMap = clientResponse.getHeaders();
				ObjectMapper m = new ObjectMapper();
				s = m.writeValueAsString(mValueMap.get("Location").get(0));
				
			}
			
			if (s != null && s.trim().length() > 0){
				ObjectMapper m = new ObjectMapper();
				JsonNode rootNode = m.readTree(s);
				return rootNode;
			} else {
				return null;
			}
			
		} catch (RuntimeException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			clientResponse.releaseConnection();
		}
	}

	protected void putJson(String url, String json) {
		ClientRequest clientRequest = new ClientRequest(conformUrl(url));

		ClientResponse<String> clientResponse = null;
		try {
			clientRequest.body(MediaType.APPLICATION_JSON, json);
			clientResponse = clientRequest.put();
			Status status = clientResponse.getResponseStatus();

			String s = (String) clientResponse.getEntity(String.class);
			logger.info("putJson JSON Status [" + status.toString() + "]");
			int intStatus = status.getStatusCode();
			
			if (intStatus >= 400 && intStatus < 500)
				throw new WarningException(s);
			
			if (intStatus >= 500)
				throw new RuntimeException(status.toString() + "["+s+"]");
		
			
			
			
		} catch (RuntimeException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			clientResponse.releaseConnection();
		}
	}

	protected void delete(String url) {
		ClientRequest clientRequest = new ClientRequest(conformUrl(url));
		ClientResponse<String> clientResponse = null;
		try {
			clientResponse = clientRequest.delete();
			Status status = clientResponse.getResponseStatus();

			logger.info("Delete [" + status.toString() + "]");
			String s = (String) clientResponse.getEntity(String.class);
			
			logger.info("Delete JSON Status [" + status.toString() + "]");
			int intStatus = status.getStatusCode();
			
			if (intStatus >= 400 && intStatus < 500)
				throw new WarningException(s);
			
			if (intStatus >= 500)
				throw new RuntimeException(status.toString() + "["+s+"]");
		} catch (RuntimeException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			clientResponse.releaseConnection();
		}
	}

	protected String objToJSON(Object o) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);

			return objectMapper.writeValueAsString(o);
		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		}
	}
	
	protected JsonNode readJSonNode(String json) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);

			return objectMapper.readTree(json);
		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		}
	}
}
