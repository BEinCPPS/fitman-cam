/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.*;

/**
 *
 * @author Singular
 */
@XmlRootElement(name = "usdlRepository")
public class UsdlRepositoryResource {
    private int id;
    private String name;
    private String url;

    /**
     * @return the id
     */
    @XmlTransient
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the name
     */
    @XmlID
    @XmlAttribute
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the url
     */
    @XmlElement
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }
}
