package it.eng.cam.rest.orion;

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
import java.util.List;

/**
 * Created by ascatox on 29/11/16.
 */
public class AssetToContextTrasformer {


    public static List<ContextElement> transformAll(RepositoryDAO dao, List<AssetJSON> assets) throws java.text.ParseException {
        return doTransformAll(dao, assets);
    }

    public static ContextElement transform(RepositoryDAO dao, AssetJSON asset) throws java.text.ParseException {
        return doTransform(dao, asset);
    }

    private static List<ContextElement> doTransformAll(RepositoryDAO dao, List<AssetJSON> assets) throws ParseException {
        List<ContextElement> contextElements = new ArrayList<>();
        if (assets == null) return null;
        assets.parallelStream().forEach(asset -> {
            try {
                contextElements.add(doTransform(dao, asset));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        });
        return contextElements;
    }

    private static ContextElement doTransform(RepositoryDAO dao, AssetJSON asset) throws java.text.ParseException {
        if (asset == null || StringUtils.isBlank(asset.getName())) throw new IllegalArgumentException("No asset in input.");
        ContextElement contextElement = new ContextElement();
        SesameRepoManager.releaseRepoDaoConn(dao);
        dao = SesameRepoManager.getRepoInstance(null);
        IndividualItem individual = dao.getIndividual(asset.getName());
        contextElement.setId(individual.getOriginalName());
        contextElement.setType(individual.getOriginalValue());
        contextElement.setOriginalAssetName(asset.getName());
        contextElement.setOrionConfigId(asset.getOrionConfigId());
        SesameRepoManager.releaseRepoDaoConn(dao);
        dao = SesameRepoManager.getRepoInstance(null);
        List<PropertyValueItem> propertyValueItems = dao.getIndividualAttributes(asset.getName());
        if (null == propertyValueItems || propertyValueItems.isEmpty()) return contextElement;
        for (PropertyValueItem propertyValueItem : propertyValueItems) {
            if (propertyValueItem.getNormalizedName().contains(BeInCpps.ownedBy)
                    || propertyValueItem.getNormalizedName().contains(BeInCpps.createdOn)
                    || propertyValueItem.getNormalizedName().contains(BeInCpps.instanceOf)
                    ) continue;
            Attribute attribute = new Attribute();
            attribute.setName(propertyValueItem.getNormalizedName());
            attribute.setType(propertyValueItem.getPropertyType().getSimpleName().toLowerCase());
            attribute.setValue(propertyValueItem.getPropertyOriginalValue());
            contextElement.getAttributes().add(attribute);
        }
        return contextElement;
    }

}