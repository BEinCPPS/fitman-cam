package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 *
 */
@XmlRootElement(name = "pagedServiceProviders")
public class ServiceProvidersResource {


    private int totalNumberServiceProviders;

    private List<ServiceProviderResource> serviceProviders;


    public ServiceProvidersResource() {
    }

    @XmlElement(name = "total")
    public int getTotalNumberServiceProviders() {
        return totalNumberServiceProviders;
    }

    public void setTotalNumberServiceProviders(int totalNumberServiceProviders) {
        this.totalNumberServiceProviders = totalNumberServiceProviders;
    }

    @XmlElement(name = "seviceProviders")
    public List<ServiceProviderResource> getServiceProviders() {
        return serviceProviders;
    }

    public void setServiceProviders(List<ServiceProviderResource> serviceProviders) {
        this.serviceProviders = serviceProviders;
    }
}
