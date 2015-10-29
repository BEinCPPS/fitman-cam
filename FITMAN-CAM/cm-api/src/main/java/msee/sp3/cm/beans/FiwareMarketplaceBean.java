package msee.sp3.cm.beans;

import msee.sp3.cm.domain.FiwareMarketplace;
import msee.sp3.cm.domain.ServiceProvider;
import msee.sp3.cm.domain.TrustedMarketplace;
import org.kpe.commons.jpa.IGenericDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.persistence.NoResultException;
import java.util.List;

/**
 *
 */
@Component("fiwareMarketplaceBean")
public class FiwareMarketplaceBean implements IFiwareMarketplaceBean {

    private Logger logger = LoggerFactory.getLogger(FiwareMarketplaceBean.class);

    @Resource
    private IGenericDAO<FiwareMarketplace, Integer> fiwareMarketplaceDAO;

    @Resource
    private IGenericDAO<TrustedMarketplace, Integer> trustedMarketplaceDAO;

    @Override
    @Transactional
    public void updateFiwareMarketplace(String name, String newName, String url) {
        FiwareMarketplace toUpdate = fiwareMarketplaceDAO.querySingle("findByName", name);
        if (toUpdate == null) {
            throw new IllegalArgumentException(String.format("Could not locate marketplace with name %s", name));
        }
        toUpdate.setName(newName);
        toUpdate.setUrl(url);
        fiwareMarketplaceDAO.update(toUpdate);
    }

    /**
     * Create a new FiwareMarketplace
     * @return
     */
    @Override
    @Transactional
    public FiwareMarketplace createFiwareMarketplace(String name, String url) {

        logger.debug("Create fiware marketplace {}, {}", name, url);
        FiwareMarketplace sp = new FiwareMarketplace();
        sp.setName(name);
        sp.setUrl(url);

        fiwareMarketplaceDAO.create(sp);
        logger.debug("FiwareMarketplace {} created", name);
        return sp;
    }

    @Override
    @Transactional
    public void deleteFiwareMarketplace(String name) {
        logger.debug("Deleting fiware marketplace {}", name);
        FiwareMarketplace toDelete = fiwareMarketplaceDAO.querySingle("findByName", name);
        if (toDelete == null) {
            throw new IllegalArgumentException(String.format("Could not locate FiwareMarketplace with name %s", name));
        }

        // remove from trusted marketplaces
        int rows = trustedMarketplaceDAO.executeUpdate("deleteByFiwareMarketplace", toDelete);
        logger.info("Removed {} rows by deleteByFiwareMarketplace", rows);
        // remove the object itself
        fiwareMarketplaceDAO.delete(toDelete);
    }

    @Override
    @Transactional(readOnly = true)
    public FiwareMarketplace getFiwareMarketplace(String name) {
        FiwareMarketplace fm = null;
        try {
            fm = fiwareMarketplaceDAO.querySingle("findByName", name);
        }
        catch (NoResultException e) {
        }
        return fm;
    }

    @Override
    @Transactional(readOnly = true)
    public List<FiwareMarketplace> getFiwareMarketplaces(int from, int to) {
        List<FiwareMarketplace> sp = null;
        if (from ==0 && to ==-1) {
            sp = fiwareMarketplaceDAO.queryList("findAll");
        }
        else if (to > from) {
            sp = fiwareMarketplaceDAO.queryListRange("findAll", from, (to-from));
        }
        return sp;
    }

    @Override
    @Transactional(readOnly = true)
    public int countFiwareMarketplaces() {
        Number n = fiwareMarketplaceDAO.queryNumber("countAll");
        if (n != null)
            return n.intValue();
        else
            throw new RuntimeException("Could not count service providers");
    }



}
