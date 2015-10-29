package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlID;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Date;

/**
 *
 */
@XmlRootElement(name = "service")
public class ServiceResource {
    private String url;
    private String name;
    private String Description;
    private Date registrationDate;
    private String storeName;
    private String marketplaceName;
    private ServiceProviderResource creator;

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


    @XmlElement
    public String getStoreName() {
        return storeName;
    }
    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }


    @XmlElement
    public ServiceProviderResource getCreator() {
        return creator;
    }
    public void setCreator(ServiceProviderResource creator) {
        this.creator = creator;
    }

    @XmlElement
    public String getMarketplaceName() {
        return marketplaceName;
    }

    public void setMarketplaceName(String marketplaceName) {
        this.marketplaceName = marketplaceName;
    }

    @Override
    public String toString() {
        return "ServiceResource{" +
                "url='" + url + '\'' +
                ", name='" + name + '\'' +
                ", description='" + Description + '\'' +
                ", registrationDate=" + registrationDate +
                ", storeName='" + storeName + '\'' +
                ", creator=" + creator +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ServiceResource)) return false;

        ServiceResource service = (ServiceResource) o;

        if (!name.equals(service.name)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
