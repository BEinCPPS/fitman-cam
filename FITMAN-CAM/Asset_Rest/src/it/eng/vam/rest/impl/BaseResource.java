package it.eng.vam.rest.impl;

import java.io.OutputStream;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

public class BaseResource {

	
	protected void writeObject(OutputStream os, Object o){
		try{
			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
		
			objectMapper.writeValue(os,  o);
		}catch(Exception ex){
			throw new RuntimeException(ex.getMessage());
		}
	}
	
	
}
