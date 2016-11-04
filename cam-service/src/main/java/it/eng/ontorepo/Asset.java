package it.eng.ontorepo;

/**
 * Created by ascatolo on 04/11/2016.
 */
public class Asset extends IndividualItem {

    private String domain;
    private String domainIri;
    private String createdOn;
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

    public Asset(IndividualItem individualItem, String domain, String createdOn, boolean lostDomain) {
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

    public String getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
    }

    public String getDomainIri() {
        return domainIri;
    }

    public void setDomainIri(String domainIri) {
        this.domainIri = domainIri;
    }
}
