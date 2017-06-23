package it.eng.cam.rest.orion;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.orion.context.Attribute;
import it.eng.cam.rest.orion.context.ContextElement;
import it.eng.ontorepo.Asset;
import it.eng.ontorepo.PropertyValueItem;
import it.eng.ontorepo.RepositoryDAO;
import it.eng.ontorepo.Util;
import org.eclipse.rdf4j.model.vocabulary.OWL;
import org.eclipse.rdf4j.model.vocabulary.XMLSchema;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by ascatox on 29/11/16.
 */
public class ContextToAssetTransformer {

    public static List<Asset> transformAll(RepositoryDAO dao, List<ContextElement> contextElements) throws Exception {
        return doTransformAll(dao, contextElements);
    }

    public static Asset transform(RepositoryDAO dao, ContextElement contextElement) throws Exception {
        return doTransform(dao, contextElement);
    }

    private static List<Asset> doTransformAll(RepositoryDAO dao, List<ContextElement> contextElements) throws Exception {
        List<Asset> assets = new ArrayList<>();
        if (contextElements == null) return null;
        contextElements.parallelStream().forEach(contextElement -> {
            try {
                assets.add(doTransform(dao, contextElement));
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        });
        return assets;
    }

    private static Asset doTransform(RepositoryDAO dao, ContextElement contextElement) throws Exception {
        if (contextElement == null) throw new IllegalArgumentException("No context in input.");
        Asset asset = new Asset(dao.getImplicitNamespace(), contextElement.getId(), contextElement.getType());
        asset.setCreatedOn(new Date());
        asset.setConnectedToOrion(contextElement.getOrionConfigId());
        asset.setDomain(Constants.IDM_PROJECTS_PREFIX_WITH_SLASH + "xxxxxxxx#" + contextElement.getDomainName());
        asset.setDomainIri(Util
                .getIdmURI(Constants.IDM_PROJECTS_PREFIX_WITH_SLASH + "xxxxxxxx#" + contextElement.getDomainName()));
        ;
        if (null == contextElement.getAttributes() || contextElement.getAttributes().isEmpty())
            return asset;
        for (Attribute attribute : contextElement.getAttributes()) {
            PropertyValueItem propertyValueItem = new PropertyValueItem(dao.getImplicitNamespace(),
                    attribute.getName(), OWL.DATATYPEPROPERTY.stringValue(), findAttributeTypeFullName(attribute.getType()), asset.getNormalizedName(),
                    attribute.getValue());
            asset.getAttributes().add(propertyValueItem);
        }
        return asset;
    }

    private static String findAttributeTypeFullName(String type) {
        if (String.class.getSimpleName().equalsIgnoreCase(type))
            return XMLSchema.STRING.stringValue();
        else if (Integer.class.getSimpleName().equalsIgnoreCase(type))
            return XMLSchema.INTEGER.stringValue();
        else if (Float.class.getSimpleName().equalsIgnoreCase(type))
            return XMLSchema.FLOAT.stringValue();
        else if (Double.class.getSimpleName().equalsIgnoreCase(type))
            return XMLSchema.DOUBLE.stringValue();
        else if (Date.class.getSimpleName().equalsIgnoreCase(type))
            return XMLSchema.DATE.stringValue();
        return null;
    }
}