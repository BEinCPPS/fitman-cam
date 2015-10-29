
package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 *
 * @author Singular
 */
@XmlRootElement(name = "pagedUsdlRepositories")
public class UsdlRepositoriesResource {
    
    private int totalNumberUsdlRepositories;

    private List<UsdlRepositoryResource> usdlRepositories;

    public UsdlRepositoriesResource() {
    }
    
    @XmlElement(name = "total")
    public int getTotalNumberUsdlRepositories() {
        return totalNumberUsdlRepositories;
    }

    public void setTotalNumberUsdlRepositories(int totalNumberUsdlRepositories) {
        this.totalNumberUsdlRepositories = totalNumberUsdlRepositories;
    }

    @XmlElement(name = "usdlRepositories")
    public List<UsdlRepositoryResource> getUsdlRepositories() {
        return usdlRepositories;
    }

    public void setUsdlRepositories(List<UsdlRepositoryResource> usdlRepositories) {
        this.usdlRepositories = usdlRepositories;
    }
}
