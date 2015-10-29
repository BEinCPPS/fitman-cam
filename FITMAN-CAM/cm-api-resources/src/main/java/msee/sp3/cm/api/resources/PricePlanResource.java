package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.*;
import java.util.List;

/**
 *
 */
@XmlRootElement(name = "pricePlan")
public class PricePlanResource {

    private Integer id;
    private String title;
    private String description;

    // price components within this price plan
    private List<PriceComponentResource> priceComponents;

    @XmlTransient
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @XmlID
    @XmlAttribute
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @XmlElement
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlElementWrapper(name = "priceComponents")
    public List<PriceComponentResource> getPriceComponents() {
        return priceComponents;
    }

    public void setPriceComponents(List<PriceComponentResource> priceComponents) {
        this.priceComponents = priceComponents;
    }
}
