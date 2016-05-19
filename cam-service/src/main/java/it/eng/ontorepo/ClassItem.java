package it.eng.ontorepo;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * DTO representing a Class declaration.
 * Only Class Name and SuperClass Name (single inheritance) are supported.
 * 
 * @author Mauro Isaja mauro.isaja@eng.it
 *
 */
public class ClassItem extends Tuple {

	private ClassItem parent;
	private final List<ClassItem> children;

	/**
	 * Initialize a new instance with its own Class and SuperClass Names.
	 * <p />
	 * The implicit Class hierarchy root should be represented as
	 * <code>name=owl:Thing; parentName=null</code>, while all <i>top-level</i>
	 * Classes should have <code>parentName=owl:Thing</code>.
	 * @param namespace the implicit namespace of the Reference Ontology (mandatory)
	 * @param name full URI which identifies the Class (mandatory)
	 * @param parentName full URI which identifies the SuperClass (optional)
	 */
	public ClassItem(String namespace, String name, String parentName) {
		super(namespace, name, parentName);
		children = new ArrayList<ClassItem>();
	}
	
	/**
	 * Returns the <i>local</i> Name of the Class: the implicit namespace,
	 * if is part of the full URI, is stripped from the result. URIs which do not
	 * contain a reference to the implicit namespace are left unchanged.
	 * <p />
	 * To obtain the original full URI, use {@link Tuple#getOriginalName()}.
	 * @return
	 */
	public String getClassName() {
		return getNormalizedName();
	}
	
	/**
	 * Returns the <i>local</i> Name of the SuperClass: the implicit namespace,
	 * if is part of the full URI, is stripped from the result. URIs which do not
	 * contain a reference to the implicit namespace are left unchanged. The value
	 * returned by this method is <code>null</code> when the instance represents
	 * the predefined <code>owl:Thing</code> Class. For all <i>top-level</i> 
	 * Classes in the Reference Ontology, this method returns <code>owl:Thing</code>.  
	 * <p />
	 * To obtain the original full URI, use {@link Tuple#getOriginalValue()}.
	 * @return
	 */
	public String getSuperClassName() {
		return getNormalizedValue();
	}
	
	/**
	 * Sets a <code>ClassItem</code> instance as the parent of this node.
	 * This operation fails if the given instance Class Name is different
	 * with respect to the SuperClass Name of this instance.
	 * This method is only used to construct Class hierarchy trees.
	 * @param parent
	 */
	public void setSuperClass(ClassItem parent) {
		if (parent.getOriginalName().equals(this.getOriginalValue())) {
			this.parent = parent;
		} else {
			throw new IllegalArgumentException("Bad parent node " + parent.toString() +
					" for node " + this.toString());
		}
	}

	/**
	 * Returns the <code>ClassItem</code> instance representing the SuperClass
	 * of this Class. This value returns <code>null</code> until
	 * {@link #setSuperClass(ClassItem)} is used to set the parent node.
	 * @return
	 */
	@JsonIgnore
	public ClassItem getSuperClass() {
		return parent;
	}

	/**
	 * Returns the list of <code>ClassItem</code> instance representing
	 * SubClasses of this Class. This list is empty until it is actually
	 * populated, as this step is not performed during initialization.
	 * The list is also empty if no SubClasses of this Class exist in the
	 * Reference Ontology. 
	 * @return
	 */
	@JsonIgnore 
	public List<ClassItem> getSubClasses() {
		return children;
	}
	
	@Override
	public String toString() {
		StringBuilder buf = new StringBuilder();
		buf.append("ASSET_CLASS[Name=").append(getClassName());
		buf.append("; SuperClass=").append(getSuperClassName()).append("]");
		return buf.toString();
	}
}
