package it.eng.asset.bean;

import java.util.List;

public class AssetClass {

	private String Name;
	private String Namespace;
	private String NameClassReference;
	private List<AssetClass> children;
	
	
	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String getNamespace() {
		return Namespace;
	}

	public void setNamespace(String namespace) {
		Namespace = namespace;
	}

	public String getNameClassReference() {
		return NameClassReference;
	}

	public void setNameClassReference(String nameClassReference) {
		NameClassReference = nameClassReference;
	}


	public List<AssetClass> getChildren() {
		return children;
	}

	public void setChildren(List<AssetClass> children) {
		this.children = children;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (!(obj instanceof AssetClass))
			return false;
		AssetClass current = (AssetClass) obj;
		if (this.getName().equalsIgnoreCase(current.getName()))
			return true;
		return false;
	}

	public AssetClass getAssetParent(List<AssetClass> referenceList) {
		if (this.NameClassReference != null) {
			for (AssetClass assetClass : referenceList) {
				if (assetClass.getName().equals(this.NameClassReference))
					return assetClass;
			}
		}
		return null;
	}

}
