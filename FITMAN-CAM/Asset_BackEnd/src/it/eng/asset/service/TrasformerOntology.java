package it.eng.asset.service;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetClass;
import it.eng.asset.bean.GenericService;
import it.eng.asset.bean.LocalService;
import it.eng.asset.bean.Property;
import it.eng.asset.bean.PublicService;
import it.eng.msee.ontorepo.ClassItem;
import it.eng.msee.ontorepo.IndividualItem;
import it.eng.msee.ontorepo.PropertyDeclarationItem;
import it.eng.msee.ontorepo.PropertyValueItem;

import java.util.Date;

public class TrasformerOntology {
	
	
	
	public static AssetClass trasformClass(ClassItem cls, ClassItem reference)  {

		AssetClass ac = new AssetClass();
		String nameClass = cls.getClassName();
		if (nameClass.equals("http://www.w3.org/2002/07/owl#Thing")) {
			nameClass = "root";
		}
		ac.setName(nameClass);
		
		ac.setNamespace(cls.getNamespace());
		
		if (reference != null)
		{
			AssetClass assetClassReference = new AssetClass();
			String nameClassReference = reference.getClassName();
			if (nameClassReference.equals("http://www.w3.org/2002/07/owl#Thing")) {
				nameClassReference = "root";
			}

			assetClassReference.setName(nameClassReference);
			assetClassReference.setNamespace(reference.getNamespace());
			ac.setNameClassReference(nameClassReference);
		}
		return ac;
	}

	public static Asset trasformAsset(IndividualItem individualItem, String owner, Date created, String model) {
		
		Asset as = new Asset();
		as.setName(individualItem.getNormalizedName());
		as.setCreated(created);
		as.setNamespace(individualItem.getNamespace());
		as.setModel(model);
		as.setOwner(owner);
		as.setAssetClass(individualItem.getClassName());
		as.setGlobalName(individualItem.getOriginalName());
		return as;
	}

	
	public static Property trasformProperty(PropertyValueItem property_value_item) {
		
		Property property = new Property();
		property.setName(property_value_item.getNormalizedName());
		property.setNamespace(property_value_item.getNamespace());
		property.setType(property_value_item.getPropertyType().getName());
		property.setType_value(property_value_item.getPropertyRange());
		if (property_value_item.getPropertyValue().length() > 120) {
			property.setValue(property_value_item.getPropertyValue().substring(0, 120) + "...");
		}
		else {
			property.setValue(property_value_item.getPropertyValue());
		}
		return property;
	}
	
	
	private static String decode(String typeProperty) {
		String in = typeProperty.replace("java.lang.","");
		String out = "";
		if (in.equals("Object")) {
				out = in;
		} else {
			out = "Data";
		}
		return out;
	}


	
	public static Property trasformPropertyRest(PropertyValueItem property_value_item) {
		
		Property property = new Property();
		property.setName(property_value_item.getNormalizedName());
		property.setNamespace(property_value_item.getNamespace());
		property.setType(decode(property_value_item.getPropertyType().getName()));
		property.setType_value(property_value_item.getPropertyRange());
			property.setValue(property_value_item.getPropertyValue());
			property.setValue(property_value_item.getPropertyValue());
		return property;
	}
	
	public static Property trasformPropertyDeclaration(PropertyDeclarationItem property_declaration_item) {
		
		Property property = new Property();
		property.setName(property_declaration_item.getNormalizedName());
		property.setNamespace(property_declaration_item.getNamespace());
		property.setType(property_declaration_item.getPropertyType().getName());
		property.setType_value(property_declaration_item.getPropertyRange());
		return property;
	}
	
	public static GenericService trasform(PublicService ps) {
		
		GenericService gs = new GenericService();
		gs.setCreated(ps.getCreated());
		gs.setName(ps.getName());
		gs.setIdService(ps.getIdService());
		gs.setOwner(ps.getOwner());
		gs.setPublished(ps.getPublished());
		gs.setPublishedDate(ps.getPublishedDate());
		gs.setServiceDescription(ps.getServiceDescription());
		gs.setType("Public");
		gs.setUserId(ps.getUserId());
		return gs;
	}
	
	public static GenericService trasform(LocalService ls) {
		GenericService gs = new GenericService();
		gs.setCreated(ls.getCreated());
		gs.setName(ls.getName());
		gs.setIdService(ls.getIdLocalService());
		gs.setOwner(ls.getOwner());
		gs.setPublished(ls.getPublished());
		gs.setPublishedDate(ls.getPublishedDate());
		gs.setServiceDescription(ls.getServiceDescription());
		gs.setType("Local");
		gs.setUserId(ls.getUserId());
		return gs;
		
	}

	
}
