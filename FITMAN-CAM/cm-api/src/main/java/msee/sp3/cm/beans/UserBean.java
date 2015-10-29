package msee.sp3.cm.beans;

import msee.sp3.cm.domain.FiwareMarketplace;
import msee.sp3.cm.domain.ServiceProvider;
import msee.sp3.cm.domain.TrustedMarketplace;
import msee.sp3.cm.fiware.marketplaceri.client.StatefulMarketplaceClient;
import msee.sp3.cm.fiware.marketplaceri.client.exception.AuthenticationException;
import msee.sp3.cm.fiware.marketplaceri.client.exception.UserAlreadyExistsException;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.fiware.apps.marketplace.model.Localuser;
import org.kpe.commons.jpa.IGenericDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
@Component("userBean")
public class UserBean implements IUserBean {

    private Logger logger = LoggerFactory.getLogger(UserBean.class);

    @Resource
    private IGenericDAO<ServiceProvider, Integer> serviceProviderDAO;

    @Resource
    private IGenericDAO<FiwareMarketplace, Integer> fiwareMarketplaceDAO;

    @Resource
    private IGenericDAO<TrustedMarketplace, Integer> trustedMarketplaceDAO;

    @Override
    @Transactional
    public void updateServiceProvider(String username, String password, String email, String company, List<String> trustedMarketplacesNames) {
        ServiceProvider toUpdate = serviceProviderDAO.querySingle("findByUsername", username);
        if (toUpdate == null) {
            throw new IllegalArgumentException(String.format("Could not locate service provider with username %s", username));
        }
        if (StringUtils.isNotBlank(email)) {
            toUpdate.setEmail(email);
        }
        if (StringUtils.isNotBlank(company)) {
            toUpdate.setCompany(company);
        }
        if (StringUtils.isNotBlank(password)) {
            toUpdate.setPasswordHash(password);
        }
        List<FiwareMarketplace> newTrustedFiwareMarketplaces = new ArrayList<FiwareMarketplace>();
        for (String name : trustedMarketplacesNames) {
            FiwareMarketplace fiwareMarketplace = fiwareMarketplaceDAO.querySingle("findByName", name);
            if (fiwareMarketplace == null) {
                throw new IllegalArgumentException(String.format("Could not locate fiware marketplace with name %s", name));
            }
            if (fiwareMarketplace != null) {
                newTrustedFiwareMarketplaces.add(fiwareMarketplace);
            }
        }
        List<FiwareMarketplace> currentlyTrustedMarketplaces = new ArrayList<FiwareMarketplace>();
        for (TrustedMarketplace tm : toUpdate.getTrustedMarketplaces()) {
            trustedMarketplaceDAO.delete(tm);
            currentlyTrustedMarketplaces.add(tm.getFiwareMarketplace());
        }
        // clear old relationships and establish new ones
        toUpdate.getTrustedMarketplaces().clear();

        for (FiwareMarketplace marketplace : newTrustedFiwareMarketplaces) {
//            if (!currentlyTrustedMarketplaces.contains(marketplace)) {
                TrustedMarketplace tm = new TrustedMarketplace();
                tm.setFiwareMarketplace(marketplace);
                tm.setServiceProvider(toUpdate);
                trustedMarketplaceDAO.create(tm);
                toUpdate.getTrustedMarketplaces().add(tm);
//            }
            // also inform marketplace about service provider
            StatefulMarketplaceClient smc = new StatefulMarketplaceClient();
            try {
                smc.startSessionWithBuiltinPrincipal(marketplace.getUrl());
                Localuser lu = smc.findLocaluser(toUpdate.getUsername());
                if (lu == null) {
                    lu = new Localuser();
                    lu.setCompany(toUpdate.getCompany());
                    lu.setEmail(toUpdate.getEmail());
                    lu.setUsername(toUpdate.getUsername());
                    lu.setPassword(toUpdate.getPasswordHash());
                    smc.saveLocalUser(lu);
                }else{
                    serviceProviderDAO.update(toUpdate);
                }
            } catch (AuthenticationException e) {
                logger.error("Could not authenticate with built-in principal to " + marketplace.getUrl(), e);
            } catch (UserAlreadyExistsException e) {
                // do nothing
                logger.debug("User Already Exists Exception");
                serviceProviderDAO.update(toUpdate);
            }catch(RuntimeException e){
                logger.error("Server error", e);
                serviceProviderDAO.update(toUpdate);
            }
        }
        serviceProviderDAO.update(toUpdate);
    }

    /**
     * Create a new service provider
     * @param username
     * @param password
     * @param email
     * @param company
     * @return persisted ServiceProviderApi instance
     */
    @Override
    @Transactional
    public ServiceProvider createServiceProvider(String username, String password, String email, String company) {

        logger.debug("Create service provider {}, {}", username, password);
        ServiceProvider sp = new ServiceProvider();
        sp.setUsername(username);
        sp.setPasswordHash(password);
        sp.setCompany(company);
        sp.setEmail(email);

        serviceProviderDAO.create(sp);
        logger.debug("Service provider {} created", username);
        return sp;
    }

    @Override
    @Transactional
    public void deleteServiceProvider(String username) {
        ServiceProvider toDelete = serviceProviderDAO.querySingle("findByUsername", username);
        if (toDelete == null) {
            throw new IllegalArgumentException(String.format("Could not locate service provider with username %s", username));
        }
        serviceProviderDAO.delete(toDelete);
    }

    @Override
    @Transactional(readOnly = true)
    public ServiceProvider authenticate(String username, String password) {
        ServiceProvider sp = null;
        try {
            sp = serviceProviderDAO.querySingle("findByUsernameAndPasswordHash", username, password);
        }
        catch (Exception e) {
            // swallow any exception
            logger.info(String.format("Could not authenticate %s", username), e);
        }
        return sp;
    }

    @Override
    @Transactional(readOnly = true)
    public ServiceProvider getServiceProvider(String username) {
        ServiceProvider sp = null;
        try {
            sp = serviceProviderDAO.querySingle("findByUsername", username);
        }
        catch (Exception e) {
            logger.info(String.format("Could not locate requested username %s", username), e);
        }
        return sp;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ServiceProvider> getServiceProviders(int from, int to) {
        List<ServiceProvider> sp = serviceProviderDAO.queryListRange("findAll", from, to);
        return sp;
    }

    @Override
    @Transactional(readOnly = true)
    public int countServiceProviders() {
        Number n = serviceProviderDAO.queryNumber("countAll");
        if (n != null)
            return n.intValue();
        else
            throw new RuntimeException("Could not count service providers");
    }



}
