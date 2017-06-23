package it.eng.cam.rest.orion;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.orion.context.Attribute;
import it.eng.cam.rest.orion.context.ContextElement;
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
public class AssetToContextTrasformer {


    public static List<ContextElement> transformAll(RepositoryDAO dao, List<AssetJSON> assets, boolean useNameSpace) throws java.text.ParseException {
        return doTransformAll(dao, assets, useNameSpace);
    }

    public static ContextElement transform(RepositoryDAO dao, AssetJSON asset, boolean useNameSpace) throws java.text.ParseException {
        return doTransform(dao, asset, useNameSpace);
    }

    private static List<ContextElement> doTransformAll(RepositoryDAO dao, List<AssetJSON> assets, boolean useNameSpace) throws ParseException {
        List<ContextElement> contextElements = new ArrayList<>();
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

    private static ContextElement doTransform(RepositoryDAO dao, AssetJSON asset, boolean useNameSpace) throws java.text.ParseException {
        if (asset == null || StringUtils.isBlank(asset.getName()))
            throw new IllegalArgumentException("No asset in input.");
        ContextElement contextElement = new ContextElement();
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
        contextElement.setOriginalAssetName(asset.getName());
        contextElement.setOrionConfigId(asset.getOrionConfigId());
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
            Attribute attribute = new Attribute();
            String[] split = propertyValueItem.getNormalizedName().split(Constants.NGSI);
            attribute.setName(split[1]);
            attribute.setType(propertyValueItem.getPropertyType().getSimpleName().toLowerCase());
            if (propertyValueItem.getPropertyType().getSimpleName().equalsIgnoreCase(Calendar.class.getSimpleName()))
                attribute.setType(Date.class.getSimpleName().toLowerCase());
            attribute.setValue(propertyValueItem.getPropertyOriginalValue());
            contextElement.getAttributes().add(attribute);
        }
        return contextElement;
    }

}