package it.eng.ontorepo;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.sesame.SesameRepoManager;
import org.apache.commons.lang3.time.DateUtils;

import java.text.ParseException;
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

    public static Asset transform(RepositoryDAO dao, IndividualItem individual, boolean lostDomain) throws java.text.ParseException {
        return doTransform(dao, individual, lostDomain);
    }

    public static Asset transform(RepositoryDAO dao, IndividualItem individual) throws java.text.ParseException {
        return doTransform(dao, individual, false);
    }

    private static List<Asset> doTransformAll(RepositoryDAO dao, List<IndividualItem> individuals, boolean lostDomain) throws java.text.ParseException {
        List<Asset> individualItemWrappers = new ArrayList<>();
        if (individuals == null) return null;
        individuals.parallelStream().forEach(individualItem -> {
            try {
                individualItemWrappers.add(doTransform(dao, individualItem, lostDomain));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        });
        return individualItemWrappers;
    }


    private static Asset doTransform(RepositoryDAO dao, IndividualItem individual, boolean lostDomain) throws java.text.ParseException {
        SesameRepoManager.releaseRepoDaoConn(dao);
        dao = SesameRepoManager.getRepoInstance(null);
        String domain = "";
        String domainIri = "";
        Date date = null;
        List<PropertyValueItem> individualAttributes = dao.getIndividualAttributes(individual.getIndividualName());
        for (PropertyValueItem attribute :
                individualAttributes) {
            if (attribute.getNormalizedName().contains(BeInCpps.ownedBy)) {
                String[] split = attribute.getPropertyValue().split("#");
                domain = split[1];
                domainIri = attribute.getPropertyValue();
            } else if (attribute.getNormalizedName().contains(BeInCpps.createdOn)) {
                date = DateUtils.parseDate(attribute.getPropertyValue(), Constants.DATE_PATTERN_DATE_TIME_TIMEZONE);
                //date = DateFormatUtils.format(data, "dd/MM/yyyy");
            }
        }
        Asset asset = new Asset(individual, domain, date, lostDomain);
        asset.setDomainIri(domainIri);
        return asset;
    }


}
