package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.*;

/**
 *
 */
@XmlRootElement(name = "serviceTemplate")
public class ServiceTemplateResource {

    private int id;
    private String name;
    private String templateText;
    private String templateDescription;

    @XmlTransient
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @XmlID
    @XmlAttribute
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @XmlElement
    public String getTemplateText() {
        return templateText;
    }

    public void setTemplateText(String templateText) {
        this.templateText = templateText;
    }
    
    @XmlElement
    public String getTemplateDescription() {
        return templateDescription;
    }

    public void setTemplateDescription(String templateDescription) {
        this.templateDescription = templateDescription;
    }
}
