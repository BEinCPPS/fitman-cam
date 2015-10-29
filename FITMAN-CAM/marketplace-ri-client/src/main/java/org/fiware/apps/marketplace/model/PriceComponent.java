package org.fiware.apps.marketplace.model;

import org.codehaus.jackson.annotate.JsonIgnore;

import javax.xml.bind.annotation.*;
import java.math.BigDecimal;

@XmlRootElement(name = "priceComponent")
public class PriceComponent {
	private Integer id;
	private String title;
	private String description;
    private String currency;
    private String unitOfMeasurement;
    private BigDecimal value;

    // owner service
    private PricePlan pricePlan;

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
    public java.lang.String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    @XmlElement
    public java.lang.String getUnitOfMeasurement() {
        return unitOfMeasurement;
    }

    public void setUnitOfMeasurement(String unitOfMeasurement) {
        this.unitOfMeasurement = unitOfMeasurement;
    }

    @XmlElement
    public java.math.BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    @JsonIgnore
    @XmlTransient
    public PricePlan getPricePlan() {
        return pricePlan;
    }

    public void setPricePlan(PricePlan pricePlan) {
        this.pricePlan = pricePlan;
    }

    @Override
    public String toString() {
        return "PriceComponent{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", currency='" + currency + '\'' +
                ", unitOfMeasurement='" + unitOfMeasurement + '\'' +
                ", value=" + value +
                ", pricePlan=" + pricePlan +
                '}';
    }
}
