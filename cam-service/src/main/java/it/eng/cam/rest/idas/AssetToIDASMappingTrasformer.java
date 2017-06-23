package it.eng.cam.rest.idas;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.sesame.SesameRepoManager;
import it.eng.cam.rest.sesame.dto.AssetJSON;
import it.eng.ontorepo.BeInCpps;
import it.eng.ontorepo.IndividualItem;
import it.eng.ontorepo.PropertyValueItem;
import it.eng.ontorepo.RepositoryDAO;
import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by ascatox on 29/11/16.
 */
public class AssetToIDASMappingTrasformer {




    public static List<IDASMappingContext> transformAll(RepositoryDAO dao, List<AssetJSON> assets, boolean useNameSpace) throws ParseException {
        return doTransformAll(dao, assets, useNameSpace);
    }

    public static IDASMappingContext transform(RepositoryDAO dao, AssetJSON asset, boolean useNameSpace) throws ParseException {
        return doTransform(dao, asset, useNameSpace);
    }

    private static List<IDASMappingContext> doTransformAll(RepositoryDAO dao, List<AssetJSON> assets, boolean useNameSpace) throws ParseException {
        List<IDASMappingContext> contextElements = new ArrayList<>();
        if (assets == null) return null;
        assets.stream().forEach(asset -> {
            try {
                contextElements.add(doTransform(dao, asset, useNameSpace));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        });
        return contextElements;
    }

    private static IDASMappingContext doTransform(RepositoryDAO dao, AssetJSON asset, boolean useNameSpace) throws ParseException {
        if (asset == null || StringUtils.isBlank(asset.getName()))
            throw new IllegalArgumentException("No asset in input.");
        IDASMappingContext contextElement = new IDASMappingContext();
        dao = SesameRepoManager.restartRepoDaoConn(dao);
        IndividualItem individual = dao.getIndividual(asset.getName());
        if (!useNameSpace)
            contextElement.setId(individual.getNormalizedName());
        else
            contextElement.setId(individual.getIndividualName());
        if (!useNameSpace)
            contextElement.setType(individual.getNormalizedValue());
        else
            contextElement.setType(individual.getClassName());
        dao = SesameRepoManager.restartRepoDaoConn(dao);
        List<PropertyValueItem> propertyValueItems = dao.getIndividualAttributes(asset.getName());
        if (null == propertyValueItems || propertyValueItems.isEmpty()) return contextElement;
        for (PropertyValueItem propertyValueItem : propertyValueItems) {
            if (propertyValueItem.getNormalizedName().contains(BeInCpps.ownedBy)
                    || propertyValueItem.getNormalizedName().contains(BeInCpps.createdOn)
                    || propertyValueItem.getNormalizedName().contains(BeInCpps.instanceOf)
                    || propertyValueItem.getNormalizedName().contains(BeInCpps.syncTo)
                    || propertyValueItem.getPropertyType().getSimpleName().equalsIgnoreCase("Object") //Relationships
                    || !propertyValueItem.getNormalizedName().toLowerCase().startsWith(Constants.NGSI) //each attribute starts with ngsi
                    ) continue;
            IDASMappingAttribute attribute = new IDASMappingAttribute();
            String[] split = propertyValueItem.getNormalizedName().split(Constants.NGSI);
            attribute.setOcb_id(split[1]);
            attribute.setType(propertyValueItem.getPropertyType().getSimpleName().toLowerCase());
            if (propertyValueItem.getPropertyType().getSimpleName().equalsIgnoreCase(Calendar.class.getSimpleName()))
                attribute.setType(Date.class.getSimpleName().toLowerCase());
            //attribute.setOpcua_id(propertyValueItem.getPropertyOriginalValue());
            contextElement.getMappings().add(attribute);
        }
        return contextElement;
    }
}