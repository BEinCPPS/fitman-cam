package msee.sp3.cm.beans;

import msee.sp3.cm.domain.FiwareMarketplace;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 *
 */
public interface IFiwareMarketplaceBean {
    @Transactional
    void updateFiwareMarketplace(String name, String newName, String url);

    /**
     * Create a new FiwareMarketplace
     * @return
     */
    @Transactional
    FiwareMarketplace createFiwareMarketplace(String name, String url);

    void deleteFiwareMarketplace(String name);

    @Transactional(readOnly = true)
    FiwareMarketplace getFiwareMarketplace(String name);

    @Transactional(readOnly = true)
    List<FiwareMarketplace> getFiwareMarketplaces(int from, int to);

    @Transactional(readOnly = true)
    int countFiwareMarketplaces();
}
