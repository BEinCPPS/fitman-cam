package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 *
 */
@XmlRootElement(name = "pagedFiwareMarketplaces")
public class FiwareMarketplacesResource {


    private int totalNumberFiwareMarketplaces;

    private List<FiwareMarketplaceResource> fiwareMarketplaces;


    public FiwareMarketplacesResource() {
    }

    @XmlElement(name = "total")
    public int getTotalNumberFiwareMarketplaces() {
        return totalNumberFiwareMarketplaces;
    }

    public void setTotalNumberFiwareMarketplaces(int totalNumberFiwareMarketplaces) {
        this.totalNumberFiwareMarketplaces = totalNumberFiwareMarketplaces;
    }

    @XmlElement(name = "fiwareMarketplaces")
    public List<FiwareMarketplaceResource> getFiwareMarketplaces() {
        return fiwareMarketplaces;
    }

    public void setFiwareMarketplaces(List<FiwareMarketplaceResource> fiwareMarketplaces) {
        this.fiwareMarketplaces = fiwareMarketplaces;
    }
}
