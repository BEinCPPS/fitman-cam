package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Map;

/**
 *
 */
@XmlRootElement(name = "instantiateRequest")
public class ServiceTemplateInstantiationRequest {

    private Map<String, String> variableValues;

    public ServiceTemplateInstantiationRequest() {
    }

    @XmlElementWrapper(name = "variableValues")
    public Map<String, String> getVariableValues() {
        return variableValues;
    }

    public void setVariableValues(Map<String, String> variableValues) {
        this.variableValues = variableValues;
    }
}
