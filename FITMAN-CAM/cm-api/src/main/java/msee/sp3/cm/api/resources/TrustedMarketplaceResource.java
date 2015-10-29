package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 */
@XmlRootElement(name = "trustedMarketplace")
public class TrustedMarketplaceResource {

    private FiwareMarketplaceResource fiwareMarketplace;

    @XmlElement(name = "fiwareMarketplace")
    public FiwareMarketplaceResource getFiwareMarketplace() {
        return fiwareMarketplace;
    }

    public void setFiwareMarketplace(FiwareMarketplaceResource fiwareMarketplace) {
        this.fiwareMarketplace = fiwareMarketplace;
    }
}
