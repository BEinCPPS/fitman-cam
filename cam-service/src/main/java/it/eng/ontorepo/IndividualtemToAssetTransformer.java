package it.eng.ontorepo;

import it.eng.cam.rest.sesame.SesameRepoManager;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ascatolo on 03/11/2016.
 */
public class IndividualtemToAssetTransformer {


    public static List<Asset> transformAll(RepositoryDAO dao, List<IndividualItem> individuals, boolean lostDomain) throws java.text.ParseException {
        return doTransformAll(dao, individuals, lostDomain);
    }

    public static List<Asset> transformAll(RepositoryDAO dao, List<IndividualItem> individuals) throws java.text.ParseException {
        return doTransformAll(dao, individuals, false);
    }

    private static List<Asset> doTransformAll(RepositoryDAO dao, List<IndividualItem> individuals, boolean lostDomain) throws java.text.ParseException {
        List<Asset> individualItemWrappers = new ArrayList<>();
        if (individuals == null) return null;
        for (IndividualItem individual :
                individuals) {
            individualItemWrappers.add(transform(dao, individual, lostDomain));
        }
        return individualItemWrappers;
    }

    public static Asset transform(RepositoryDAO dao, IndividualItem individual, boolean lostDomain) throws java.text.ParseException {
        return doTransform(dao, individual, lostDomain);
    }

    public static Asset transform(RepositoryDAO dao, IndividualItem individual) throws java.text.ParseException {
        return doTransform(dao, individual, false);
    }

    private static Asset doTransform(RepositoryDAO dao, IndividualItem individual, boolean lostDomain) throws java.text.ParseException {
        SesameRepoManager.releaseRepoDaoConn(dao);
        dao = SesameRepoManager.getRepoInstance(null);
        String domain = "";
        String domainIri = ""; //TODO
        String date = "";
        List<PropertyValueItem> individualAttributes = dao.getIndividualAttributes(individual.getIndividualName());
        for (PropertyValueItem attribute :
                individualAttributes) {
            if (attribute.getNormalizedName().contains(BeInCpps.ownedBy)) {
                String[] split = attribute.getPropertyValue().split("#");
                domain = split[1];
                domainIri = attribute.getPropertyValue();
            } else if (attribute.getNormalizedName().contains(BeInCpps.createdOn)) {
                Date data = DateUtils.parseDate(attribute.getPropertyValue(), "yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
                date = DateFormatUtils.format(data, "dd/MM/yyyy");
            }

        }
        Asset asset = new Asset(individual, domain, date, lostDomain);
        asset.setDomainIri(domainIri);
        return asset;
    }


}