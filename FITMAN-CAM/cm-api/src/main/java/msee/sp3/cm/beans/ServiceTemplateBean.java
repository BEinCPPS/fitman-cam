package msee.sp3.cm.beans;

import freemarker.cache.StringTemplateLoader;
import freemarker.core.FreemarkerUtil;
import freemarker.core.TemplateElement;
import freemarker.template.Configuration;
import freemarker.template.Template;
import msee.sp3.cm.domain.ServiceTemplate;
import org.kpe.commons.jpa.IGenericDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.persistence.NoResultException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

/**
 *
 */
@Component("serviceTemplateBean")
public class ServiceTemplateBean implements IServiceTemplateBean {

    private Logger logger = LoggerFactory.getLogger(ServiceTemplateBean.class);

    @Resource
    private IGenericDAO<ServiceTemplate, Integer> serviceTemplateDAO;

    @Override
    public ServiceTemplate getServiceTemplate(String name) {
        ServiceTemplate st = null;
        try {
            st = serviceTemplateDAO.querySingle("findByName", name);
        }
        catch (NoResultException nre) {
            logger.debug("No service template found for {}", name);
        }
        return st;
    }

    @Override
    public ServiceTemplate createServiceTemplate(String name, String templateText, String templateDescription) {
        ServiceTemplate st = new ServiceTemplate();
        st.setName(name);
        st.setTemplateText(templateText);
        st.setTemplateDescription(templateDescription);

        serviceTemplateDAO.create(st);

        return st;
    }

    @Override
    public ServiceTemplate updateServiceTemplate(String name, String newName, String templateText, String templateDescription) {
        logger.debug("Updating ServiceTemplate {}", name);

        ServiceTemplate st = null;
        try {
            st = serviceTemplateDAO.querySingle("findByName", name);
        }
        catch (NoResultException nre) {
            throw new IllegalArgumentException(String.format("Could not locate ServiceTemplate with name %s", name));
        }

        st.setName(newName);
        st.setTemplateText(templateText);
        st.setTemplateDescription(templateDescription);
        serviceTemplateDAO.update(st);
        return st;
    }

    @Override
    public void deleteServiceTemplate(String name) {
        logger.debug("Deleting ServiceTemplate {}", name);

        ServiceTemplate st = null;
        try {
            st = serviceTemplateDAO.querySingle("findByName", name);
        }
        catch (NoResultException nre) {
            throw new IllegalArgumentException(String.format("Could not locate ServiceTemplate with name %s", name));
        }

        serviceTemplateDAO.delete(st);
    }

    @Override
    public List<ServiceTemplate> getServiceTemplates(int from, int to) {
        List<ServiceTemplate> sp = null;
        if (from ==0 && to ==-1) {
            sp = serviceTemplateDAO.queryList("findAll");
        }
        else if (to > from) {
            sp = serviceTemplateDAO.queryListRange("findAll", from, (to-from));
        }
        return sp;
    }

    @Override
    public int countServiceTemplates() {
        Number n = serviceTemplateDAO.queryNumber("countAll");
        if (n != null)
            return n.intValue();
        else
            throw new RuntimeException("Could not count service providers");
    }

    @Override
    public List<String> getVariableNames(String serviceTemplateName) {
        ServiceTemplate st = getServiceTemplate(serviceTemplateName);

        if (st == null) {
            return null;
        }

        return FreemarkerUtil.getVariablesInTemplate(st.getTemplateText());

    }

    @Override
    public String instantiateTemplate(String serviceTemplateName, Map<String, String> variables) {
        ServiceTemplate st = getServiceTemplate(serviceTemplateName);

        if (st == null) {
            return null;
        }

        String instance = FreemarkerUtil.processTemplate(st.getTemplateText(), variables);

        return instance;
    }
}
