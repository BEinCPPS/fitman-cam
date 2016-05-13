package it.eng.ontorepo;

import java.io.File;
import java.util.List;

import org.w3c.dom.Document;

/**
 * A simple Data Access Object to interact with the Reference Ontology (RO), whatever
 * the underlying repository might be. Concrete implementations of this interface should
 * deal with a specific repository technology - e.g., local or streamed files, RDBMS, etc.
 * To obtain an object of this type, use the appropriate Factory. 
 * <p />
 * All methods which update the RO are atomic: they either succeed of fail entirely.
 * <p />
 * All item names provided as method arguments are always relative to an implicit base URI,
 * which is the defined in the Reference Ontology and cannot be changed. Names are assumed
 * to be the last element of the full URI path.
 *  
 * @author Mauro Isaja mauro.isaja@eng.it
 * 
 */
public interface RepositoryDAO {

	/**
	 * Reads all RDF statements from the Reference Ontology in the Repository,
	 * and returns them as a DOM. 
	 * @return a Document instance representing a complete, in-memory copy of the Reference Ontology
	 * @throws RuntimeException if the Reference Ontology cannot be read for any reason
	 */
	public Document readOntology() throws RuntimeException;
	
	/**
	 * Returns the implicit namespace used to access the Reference Ontology - i.e., the
	 * implied prefix of all unqualified names. 
	 * <p />
	 * This value is either the default namespace declared in the Reference Ontology, or
	 * a user-provided one which was set explicitly when the RepositoryDAO instance was
	 * initialized.
	 * @return
	 */
	public String getImplicitNamespace();
	
	/**
	 * Reads all Class declarations from the Reference Ontology in the Repository,
	 * and returns them as a ClassItem tree rooted at the owl:Thing node.
	 * <p />
	 * Note that the root node is always returned, even if the Reference Ontology
	 * does not declare any.
	 * @return a ClassItem instance representing owl:Thing
	 * @throws RuntimeException if the Reference Ontology cannot be read for any reason
	 */
	public ClassItem getClassHierarchy() throws RuntimeException;
	
	/**
	 * Reads all Object Property declarations from the Reference Ontology in the Repository,
	 * and returns them as a flat list of items.
	 * <p />
	 * Note that only the rdfs:range statement is supported for Properties, and that if
	 * multiple ranges are specified only the first occurrence is honored.
	 * @return a List of PropertyDeclarationItem objects, which is empty of no items are found
	 * @throws RuntimeException if the Reference Ontology cannot be read for any reason
	 */
	public List<PropertyDeclarationItem> getObjectProperties() throws RuntimeException;
	
	/**
	 * Reads all Data Property declarations from the Reference Ontology in the Repository,
	 * and returns them as a flat list of items.
	 * Note that only the rdfs:range statement is supported for Properties, and that if
	 * multiple ranges are specified only the first occurrence is honored.
	 * @return a List of PropertyDeclarationItem objects, which is empty of no items are found
	 * @throws RuntimeException if the Reference Ontology cannot be read for any reason
	 */
	public List<PropertyDeclarationItem> getDataProperties() throws RuntimeException;
	
	/**
	 * Reads all Individual declarations from the Reference Ontology in the Repository,
	 * and returns them as a flat list of items.
	 * @return a List of IndividualItem objects, which is empty of no items are found
	 * @throws RuntimeException if the Reference Ontology cannot be read for any reason
	 */
	public List<IndividualItem> getIndividuals() throws RuntimeException;
	
	/**
	 * Reads all Individual declarations of a given Class from the Reference Ontology in
	 * the Repository, and returns them as a flat list of items.
	 * <p />
	 * Note that Individuals belonging to Classes which are derived from the given Class
	 * are NOT taken into account.
	 * @param className the local name or full URI of the Class the Individuals belong to
	 * @return a List of IndividualItem objects, which is empty of no items are found
	 * @throws RuntimeException
	 */
	public List<IndividualItem> getIndividuals(String className) throws RuntimeException;
	
	/**
	 * Reads the given Individual declaration from the Reference Ontology in the Repository.
	 * @param name the local name or full URI of the target Individual
	 * @return a single IndividualItem object, or null if the given name does not match an
	 * Individual declaration
	 * @throws RuntimeException if the Reference Ontology cannot be read for any reason
	 */
	public IndividualItem getIndividual(String name) throws RuntimeException;
	
	/**
	 * Reads all the Property Value assertions of a given Individual from the Reference
	 * Ontology in the Repository, and returns them as a flat list of items.
	 * @param name the local name or full URI of the target Individual
	 * @return a List of PropertyValueItem objects, which is empty of no items are found
	 * @throws RuntimeException
	 */
	public List<PropertyValueItem> getIndividualAttributes(String name)
			throws RuntimeException;
	
	/**
	 * Reads all the Owners and returns their (unique) local names.
	 * @return
	 * @throws RuntimeException
	 */
	public List<String> getOwners() throws RuntimeException;
	
	/**
	 * Creates a new Owner with the given name. 
	 * <p />
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the local name of the new Owner
	 * @throws IllegalArgumentException if name is not unique or not valid
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void createOwner(String name)
			throws IllegalArgumentException, RuntimeException;
	
	/**
	 * Deletes an existing Owner from the Reference Ontology.
	 * <p />
	 * This operation fails if the target item has dependent items. 
	 * @param name the local name of the Owner to be deleted
	 * @throws IllegalArgumentException if name is not local, or is not an existing Owner name
	 * @throws IllegalStateException if any dependencies exist which prevent deletion
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void deleteOwner(String name)
			throws IllegalArgumentException, IllegalStateException, RuntimeException;

	/**
	 * Creates a new Class with the given name, which inherits from the given parent Class.
	 * <p />
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the local name of the new item
	 * @param parentName the local name of an existing Class to inherit from
	 * @throws IllegalArgumentException if name is not unique or not valid, if parentName
	 * is not an existing Class name or is equal to name
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void createClass(String name, String parentName)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Moves the inheritance relationship of an existing Class from one parent Class to another.
	 * @param name the local name of an existing Class
	 * @param parentName the local name of the new parent Class which should replace the current 
	 * @throws IllegalArgumentException if name is not an existing Class name or identifies a
	 * Class which is part of the Base Ontology (read-only), if parentName is not an existing
	 * Class name or is equal to name 
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void moveClass(String name, String parentName)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Deletes the given existing Class from the Reference Ontology.
	 * <p />
	 * This operation fails if the target item has dependent items. 
	 * @param name the local name of an existing Class
	 * @throws IllegalArgumentException if name is not an existing Class name or identifies a
	 * Class which is part of the Base Ontology (read-only)
	 * @throws IllegalStateException if any dependencies exist which prevent deletion
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void deleteClass(String name)
			throws IllegalArgumentException, IllegalStateException, RuntimeException;
	
	/**
	 * Renames the given existing Class. If any references exist to the renamed Class, they are updated.
	 * @param oldName the current local name of an existing Class
	 * @param newName the new unique local name of the Class
	 * @throws IllegalArgumentException if oldName is not an existing Class name or identifies a
	 * Class which is part of the Base Ontology (read-only), if newName is not unique or not valid
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void renameClass(String oldName, String newName)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Creates a new Individual of a given Class, with a given name.
	 * Some default Attributes and References may be set on the new item, according to system
	 * rules which are not documented here. 
	 * <p />
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology. It is used to create Asset Models, and will fail if the parent
	 * Class is not a user-defined one - i.e., is part of the Base Ontology.
	 * @param name the local name of the new item
	 * @param className the local name of the Class of which the new item is an instance
	 * @param ownerName optional: the local name of an Individual which represents the owner of the new
	 * item (if provided, must be an existing Organization item in the Reference Ontology) 
	 * @throws IllegalArgumentException if name is not unique or not valid, if className
	 * is not an existing Class name or identifies a Class which is part of the Base Ontology
	 * (e.g., "Organization"), if ownerName (when provided) does not identify an existing Organization
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void createAssetModel(String name, String className, String ownerName)
			throws IllegalArgumentException, RuntimeException;
	
	/**
	 * Creates a new Asset as an Individual, with the given name, cloning a given Asset Model.
	 * Some default Attributes and References may be set on the new item, according to system
	 * rules which are not documented here. 
	 * <p />
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the local name of the new item
	 * @param modelName the local name of the Asset Model from which the new item is cloned
	 * @param ownerName optional: the local name of an Individual which represents the owner of the new
	 * item (if provided, must be an existing Organization item in the Reference Ontology) 
	 * @throws IllegalArgumentException if name is not unique or not valid, if modelName does not
	 * identify an existing Asset Model, if ownerName (when provided) does not identify an existing
	 * Organization
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void createAsset(String name, String modelName, String ownerName)
			throws IllegalArgumentException, RuntimeException;
	
	/**
	 * Deletes the given existing Individual, of whatever type (Asset Model or Asset).
	 * This operation fails if the target item has dependent items.
	 * <p />
	 * WARNING! Dependency checks do not cover items existing outside of the Reference Ontology,
	 * like Asset-as-a-Service entries in external databases: these checks MUST be done by the
	 * caller!
	 * @param name the local name of an existing Individual
	 * @throws IllegalArgumentException if name does not identify an existing Individual
	 * @throws IllegalStateException if any dependencies exist which prevent deletion
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void deleteIndividual(String name)
			throws IllegalArgumentException, IllegalStateException, RuntimeException;

	/**
	 * Calling this method has the same effects as calling
	 * {@link #setAttribute(String, String, String, Class)} with a <code>null</code>
	 * <i>type</i> argument.  
	 * @param name the local name or full URI of the Data Property
	 * @param individualName the local name of an existing Individual
	 * @param value the (new) value of the Data Property (can be null or empty)
	 * @throws IllegalArgumentException if name is not valid, if individualName
	 * does not identify an existing Individual
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void setAttribute(String name, String individualName, String value)
			throws IllegalArgumentException, RuntimeException;
	
	/**
	 * Sets a Data Property reference with the given name and value on the given Individual. If no
	 * Data Property with this name already exists in the Reference Ontology, it is created and its range
	 * is set according to the given type; otherwise, the given type is ignored and the given value must
	 * match the declared or implicit range of the existing Data Property. In both cases, the given
	 * value is set as an association between the Data Property and the Individual. If such an
	 * association already exists, the existing value is updated.
	 * <p />
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the local name or full URI of the Data Property
	 * @param individualName the local name of an existing Individual
	 * @param value the (new) value of the Data Property (can be null or empty)
	 * @param type the type of the  (if null, defaults to <code>java.lang.String</code>)
	 * @throws IllegalArgumentException if name is not valid, if individualName
	 * does not identify an existing Individual
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void setAttribute(String name, String individualName, String value, Class<?> type)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Sets an Object Property reference with the given name and value on the given Individual. If no
	 * Object Property with this name already exists in the Reference Ontology, it is created; then,
	 * the value is set as an association between the Object Property and the Individual. If such an
	 * association already exists, the existing value is updated.
	 * <p />
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the local name or full URI of the Object Property
	 * @param individualName the local name of an existing Individual
	 * @param value the (new) value of the Object Property (can be null or empty)
	 * @throws IllegalArgumentException if name is not valid, if individualName
	 * does not identify an existing Individual, if value (when provided) does not identify an
	 * existing Individual
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void setRelationship(String name, String individualName, String referredName)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Removes the Data or Object Property reference with the given name from the given Individual.
	 * If, after removing the reference, no other references to this Property exist in the
	 * Reference Ontology, the Property declaration itself is deleted.
	 * <p />
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology. It fails if the Data or Object Property is predefined - i.e., it is part
	 * of the Base Ontology.
	 * @param name the local name of the Property
	 * @param individualName the local name of an existing Individual
	 * @throws IllegalArgumentException if name does not identify an existing Property or if the
	 * identified Property is defined in the Base Ontology, if individualName does not identify an
	 * existing Individual
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void removeProperty(String name, String individualName)
			throws IllegalArgumentException, RuntimeException;
	
	/**
	 * Add a file in format RDF to the repository.
	 * @param rdfFile The file xml RDF containing Ontology
	 * @param (optional) The Base URI where to contain the definitions in file (ex. http://example.org/example/local)
	 * @param forceAdd Add file RDF content also if the repo in not empty
	 * @author ascatox at 2016-04-26
	 */
	public void addRdfFileToRepo(File rdfFile, String baseUri, boolean forceAdd)
			throws RuntimeException;
}
