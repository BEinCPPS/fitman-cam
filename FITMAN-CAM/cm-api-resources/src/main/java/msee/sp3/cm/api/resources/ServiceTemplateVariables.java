package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 */
@XmlRootElement( name = "serviceTemplateVariables")
public class ServiceTemplateVariables {
    private List<String> variables;

    public ServiceTemplateVariables() {
        this.variables = new ArrayList<String>();
    }

    public ServiceTemplateVariables(List<String> variables) {
        this.variables = variables;
    }

    @XmlElement(name = "variables")
    public List<String> getVariables() {
        return variables;
    }

    public void setVariables(List<String> variables) {
        this.variables = variables;
    }
}
