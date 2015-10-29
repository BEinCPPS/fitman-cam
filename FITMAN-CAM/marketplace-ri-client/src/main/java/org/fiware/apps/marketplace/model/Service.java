package org.fiware.apps.marketplace.model;

import javax.xml.bind.annotation.*;
import java.util.Date;
import java.util.List;

@XmlRootElement(name = "resource")
public class Service {
	private Integer  id;
	private String url;
	private String name;
	private String Description;
	private Date registrationDate;
	private Store store;
	private Localuser lasteditor;	
	private Localuser creator;

    private List<ServiceOffering> offerings;

	public Integer  getId() {
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
	public Store getStore() {
		return store;
	}
	public void setStore(Store store) {
		this.store = store;
	}
	
	@XmlElement
	//@XmlTransient
	public Localuser getLasteditor() {
		return lasteditor;
	}
	public void setLasteditor(Localuser lasteditor) {
		this.lasteditor = lasteditor;
	}
	
	@XmlElement
	//@XmlTransient
	public Localuser getCreator() {
		return creator;
	}
	public void setCreator(Localuser creator) {
		this.creator = creator;
	}

    @XmlElementWrapper(name = "serviceOfferings")
    @XmlElement(name = "serviceOffering")
    public List<ServiceOffering> getOfferings() {
        return offerings;
    }

    public void setOfferings(List<ServiceOffering> offerings) {
        this.offerings = offerings;
    }

    @Override
    public String toString() {
        return "Service{" +
                "id=" + id +
                ", url='" + url + '\'' +
                ", name='" + name + '\'' +
                ", Description='" + Description + '\'' +
                ", registrationDate=" + registrationDate +
                ", store=" + store +
                ", lasteditor=" + lasteditor +
                ", creator=" + creator +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Service)) return false;

        Service service = (Service) o;

        if (!name.equals(service.name)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
