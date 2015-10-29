package org.fiware.apps.repository.model;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlID;
import javax.xml.bind.annotation.XmlSeeAlso;
import java.util.Date;

@XmlSeeAlso({Resource.class, ResourceCollection.class})
public abstract class AbstractResource {

	private String id;
	private Date creationDate;
	private Date modificationDate;
	private String creator="";	
	


	@XmlID
	@XmlAttribute 
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@XmlElement
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	@XmlElement
	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	} 
	
	@XmlElement
	public Date getModificationDate() {
		return modificationDate;
	}

	public void setModificationDate(Date modificationDate) {
		this.modificationDate = modificationDate;
	}
	
}
