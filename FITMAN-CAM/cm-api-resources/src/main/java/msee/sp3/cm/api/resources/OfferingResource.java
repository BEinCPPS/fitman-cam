package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Date;
import java.util.List;

/**
 *
 */
@XmlRootElement(name = "offering")
public class OfferingResource {

    private Integer id;
    private String offeringUri;
    private String offeringTitle;

    @Deprecated
    private String storeUrl;
    @Deprecated
    private List<String> serviceUris;
    @Deprecated
    private String pricePlanUri;
    @Deprecated
    private String pricePlanTitle;
    @Deprecated
    private List<String> priceComponentUris;
    @Deprecated
    private String name;

    private String serviceName;
    private String storeName;
    private String marketplaceName;

    /// new attributes, supported by M24 implementation
    private List<PricePlanResource> pricePlans;
    private String description;
    private Date validFrom, validThrough;

    @XmlAttribute
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @XmlElement
    public String getOfferingUri() {
        return offeringUri;
    }

    public void setOfferingUri(String offeringUri) {
        this.offeringUri = offeringUri;
    }

    @XmlElement
    public String getOfferingTitle() {
        return offeringTitle;
    }

    public void setOfferingTitle(String offeringTitle) {
        this.offeringTitle = offeringTitle;
    }

    @XmlElement
    public String getStoreUrl() {
        return storeUrl;
    }

    public void setStoreUrl(String storeUrl) {
        this.storeUrl = storeUrl;
    }

    @XmlElement
    public List<String> getServiceUris() {
        return serviceUris;
    }

    public void setServiceUris(List<String> serviceUris) {
        this.serviceUris = serviceUris;
    }

    @XmlElement
    public String getPricePlanUri() {
        return pricePlanUri;
    }

    public void setPricePlanUri(String pricePlanUri) {
        this.pricePlanUri = pricePlanUri;
    }

    @XmlElement
    public String getPricePlanTitle() {
        return pricePlanTitle;
    }

    public void setPricePlanTitle(String pricePlanTitle) {
        this.pricePlanTitle = pricePlanTitle;
    }

    @XmlElement
    public List<String> getPriceComponentUris() {
        return priceComponentUris;
    }

    public void setPriceComponentUris(List<String> priceComponentUris) {
        this.priceComponentUris = priceComponentUris;
    }

    @XmlElement
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @XmlElement
    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    @XmlElement
    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    @XmlElement
    public String getMarketplaceName() {
        return marketplaceName;
    }

    public void setMarketplaceName(String marketplaceName) {
        this.marketplaceName = marketplaceName;
    }

    @XmlElementWrapper(name = "pricePlans")
    public List<PricePlanResource> getPricePlans() {
        return pricePlans;
    }

    public void setPricePlans(List<PricePlanResource> pricePlans) {
        this.pricePlans = pricePlans;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidThrough() {
        return validThrough;
    }

    public void setValidThrough(Date validThrough) {
        this.validThrough = validThrough;
    }
}
