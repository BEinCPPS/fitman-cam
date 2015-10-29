package msee.sp3.cm.beans;

import msee.sp3.cm.domain.ServiceTemplate;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 *
 */
public interface IServiceTemplateBean {

    ///////////////////////
    // Standard CRUD stuff
    ///////////////////////

    @Transactional(readOnly = true)
    ServiceTemplate getServiceTemplate(String name);

    @Transactional
    ServiceTemplate createServiceTemplate(String name, String templateText, String templateDescription);

    @Transactional
    ServiceTemplate updateServiceTemplate(String name, String newName, String templateText, String templateDescription);

    @Transactional
    void deleteServiceTemplate(String name);

    /**
     * Obtain a [from, to) paged list of service templates, sorted by name.
     * @param from
     * @param to
     * @return list of service templates, maximum number of items returned is to-from
     */
    @Transactional(readOnly = true)
    List<ServiceTemplate> getServiceTemplates(int from, int to);

    @Transactional(readOnly = true)
    int countServiceTemplates();

    ///////////////////////
    // Templating
    ///////////////////////

    /**
     * Given a template name, return its variable names
     * @param serviceTemplateName
     * @return names of variables in identified service template or {@code null} if no such template exists.
     */
    List<String> getVariableNames(String serviceTemplateName);

    /**
     * Instantiate the identified service template with the values provided as argument.
     * @param serviceTemplateName
     * @param variables
     * @return the template with variables substituted according to input.
     */
    String instantiateTemplate(String serviceTemplateName, Map<String, String> variables);

}
