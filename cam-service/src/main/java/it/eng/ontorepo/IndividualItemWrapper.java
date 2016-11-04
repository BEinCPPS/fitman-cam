package it.eng.ontorepo;

/**
 * Created by ascatolo on 03/11/2016.
 */
public class IndividualItemWrapper {

    private IndividualItem individualItem;
    private boolean lostDomain;

    public IndividualItemWrapper(IndividualItem individualItem, boolean brokenDomain) {
        this.individualItem = individualItem;
        this.lostDomain = brokenDomain;
    }

    public IndividualItemWrapper(IndividualItem individualItem) {
        this.individualItem = individualItem;
    }


    public IndividualItem getIndividualItem() {
        return individualItem;
    }


    public void setIndividualItem(IndividualItem individualItem) {
        this.individualItem = individualItem;
    }

    public boolean isLostDomain() {
        return lostDomain;
    }

    public void setLostDomain(boolean lostDomain) {
        this.lostDomain = lostDomain;
    }


}
