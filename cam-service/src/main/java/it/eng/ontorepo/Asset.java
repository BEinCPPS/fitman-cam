package it.eng.ontorepo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * Created by ascatolo on 04/11/2016.
 */
public class Asset extends IndividualItem {

    private String domain; //domainName
    private String domainIri;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="CET")
    private Date createdOn;
    private boolean lostDomain;

    public boolean isLostDomain() {
        return lostDomain;
    }

    public void setLostDomain(boolean lostDomain) {
        this.lostDomain = lostDomain;
    }

    public Asset(String namespace, String name, String clazz) {
        super(namespace, name, clazz);
    }

    public Asset(IndividualItem individualItem, boolean lostDomain) {
        super(individualItem.getNamespace(), individualItem.getIndividualName(), individualItem.getClassName());
        this.lostDomain = lostDomain;
    }

    public Asset(IndividualItem individualItem, String domain, Date createdOn, boolean lostDomain) {
        super(individualItem.getNamespace(), individualItem.getIndividualName(), individualItem.getClassName());
        this.lostDomain = lostDomain;
        this.createdOn = createdOn;
        this.domain = domain;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public String getDomainIri() {
        return domainIri;
    }

    public void setDomainIri(String domainIri) {
        this.domainIri = domainIri;
    }
}
