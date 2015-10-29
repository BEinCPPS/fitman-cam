package org.fiware.apps.marketplace.model;

import javax.xml.bind.annotation.*;
import java.util.Date;
import java.util.List;

@XmlRootElement(name = "store")
public class Store {
	private Integer  id;
	private String url;
	private String name;
	private String Description;
	private Date registrationDate;
	private List <Service> services;
	private Localuser lasteditor;	
	private Localuser creator;
	
	@XmlTransient
	public Integer getId() {
		return id;
	}
	public void setId(Integer  id) {
		this.id = id;
	}
	
	@XmlID
	@XmlAttribute
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@XmlElement
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	
	@XmlElement
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	
	@XmlElement
	public Date getRegistrationDate() {
		return registrationDate;
	}
	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}
	

	@XmlTransient
	public List<Service> getServices() {
		return services;
	}
	public void setServices(List<Service> services) {
		this.services = services;
	}
	
	@XmlElement
	public Localuser getLasteditor() {
		return lasteditor;
	}
	public void setLasteditor(Localuser lasteditor) {
		this.lasteditor = lasteditor;
	}
	
	@XmlElement
	public Localuser getCreator() {
		return creator;
	}
	public void setCreator(Localuser creator) {
		this.creator = creator;
	}

    @Override
    public String toString() {
        return "Store{" +
                "id=" + id +
                ", url='" + url + '\'' +
                ", name='" + name + '\'' +
                ", Description='" + Description + '\'' +
                ", creator=" + creator +
                ", lasteditor=" + lasteditor +
                ", registrationDate=" + registrationDate +
                '}';
    }
}
