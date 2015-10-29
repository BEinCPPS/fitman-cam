package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 *
 */
@XmlRootElement(name = "pagedServiceTemplates")
public class ServiceTemplatesResource {


    private int totalNumberServiceTemplates;

    private List<ServiceTemplateResource> serviceTemplates;

    public ServiceTemplatesResource() {
    }

    @XmlElement(name = "total")
    public int getTotalNumberServiceTemplates() {
        return totalNumberServiceTemplates;
    }

    public void setTotalNumberServiceTemplates(int totalNumberServiceTemplates) {
        this.totalNumberServiceTemplates = totalNumberServiceTemplates;
    }

    @XmlElement(name = "serviceTemplates")
    public List<ServiceTemplateResource> getServiceTemplates() {
        return serviceTemplates;
    }

    public void setServiceTemplates(List<ServiceTemplateResource> serviceTemplates) {
        this.serviceTemplates = serviceTemplates;
    }
}
