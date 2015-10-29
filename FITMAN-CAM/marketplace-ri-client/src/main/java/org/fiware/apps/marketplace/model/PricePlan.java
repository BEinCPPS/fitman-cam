package org.fiware.apps.marketplace.model;

import org.codehaus.jackson.annotate.JsonIgnore;

import javax.xml.bind.annotation.*;
import java.util.List;

@XmlRootElement(name = "pricePlan")
public class PricePlan {
	private Integer id;
	private String title;
	private String description;

    // owner service
    private ServiceOffering serviceOffering;

    // price components within this price plan
    private List<PriceComponent> priceComponents;

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


    @JsonIgnore
	@XmlTransient
	public ServiceOffering getServiceOffering() {
		return serviceOffering;
	}
	public void setServiceOffering(ServiceOffering serviceOffering) {
		this.serviceOffering = serviceOffering;
	}

    @XmlElementWrapper(name = "priceComponents")
    @XmlElement(name = "priceComponent")
    public java.util.List<PriceComponent> getPriceComponents() {
        return priceComponents;
    }

    public void setPriceComponents(List<PriceComponent> priceComponents) {
        this.priceComponents = priceComponents;
    }

    @Override
    public String toString() {
        return "PricePlan{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", serviceOffering=" + serviceOffering +
                '}';
    }
}
