/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package msee.sp3.cm.beans;

import java.util.List;
import msee.sp3.cm.domain.UsdlRepository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Singular
 */
public interface IUsdlRepositoryBean {
    
    @Transactional(readOnly = true)
    UsdlRepository getUsdlRepository(String name);
    
    /**
     * Obtain a [from, to) paged list of usdl repositories, sorted by name. To obtain all,
     * use from = 0 & to = -1.
     * @param from
     * @param to
     * @return list of usdl repositories, maximum number of items returned is to-from
     */
    @Transactional(readOnly = true)
    List<UsdlRepository> getUsdlRepositories(int from, int to);
    
    @Transactional
    UsdlRepository createUsdlRepository(String name, String url);

    @Transactional
    UsdlRepository updateUsdlRepository(String name, String newName, String url);

    @Transactional
    void deleteUsdlRepository(String name);
    
    @Transactional(readOnly = true)
    public int countUsdlRepositories();

    @Transactional(readOnly = true)
    public String uploadUsdlToRepository(String repositoryName, String usdlId, String usdlBody);
}
