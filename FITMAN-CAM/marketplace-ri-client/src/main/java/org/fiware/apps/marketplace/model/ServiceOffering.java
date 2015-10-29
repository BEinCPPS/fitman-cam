package org.fiware.apps.marketplace.model;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.dozer.Mapping;

import javax.xml.bind.annotation.*;
import java.util.Date;
import java.util.List;

@XmlRootElement(name = "offering")
public class ServiceOffering {
	private Integer id;
    @Mapping("offeringTitle")
	private String title;
	private String description;
	private Date validFrom;
    private Date validThrough;
    // owner service
    private String serviceName;
    // owner store
    private String storeName;

    private List<PricePlan> pricePlans;

	public java.lang.Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@XmlID
	@XmlAttribute
	public java.lang.String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@XmlElement
	public java.lang.String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	@XmlElement
	public java.util.Date getValidFrom() {
		return validFrom;
	}
	public void setValidFrom(Date validFrom) {
		this.validFrom = validFrom;
	}

    @XmlElement
    public java.util.Date getValidThrough() {
        return validThrough;
    }
    public void setValidThrough(Date validThrough) {
        this.validThrough = validThrough;
    }

    @XmlElement(name = "parentService")
    public java.lang.String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    @XmlElement(name = "parentStore")
    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    @XmlElementWrapper(name = "pricePlans")
    @XmlElement(name = "pricePlan")
    public java.util.List<PricePlan> getPricePlans() {
        return pricePlans;
    }
    public void setPricePlans(List<PricePlan> pricePlans) {
        this.pricePlans = pricePlans;
    }

    @Override
    public String toString() {
        return "ServiceOffering{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", validFrom=" + validFrom +
                ", validThrough=" + validThrough +
                '}';
    }
}
