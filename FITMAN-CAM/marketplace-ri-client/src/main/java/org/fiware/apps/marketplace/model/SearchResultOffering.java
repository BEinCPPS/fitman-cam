package org.fiware.apps.marketplace.model;

import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 *
 */
@XmlRootElement(name = "offeringResults")
public class SearchResultOffering {

    private List<ServiceOffering> offering;

    public SearchResultOffering() {
    }

    @XmlElementWrapper(name = "offerings")
    public List<ServiceOffering> getOffering() {
        return offering;
    }

    public void setOffering(List<ServiceOffering> offering) {
        this.offering = offering;
    }
}
