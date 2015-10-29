package it.eng.vam.service.test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

public class BaseTest {

	public static void out(String s){
		System.out.println(s);
	}
	public static String toJSON(Object o){
		try{
			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
	
			String json = objectMapper.writeValueAsString(o);
			return json;
		}catch(Throwable t){
			throw new RuntimeException(t.getMessage());
		}
	}
	
	public static POJOTest fromJSON(String o){
		try{
			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
	
			POJOTest pojoTest  = objectMapper.readValue(o, POJOTest.class);
			return pojoTest;
		}catch(Throwable t){
			throw new RuntimeException(t.getMessage());
		}
	}
}
