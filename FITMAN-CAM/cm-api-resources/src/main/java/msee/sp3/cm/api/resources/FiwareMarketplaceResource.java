package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.*;

/**
 *
 */
@XmlRootElement(name = "fiwareMarketplace")
public class FiwareMarketplaceResource {

    private int id;

    private String name;

    private String url;

//    private ServiceProviderResource creator;

    @XmlTransient
    public int getId() {
        return id;
    }

    public void setId(int id) {
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

//    @XmlElement
//    public ServiceProviderResource getCreator() {
//        return creator;
//    }
//
//    public void setCreator(ServiceProviderResource creator) {
//        this.creator = creator;
//    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof FiwareMarketplaceResource)) return false;

        FiwareMarketplaceResource that = (FiwareMarketplaceResource) o;

        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return name != null ? name.hashCode() : 0;
    }
}
