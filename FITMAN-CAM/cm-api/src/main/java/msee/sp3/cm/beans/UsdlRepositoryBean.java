/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package msee.sp3.cm.beans;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.NoResultException;
import msee.sp3.cm.domain.UsdlRepository;
import msee.sp3.cm.repository.client.ResourceClient;
import org.apache.commons.lang.StringUtils;
import org.kpe.commons.jpa.IGenericDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 *
 * @author Singular
 */
@Component("usdlRepositoryBean")
public class UsdlRepositoryBean implements IUsdlRepositoryBean {

    private Logger logger = LoggerFactory.getLogger(UsdlRepositoryBean.class);
    
    @Resource
    private IGenericDAO<UsdlRepository, Integer> usdlRepositoryDAO;
    
    public UsdlRepository getUsdlRepository(String name) {
        UsdlRepository ur = null;
        try {
            ur = usdlRepositoryDAO.querySingle("findByName", name);
        }
        catch (NoResultException nre) {
            logger.debug("No usdl repository found for {}", name);
        }
        return ur;
    }

    public List<UsdlRepository> getUsdlRepositories(int from, int to) {
        List<UsdlRepository> ur = null;
        if (from ==0 && to ==-1) {
            ur = usdlRepositoryDAO.queryList("findAll");
        }
        else if (to > from) {
            ur = usdlRepositoryDAO.queryListRange("findAll", from, (to-from));
        }
        return ur;
    }

    public UsdlRepository createUsdlRepository(String name, String url) {
        UsdlRepository ur = new UsdlRepository();
        ur.setName(name);
        ur.setUrl(url);
        
        usdlRepositoryDAO.create(ur);
        
        return ur;
    }

    public UsdlRepository updateUsdlRepository(String name, String newName, String url) {
        logger.debug("Updating UsdlRepository {}", name);

        UsdlRepository ur = null;
        try {
            ur = usdlRepositoryDAO.querySingle("findByName", name);
        }
        catch (NoResultException nre) {
            throw new IllegalArgumentException(String.format("Could not locate UsdlRepository with name %s", name));
        }

        ur.setName(newName);
        ur.setUrl(url);
        usdlRepositoryDAO.update(ur);
        return ur;
    }

    public void deleteUsdlRepository(String name) {
        logger.debug("Deleting UsdlRepository with name {}", name);
        UsdlRepository ur = null;

        try {
            ur = usdlRepositoryDAO.querySingle("findByName", name);
        } catch (NoResultException nre) {
            throw new IllegalArgumentException(String.format("Could not locate UsdlRepository with name %s", name));
        }
        usdlRepositoryDAO.delete(ur);
    }

    public int countUsdlRepositories() {
        Number n = usdlRepositoryDAO.queryNumber("countAll");
        if (n != null) {
            return n.intValue();
        }
        else {
            throw new RuntimeException("Could not count usdl repositories");
        }
    }

    @Override
    public String uploadUsdlToRepository(String repositoryName, String usdlId, String usdlBody) {
        logger.debug("Uploading USDL {} to repository {}", usdlId, repositoryName);

        if (StringUtils.isBlank(repositoryName) || StringUtils.isBlank(usdlId) || StringUtils.isBlank(usdlBody)) {
            throw new IllegalArgumentException("All parameters must be non-blank.");
        }

        if (!StringUtils.isAsciiPrintable(usdlId)) {
            throw new IllegalArgumentException("USDL ID must be in the ASCII printable range");
        }

        UsdlRepository ur = getUsdlRepository(repositoryName);
        if (ur == null) {
            throw new IllegalArgumentException("Could not locate repository " + repositoryName);
        }

        ResourceClient rc = new ResourceClient(ur.getUrl());
        Boolean result = rc.insertResourceString("/msee/" + usdlId, usdlBody, "application/xml");
        if (result != null && result == false) {
            logger.error("Could not upload USDL with ID {} to repository {}", usdlId, repositoryName);
            throw new RuntimeException("Failure attempting to upload USDL to repository");
        }

        StringBuilder usdlUrlBuilder = new StringBuilder();
        usdlUrlBuilder.append(ur.getUrl());
        if (!ur.getUrl().endsWith("/")) {
            usdlUrlBuilder.append("/");
        }
        usdlUrlBuilder.append("msee/");
        usdlUrlBuilder.append(usdlId);

        return usdlUrlBuilder.toString();
    }
}
