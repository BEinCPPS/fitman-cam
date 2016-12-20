package it.eng.cam.rest.orion;

import it.eng.cam.rest.orion.context.Attribute;
import it.eng.cam.rest.orion.context.ContextElement;
import it.eng.ontorepo.Asset;
import it.eng.ontorepo.PropertyValueItem;
import it.eng.ontorepo.RepositoryDAO;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ascatox on 29/11/16.
 */
public class ContextToAssetTransformer {

    public static List<ContextElement> transformAll(RepositoryDAO dao, List<ContextElement> contextElements) throws java.text.ParseException {
        return doTransformAll(dao, contextElements);
    }

    public static Asset transform(RepositoryDAO dao, ContextElement contextElement) throws java.text.ParseException {
        return doTransform(dao, contextElement);
    }

    private static List<ContextElement> doTransformAll(RepositoryDAO dao, List<ContextElement> contextElements) throws java.text.ParseException {
        List<Asset> assets = new ArrayList<>();
        if (contextElements == null) return null;
        contextElements.parallelStream().forEach(contextElement -> {
            try {
                assets.add(doTransform(dao, contextElement));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        });
        return contextElements;
    }

    private static Asset doTransform(RepositoryDAO dao, ContextElement contextElement) throws java.text.ParseException {
        if (contextElement == null) throw new IllegalArgumentException("No context in input.");
        Asset asset = new Asset(dao.getImplicitNamespace(), contextElement.getId(), contextElement.getType());
        asset.setCreatedOn(new Date());
        if (null == contextElement.getAttributes() || contextElement.getAttributes().isEmpty())
            return asset;
        for (Attribute attribute : contextElement.getAttributes()) {
            PropertyValueItem propertyValueItem = new PropertyValueItem(dao.getImplicitNamespace(),
                    attribute.getName(), attribute.getType(), null, asset.getNormalizedName(),
                    attribute.getValue());
            asset.getAttributes().add(propertyValueItem);
        }
        return asset;
    }
}