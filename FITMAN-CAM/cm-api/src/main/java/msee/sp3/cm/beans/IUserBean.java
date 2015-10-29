package msee.sp3.cm.beans;

import msee.sp3.cm.domain.ServiceProvider;
import msee.sp3.cm.domain.TrustedMarketplace;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 *
 */
public interface IUserBean {
    /**
     *
     * @param username
     * @param password
     * @param email
     * @param company
     * @return persisted ServiceProviderApi instance
     */
    @Transactional
    ServiceProvider createServiceProvider(String username, String password, String email, String company);

    /**
     * Update service provider by username
     * @param username
     * @param password
     * @param email
     * @param company
     * @return
     */
    @Transactional
    void updateServiceProvider(String username, String password, String email, String company, List<String> trustedMarketplacesNames);

    @Transactional
    void deleteServiceProvider(String username);

    @Transactional(readOnly = true)
    ServiceProvider authenticate(String username, String password);

    @Transactional(readOnly = true)
    public List<ServiceProvider> getServiceProviders(int from, int to);

    @Transactional(readOnly = true)
    public int countServiceProviders();

    @Transactional(readOnly = true)
    ServiceProvider getServiceProvider(String username);
}
