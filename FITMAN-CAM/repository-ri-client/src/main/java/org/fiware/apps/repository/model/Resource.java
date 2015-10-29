package org.fiware.apps.repository.model;

import org.jboss.resteasy.links.ParentResource;
import org.jboss.resteasy.links.RESTServiceDiscovery;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "resource")
public class Resource extends AbstractResource{

	private String name="";
	private String contentUrl="";
	private String contentMimeType="";
	private String contentFileName="";
	byte[] content;
	
	
	@ParentResource
	private ResourceCollection collection;
	
	@XmlElementRef
	private RESTServiceDiscovery rest;

	@XmlElement() 
	public ResourceCollection getCollection() {
		return collection;
	}
	public void setCollection(ResourceCollection collection) {
		this.collection = collection;
	}
			
	@XmlElement
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
		

	@XmlElement
	public String getContentUrl() {	
		return contentUrl;
	}
	public void setContentUrl(String content) {
		this.contentUrl = content;
	}

	public byte[] getContent() {
		return content;
	}
	public void setContent(byte[] bs) {
		this.content = bs;
	}
	
	@XmlElement
	public String getContentMimeType() {
		return contentMimeType;
	}
	public void setContentMimeType(String contentMimeType) {
		this.contentMimeType = contentMimeType;
	}
	
	@XmlElement
	public String getContentFileName() {
		return contentFileName;
	}
	public void setContentFileName(String contentFileName) {
		this.contentFileName = contentFileName;
	}
}
