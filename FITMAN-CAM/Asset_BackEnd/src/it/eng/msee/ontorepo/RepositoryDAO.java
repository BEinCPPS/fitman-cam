package it.eng.msee.ontorepo;

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
 * which is the defined in the Reference Ontology and cannot be changed. They are assumed
 * to be the last element of the full URI path.
 *  
 * @author Mauro Isaja mauro.isaja@eng.it
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
	 * Creates a new Class with the given name, which inherits from the given parent Class.
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the name of the new item
	 * @param parentName name of an existing Class to inherit from
	 * @throws IllegalArgumentException if name is not unique or not valid, if parentName
	 * is not an existing Class name or is equal to name
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void createClass(String name, String parentName)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Moves the inheritance relationship of an existing Class from one parent Class to another.
	 * @param name the name of an existing Class
	 * @param parentName the name of the new parent Class which should replace the current parent 
	 * @throws IllegalArgumentException if name is not an existing Class name or identifies a
	 * Class which is part of the Base Ontology (read-only), if parentName is not an existing
	 * Class name or is equal to name 
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void moveClass(String name, String parentName)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Deletes an existing Class from the Reference Ontology.
	 * This operation fails if the target item has dependent items. 
	 * @param name the name of an existing Class
	 * @throws IllegalArgumentException if name is not an existing Class name or identifies a
	 * Class which is part of the Base Ontology (read-only)
	 * @throws IllegalStateException if any dependencies exist which prevent deletion
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void deleteClass(String name)
			throws IllegalArgumentException, IllegalStateException, RuntimeException;
	
	/**
	 * Renames an existing Class.
	 * If any references exist to the renamed Class, they are renamed as well.
	 * @param oldName the current name of an existing Class
	 * @param newName the new name of the Class
	 * @throws IllegalArgumentException if oldName is not an existing Class name or identifies a
	 * Class which is part of the Base Ontology (read-only), if newName is not unique or not valid
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void renameClass(String oldName, String newName)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Creates a new, empty (no properties) Individual of Class "Organization", with a given name.
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the name of the new item
	 * @throws IllegalArgumentException if name is not unique or not valid
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void createOrganization(String name)
			throws IllegalArgumentException, RuntimeException;
	
	/**
	 * Creates a new Individual of a given Class, with a given name.
	 * Some default Attributes and References may be set on the new item, according to system
	 * rules which are not documented here. 
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology. It is used to create Asset Models, and will fail if the parent
	 * Class is not a user-defined one - i.e., is part of the Base Ontology.
	 * @param name the name of the new item
	 * @param className the name of the Class of which the new item is an instance
	 * @param ownerName optional: the name of an Individual which represents the owner of the new
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
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the name of the new item
	 * @param modelName the name of the Asset Model from which the new item is cloned
	 * @param ownerName optional: the name of an Individual which represents the owner of the new
	 * item (if provided, must be an existing Organization item in the Reference Ontology) 
	 * @throws IllegalArgumentException if name is not unique or not valid, if modelName does not
	 * identify an existing Asset Model, if ownerName (when provided) does not identify an existing
	 * Organization
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void createAsset(String name, String modelName, String ownerName)
			throws IllegalArgumentException, RuntimeException;
	
	/**
	 * Deletes an existing Individual, of whatever type (Asset Model, Asset, Organization, etc.).
	 * This operation fails if the target item has dependent items.
	 * WARNING! Dependency checks do not cover items existing outside of the Reference Ontology,
	 * like Asset-as-a-Service entries in external databases: these checks MUST be done by the
	 * caller!
	 * @param name the name of an existing Individual
	 * @throws IllegalArgumentException if name does not identify an existing Individual
	 * @throws IllegalStateException if any dependencies exist which prevent deletion
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void deleteIndividual(String name)
			throws IllegalArgumentException, IllegalStateException, RuntimeException;
	
	/**
	 * Sets a Data Property reference with the given name and value on the given Individual. If no
	 * Data Property with this name already exists in the Reference Ontology, it is created; then,
	 * the value is set as an association between the Property and the Individual. If such an
	 * association already exists, the existing value is updated. An Attribute can be cleared
	 * without removing the reference by setting its value to null or to an empty string.
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the name of the Property
	 * @param individualName the name of an existing Individual
	 * @param value the (new) value of the Property (can be null or empty)
	 * @throws IllegalArgumentException if name is not valid, if individualName
	 * does not identify an existing Individual
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void setAttribute(String name, String individualName, String value)
			throws IllegalArgumentException, RuntimeException;

	/**
	 * Sets an Object Property reference with the given name and value on the given Individual. If no
	 * Object Property with this name already exists in the Reference Ontology, it is created; then,
	 * the value is set as an association between the Property and the Individual. If such an
	 * association already exists, the existing value is updated. A Relationship can be cleared
	 * without removing the reference by setting its value to null or to an empty string.
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology.
	 * @param name the name of the Property
	 * @param individualName the name of an existing Individual
	 * @param value the (new) value of the Property (can be null or empty)
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
	 * This operation is safe, as it cannot have any side effects on existing items of the
	 * Reference Ontology. It fails if the Data or Object Property is predefined - i.e., it is part
	 * of the Base Ontology.
	 * @param name the name of the Property
	 * @param individualName the name of an existing Individual
	 * @throws IllegalArgumentException if name does not identify an existing Property or if the
	 * identified Property is defined in the Base Ontology, if individualName does not identify an
	 * existing Individual
	 * @throws RuntimeException if the Reference Ontology cannot be updated for any other reason
	 */
	public void removeProperty(String name, String individualName)
			throws IllegalArgumentException, RuntimeException;
}
