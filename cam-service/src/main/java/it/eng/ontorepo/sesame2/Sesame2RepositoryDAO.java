package it.eng.ontorepo.sesame2;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.sesame.SesameRepoManager;
import it.eng.ontorepo.*;
import org.apache.commons.lang3.StringUtils;
import org.eclipse.jetty.io.RuntimeIOException;
import org.eclipse.rdf4j.IsolationLevels;
import org.eclipse.rdf4j.model.*;
import org.eclipse.rdf4j.model.vocabulary.OWL;
import org.eclipse.rdf4j.model.vocabulary.RDF;
import org.eclipse.rdf4j.model.vocabulary.RDFS;
import org.eclipse.rdf4j.model.vocabulary.XMLSchema;
import org.eclipse.rdf4j.query.*;
import org.eclipse.rdf4j.repository.RepositoryConnection;
import org.eclipse.rdf4j.repository.RepositoryException;
import org.eclipse.rdf4j.repository.RepositoryResult;
import org.eclipse.rdf4j.repository.base.AbstractRepository;
import org.eclipse.rdf4j.repository.http.HTTPRepository;
import org.eclipse.rdf4j.repository.sail.SailRepository;
import org.eclipse.rdf4j.rio.RDFFormat;
import org.eclipse.rdf4j.rio.RDFHandlerException;
import org.eclipse.rdf4j.rio.RDFParseException;
import org.eclipse.rdf4j.rio.rdfxml.RDFXMLWriter;
import org.eclipse.rdf4j.sail.memory.MemoryStore;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.util.*;

/**
 * Implementation of {@link RepositoryDAO} for accessing the Reference Ontology
 * in a given Sesame2 Repository.
 * <p/>
 * Currently, only the HTTP-REST protocol for connecting to the Repository is
 * supported, so you can only integrate with a Sesame2 <i>server</i> instance.
 * In the future, more connectors might become available (Sail, etc.).
 * <p/>
 * This implementation is <i>apparently</i> stateless, in the sense that no open
 * connections are kept between method calls. However, a connection pool is
 * maintained internally, so it is of capital importance that instances of this
 * class are properly <i>destroyed</i> after use, in order to release resources.
 * This means calling the {@link #release()} method on each instance before
 * discarding it. In particular, never let an instance go out of scope in your
 * code without releasing - e.g., storing it in a web session and let the
 * session timeout. Also, you should not have unused instances hanging around in
 * you application, as this may lead to resource starving and may even lock the
 * Sesame2 server.
 * <p/>
 * <i> As an author's side note: it should be checked if transactions are
 * actually supported by the HTTP-REST protocol of Sesame2! The calls are all
 * there, but frankly I doubt they are doing anything useful... </i>
 *
 * @author Mauro Isaja mauro.isaja@eng.it
 */
public class Sesame2RepositoryDAO implements RepositoryDAO {

    private static final String VARTAG = "???"; // tag to be replaced in queries
    private static final String VARTAG2 = "###"; // tag to be replaced in
    private static final String NAMESPACE = BeInCpps.NS;
    private static final String FILTER_BY_NS_CONTENT = " STRSTARTS(STR(?name), \"" + NAMESPACE + "\") ";
    private static final String FILTER_BY_NS = " FILTER(" + FILTER_BY_NS_CONTENT + "). ";
    // queries

    private static final String QUERY_CLASSES = "SELECT DISTINCT ?name ?superclass " + "WHERE { ?name rdf:type <"
            + OWL.CLASS + ">; " + "rdfs:subClassOf ?superclass." +
            FILTER_BY_NS +
            " }";


    private static final String QUERY_CLASS = "SELECT ?name " + "WHERE { ?name rdf:type <" + OWL.CLASS + ">. "
            + "FILTER(?name = <" + VARTAG + ">"
            + " && " + FILTER_BY_NS_CONTENT
            + ") }";

    private static final String QUERY_OBJECT_PROPS = "SELECT DISTINCT ?name ?range " + "WHERE { ?name rdf:type <"
            + OWL.OBJECTPROPERTY + "> " + "OPTIONAL { ?name rdfs:range ?range } " +
            FILTER_BY_NS
            + "} " + "ORDER BY ?name";

    private static final String QUERY_OBJECT_PROP = "SELECT DISTINCT ?name ?range " + "WHERE { ?name rdf:type <"
            + OWL.OBJECTPROPERTY + "> " + "OPTIONAL { ?name rdfs:range ?range } " + "FILTER(?name = <" + VARTAG
            + ">" +
            " && " + FILTER_BY_NS_CONTENT +
            ") }"; // replace VARTAG by qualified property name

    private static final String QUERY_DATA_PROPS = "SELECT DISTINCT ?name ?range " + "WHERE { ?name rdf:type <"
            + OWL.DATATYPEPROPERTY + "> " + "OPTIONAL { ?name rdfs:range ?range } " +
            FILTER_BY_NS +
            "} " + "ORDER BY ?name";

    private static final String QUERY_DATA_PROP = "SELECT DISTINCT ?name ?range " + "WHERE { ?name rdf:type <"
            + OWL.DATATYPEPROPERTY + "> " + "OPTIONAL { ?name rdfs:range ?range } " + "FILTER(?name = <" + VARTAG
            + ">" +
            " && " + FILTER_BY_NS_CONTENT
            + ") }"; // replace VARTAG by qualified property name

    private static final String QUERY_INDIVIDUALS = "SELECT DISTINCT ?name ?class " + "WHERE { ?name rdf:type ?class; "
            + "              rdf:type owl:NamedIndividual. " + "FILTER(!(?class = owl:NamedIndividual)" +
            " && " + FILTER_BY_NS_CONTENT +
            ")} "
            + "ORDER BY ?name";

    private static final String QUERY_SINGLE_INDIVIDUAL = "SELECT DISTINCT ?class " + "WHERE { <" + VARTAG
            + "> rdf:type ?class; " + // replace VARTAG by qualified individual
            // name
            " rdf:type owl:NamedIndividual. " + "FILTER(!(?class = owl:NamedIndividual)" +
            ")} ";

    private static final String QUERY_INDIVIDUALS_FOR_CLASS = "SELECT DISTINCT ?name " + "WHERE { ?name rdf:type <"
            + VARTAG + "> " +
            FILTER_BY_NS +
            "} " + // replace VARTAG by qualified class name
            "ORDER BY ?name";

    private static final String QUERY_PROPS_FOR_INDIVIDUAL = "SELECT DISTINCT ?name ?value ?type ?range " + "WHERE { <"
            + VARTAG + "> ?name ?value. " + // replace VARTAG by qualified
            // individual name
            "?name rdf:type ?type. " + "OPTIONAL { ?name rdfs:range ?range } " + "FILTER(!(?name = rdf:type)) "
            + "FILTER(!(?type= owl:FunctionalProperty)" +
            //" && " + FILTER_BY_NS_CONTENT +
            ")}" + "ORDER BY ?name";

    private static final String QUERY_PROP_FOR_INDIVIDUAL = "SELECT ?value " + "WHERE { <" + VARTAG + "> <" + VARTAG2
            + "> ?value. " +
            "} "; // replace VARTAG & VARTAG2 by qualified
    // individual name and property name

    private static final String QUERY_PROP_ASSIGNMENTS = "SELECT ?name ?value " + "WHERE { ?name <" + VARTAG
            + "> ?value. " +
            FILTER_BY_NS +
            "} "; // replace VARTAG by qualified property name

    private static final String QUERY_DEPENDENCIES = "SELECT ?name " + "WHERE { ?name ?x <" + VARTAG + "> " +
            FILTER_BY_NS +
            "} "; // replace
    // VARTAG
    // by
    // qualified
    // name

    /**
     * author @ascatox Modified at 20/09/2016
     */
    private static final String QUERY_ALL_DATA_PROPS = "SELECT DISTINCT ?name ?type ?range  " + "WHERE { "
            + "OPTIONAL { ?name rdfs:range ?range } "
            + FILTER_BY_NS
            + "} ";
    /**
     * @author ascatox Modified at 03/11/2016
     */
    private static final String QUERY_INDIVIDUALS_NO_DOMAIN = "SELECT DISTINCT ?name ?class "
            + "WHERE { "
            + "?name rdf:type ?class; rdf:type owl:NamedIndividual. "
            + "FILTER(!(?class = owl:NamedIndividual)" +
            " && NOT EXISTS {?name <" + VARTAG + "> ?domain }" +
            " &&  regex(str(?name), \"^" + VARTAG2 + "\")" +
            " && " + FILTER_BY_NS_CONTENT +
            "). "
            + "} ORDER by ?name";

    private static final String QUERY_INDIVIDUALS_FOR_DOMAIN = "SELECT DISTINCT ?name ?class "
            + "WHERE { "
            + "?name rdf:type ?class; rdf:type owl:NamedIndividual. "
            + "?name <" + VARTAG + "> ?domain ."
            + "FILTER(!(?class = owl:NamedIndividual)"
            + " &&  regex(str(?domain), \"^" + VARTAG2 + "\")"
            + " && " + FILTER_BY_NS_CONTENT
            + "). "
            + "} ORDER by ?name";

    private static final String QUERY_ALL_DOMAINS_IDM_URI = "SELECT DISTINCT ?domain "
            + "WHERE { "
            + "?name <" + VARTAG + "> ?domain "
            + "FILTER (regex( str(?domain ), \"^" + VARTAG2 + "\")" +
            ")}";

    private static final String QUERY_SUB_CLASSES_OF = "SELECT DISTINCT ?name ?superclass " +
            "WHERE { ?name rdf:type <"
            + OWL.CLASS + ">; " + "rdfs:subClassOf* ?superclass. " +
            "FILTER(?superclass = <" + VARTAG + ">" +
            " && " + FILTER_BY_NS_CONTENT +
            "). " +
            "}";

    private static final String QUERY_INDIVIDUALS_BY_SUB_CLASSES = "SELECT DISTINCT ?name ?class WHERE "
            + "{ "
            + "?nameclass rdf:type <http://www.w3.org/2002/07/owl#Class>; rdfs:subClassOf* ?superclass. "
            + "FILTER(?superclass = <" + VARTAG + ">). "
            + "?name rdf:type ?class; rdf:type owl:NamedIndividual. "
            + " FILTER((?class = ?nameclass)" +
            " && " + FILTER_BY_NS_CONTENT +
            "). "
            + "} ORDER by ?name";

    private static final String QUERY_INDIVIDUALS_BY_ORION_CONFIG = "SELECT DISTINCT ?name ?class ?orionConfig WHERE "
            + "{ "
            + " ?name rdf:type ?class; rdf:type owl:NamedIndividual."
            + " ?name <" + VARTAG + "> ?orionConfig."
            + " FILTER(!(?class = owl:NamedIndividual) "
            + "  &&  regex(str(?orionConfig), \"" + VARTAG2 + "\")"
            + ").}";

    // Modified by @ascatox 2016-04-26 to use MemoryStore in Unit Test
    private AbstractRepository repo;
    private final ValueFactory vf;
    private final URI ni;
    private final String ns;
    private boolean inTransaction;
    private RepositoryConnection connection;

    public RepositoryConnection getConnection() {
        if (!isInTransaction())
            return repo.getConnection();
        return connection;
    }

    public void setConnection(RepositoryConnection connection) {
        this.connection = connection;
    }

    public boolean isInTransaction() {
        return inTransaction;
    }

    public void setInTransaction(boolean inTransaction) {
        this.inTransaction = inTransaction;
    }

    public void setInTransaction(boolean inTransaction, RepositoryConnection connection) {
       setInTransaction(inTransaction);
        setConnection(connection);
    }

    public AbstractRepository getRepo() {
        return repo;
    }

    /**
     * Constructs a RepositoryDAO for accessing a Reference Ontology in a given
     * Sesame2 Repository. The Repository is identified by a server URL and a
     * name, both mandatory. The given Repository must exist and be accessible.
     * The implicit namespace is set to the default namespace of the Reference
     * Ontology in the Repository; if no default namespace is declared in the
     * Reference Ontology, the initialization fails.
     * <p/>
     * <b>WARNING!</b> At the time of writing, using the default namespace fails
     * even if it is actually declared in the ontology data - might be a problem
     * with the Sesame API, but anyhow you should declare your implicit
     * namespace in the 3-argument constructor: don't use the 2-argument one!
     *
     * @param server     the URL of the server
     * @param repository the name of the Repository
     * @throws RuntimeException      if the Repository cannot be accessed, or the Reference
     *                               Ontology cannot be read for any reason
     * @throws IllegalStateException if the Reference Ontology declares no default namespace
     */
    public Sesame2RepositoryDAO(String server, String repository) throws RuntimeException, IllegalStateException {
        this(server, repository, null);
    }

    /**
     * Constructs a RepositoryDAO for accessing a Reference Ontology in a given
     * Sesame2 Repository. The Repository is identified by a server URL and a
     * name, both mandatory. The given Repository must exist and be accessible.
     * If a namespace argument is provided, it becomes the implicit namespace
     * for this instance (note that no guarantee is given that this namespace
     * actually exists in the Reference Ontology); otherwise, the implicit
     * namespace is set to the default namespace of the Reference Ontology in
     * the Repository. In the latter case if no default namespace is declared in
     * the Reference Ontology, the initialization fails.
     * <p/>
     * <b>WARNING!</b> At the time of writing, using the default namespace fails
     * even if it is actually declared in the ontology data - might be a problem
     * with the Sesame API, but anyhow you should declare your implicit
     * namespace in the 3-argument constructor: don't use the 2-argument one!
     *
     * @param server     the URL of the server
     * @param repository the name of the Repository
     * @param namespace  the namespace to be used as the implicit namespace, or null if
     *                   the default namespace declared in the Reference Ontology
     *                   should be used as the implicit namespace
     * @throws RuntimeException      if the Repository cannot be accessed, or the Reference
     *                               Ontology cannot be read for any reason
     * @throws IllegalStateException if no namespace argument was provided, and the Reference
     *                               Ontology declares no default namespace
     */
    public Sesame2RepositoryDAO(String server, String repository, String namespace)
            throws RuntimeException, IllegalStateException {
        if (null == server || server.isEmpty()) {
            throw new IllegalArgumentException("Server URL is mandatory");
        }
        if (null == repository || repository.isEmpty()) {
            throw new IllegalArgumentException("Repository name is mandatory");
        }
        if (null != namespace && !namespace.endsWith(Util.PATH_TERM)) {
            throw new IllegalArgumentException("Namespace must end with " + Util.PATH_TERM);
        }
        repo = new HTTPRepository(server, repository);
        RepositoryConnection con = null;
        try {
            repo.initialize();
            vf = repo.getValueFactory();
            ni = vf.createURI("http://www.w3.org/2002/07/owl#NamedIndividual");
            if (null == namespace || namespace.isEmpty()) {
                // no implicit namespace was provided, try to get the default
                // one
                con = repo.getConnection();
                con.setIsolationLevel(IsolationLevels.SERIALIZABLE);
                ns = con.getNamespace(null);
                if (null == ns) {
                    throw new IllegalStateException("No default namespace is available");
                }
            } else {
                // we get the namespace as-is
                ns = namespace;
            }
        } catch (RepositoryException e) {
            // RemoteRepositoryManager repo = new
            // RemoteRepositoryManager(server);
            // repo.initialize();
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * WARNING!!! **ANY DATA WILL BE LOST!!! DON'T USE IN PRODUCTION SYTEMS USE
     * INSTEAD THE ABOVE CONSTRUCTORS !!!**. Constructs a RepositoryDAO for
     * accessing a Reference Ontology in a given Sesame2 Repository. The
     * Repository is identified only by **namespace**. The given Repository is
     * in memory only for test purpose. If a namespace argument is provided, it
     * becomes the implicit namespace for this instance (note that no guarantee
     * is given that this namespace actually exists in the Reference Ontology);
     * otherwise, the implicit namespace is set to the default namespace of the
     * Reference Ontology in the Repository. In the latter case if no default
     * namespace is declared in the Reference Ontology, the initialization
     * fails.
     * <p/>
     * <b>WARNING!</b> At the time of writing, using the default namespace fails
     * even if it is actually declared in the ontology data - might be a problem
     * with the Sesame API, but anyhow you should declare your implicit
     * namespace in the 3-argument constructor: don't use the 2-argument one!
     *
     * @param namespace the namespace to be used as the implicit namespace, or null if
     *                  the default namespace declared in the Reference Ontology
     *                  should be used as the implicit namespace
     * @throws RuntimeException      if the Repository cannot be accessed, or the Reference
     *                               Ontology cannot be read for any reason
     * @throws IllegalStateException if no namespace argument was provided, and the Reference
     *                               Ontology declares no default namespace
     */
    public Sesame2RepositoryDAO(File dataDir, String namespace) throws RuntimeException, IllegalStateException {
        if (null != namespace && !namespace.endsWith(Util.PATH_TERM)) {
            throw new IllegalArgumentException("Namespace must end with " + Util.PATH_TERM);
        }
        if (null != dataDir)
            repo = new SailRepository(new MemoryStore(dataDir));
        else
            repo = new SailRepository(new MemoryStore());
        RepositoryConnection con = null;
        try {
            repo.initialize();
            vf = repo.getValueFactory();
            ni = vf.createURI("http://www.w3.org/2002/07/owl#NamedIndividual");
            if (null == namespace || namespace.isEmpty()) {
                // no implicit namespace was provided, try to get the default
                // one
                ns = con.getNamespace(null);
                if (null == ns) {
                    throw new IllegalStateException("No default namespace is available");
                }
            } else {
                // we get the namespace as-is
                ns = namespace;
            }
        } catch (RepositoryException e) {
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Returns true is this instance is initialized - i.e., no call to
     * {@link #release()} has been done.
     *
     * @return
     */
    public boolean isInitiliazed() {
        return repo != null;
    }

    /**
     * Releases all resources and de-initializes this instance. After calling
     * this method, {@link #isInitiliazed()} will return <code>false</code> and
     * this instance becomes useless: all methods which interact with the
     * Repository will throw {@link NullPointerException} when called. Always
     * call this method before discarding an instance, to prevent your
     * application (or event the Repository itself) to slow down or die due to
     * resource starving.
     */
    public void release() {
        if (null != repo) {
            try {
                repo.shutDown();
            } catch (RepositoryException e) {
                e.printStackTrace();
            }
            repo = null;
        }
    }

    /**
     * Add a file in format RDF to the repository.
     *
     * @param rdfFile  The file xml RDF containing Ontology
     * @param forceAdd Add file RDF content also if the repo in not empty
     * @author ascatox at 2016-04-26
     */

    public void addRdfFileToRepo(File rdfFile, String baseUri, boolean forceAdd) throws RuntimeException {
        if (null == repo)
            throw new IllegalStateException("No Repo is available");
        if (null == rdfFile) {
            throw new IllegalArgumentException("RDF File is mandatory");
        }
        if (null == baseUri || baseUri.isEmpty()) {
            baseUri = "file://" + rdfFile.getAbsolutePath();
        }
        try (RepositoryConnection con = repo.getConnection()) {
            long size = con.size();
            if (size == 0 || forceAdd)
                con.add(rdfFile, baseUri, RDFFormat.RDFXML);
        } catch (RDFParseException e) {
            throw new RuntimeException(e);
        } catch (RepositoryException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } catch (Throwable e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public String getImplicitNamespace() {
        return ns;
    }

    @Override
    public Document readOntology() throws RuntimeException {
        RepositoryConnection con = null;
        ByteArrayOutputStream os = null;
        try {
            con = repo.getConnection();
            // use RAM as a buffer for writing and reading as a stream
            os = new ByteArrayOutputStream();
            RDFXMLWriter writer = new RDFXMLWriter(os);
            con.export(writer);
        } catch (RepositoryException e) {
            throw new RuntimeException(e);
        } catch (RDFHandlerException e) {
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }

        // use RAM as a buffer for writing and reading as a stream
        ByteArrayInputStream is = new ByteArrayInputStream(os.toByteArray());
        try {
            return DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
        } catch (SAXException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (ParserConfigurationException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public ClassItem getClassHierarchy() throws RuntimeException {
        Map<String, List<ClassItem>> siblingsMap = new HashMap<String, List<ClassItem>>();
        List<BindingSet> results = executeSelect(QUERY_CLASSES);
        for (BindingSet result : results) {
            ClassItem cn = getClassItem(result);
            // update temporary map: keep all sibling nodes together, indexed by
            // their superclass name
            // if(cn.getNamespace() ==null ||
            // cn.getNamespace().trim().equals("") ||
            // cn.getNamespace().equalsIgnoreCase(getImplicitNamespace()))
            addToSiblings(cn, siblingsMap);
        }

        // the root of the hierarchical tree is always the owl:Thing node
        ClassItem root = new ClassItem(getImplicitNamespace(), OWL.THING.stringValue(), null);
        // build the tree using the temporary map of siblings and recursion
        setChildren(root, siblingsMap);
        return root;
    }

    @Override
    public List<PropertyDeclarationItem> getObjectProperties() throws RuntimeException {
        return getPropertyDeclarations(false, null);
    }

    @Override
    public List<PropertyDeclarationItem> getDataProperties() throws RuntimeException {
        return getPropertyDeclarations(true, null);
    }

    @Override
    public List<IndividualItem> getIndividuals() throws RuntimeException {
        return doGetIndividuals(QUERY_INDIVIDUALS, null);
    }

    @Override
    public List<IndividualItem> getIndividualsNoDomain() throws RuntimeException {
        String query = QUERY_INDIVIDUALS_NO_DOMAIN.replace(VARTAG, BeInCpps.SYSTEM_NS + BeInCpps.ownedBy)
                .replace(VARTAG2, SesameRepoManager.getNamespace());
        return doGetIndividuals(query, null);
    }

    @Override
    public List<IndividualItem> getIndividualsForDomain(String domain) throws RuntimeException {
        String query = QUERY_INDIVIDUALS_FOR_DOMAIN.replace(VARTAG, BeInCpps.SYSTEM_NS + BeInCpps.ownedBy)
                .replace(VARTAG2, domain);
        return doGetIndividuals(query, null);
    }

    @Override
    public List<IndividualItem> getIndividuals(String className) throws RuntimeException {
        if (null == className || className.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }
        className = Util.getGlobalName(getImplicitNamespace(), className);
        String qs = QUERY_INDIVIDUALS_FOR_CLASS.replace(VARTAG, className);
        return doGetIndividuals(qs, className);
    }

    @Override
    public List<IndividualItem> getIndividualsBySubClasses(String className) throws RuntimeException {
        if (null == className || className.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }
        className = Util.getGlobalName(getImplicitNamespace(), className);
        String qs = QUERY_INDIVIDUALS_BY_SUB_CLASSES.replace(VARTAG, className);
        return doGetIndividuals(qs, null);
    }

    @Override
    public List<IndividualItem> getIndividualsByOrionConfig(String orionConfig) throws RuntimeException {
        if (StringUtils.isBlank(orionConfig))
            throw new IllegalArgumentException("OrionConfig id is mandatory");
        String qs = QUERY_INDIVIDUALS_BY_ORION_CONFIG.replace(VARTAG, BeInCpps.SYSTEM_NS + BeInCpps.syncTo)
                .replace(VARTAG2, orionConfig);
        return doGetIndividuals(qs, null);
    }


    @Override
    public IndividualItem getIndividual(String name) throws RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Individual name is mandatory");
        }
        name = Util.getGlobalName(getImplicitNamespace(), name);
        return getIndividualDeclaration(name);
    }

    @Override
    public IndividualItem getIndividualByNS(String name, String namespace) throws RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Individual name is mandatory");
        }
        if (null == namespace || namespace.length() == 0) {
            throw new IllegalArgumentException("Namespace is mandatory");
        }
        name = Util.getGlobalName(namespace, name);
        return getIndividualDeclarationByNS(name, namespace);
    }

    @Override
    public List<PropertyValueItem> getIndividualAttributes(String name) throws RuntimeException {
        return doGetIndividualAttributes(name, getImplicitNamespace());
    }

    @Override
    public List<PropertyValueItem> getIndividualAttributesByNS(String name, String namespace) throws RuntimeException {
        return doGetIndividualAttributes(name, namespace);
    }

    public List<PropertyValueItem> doGetIndividualAttributes(String name, String namespace) throws RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Individual name is mandatory");
        }
        if (null == namespace || namespace.length() == 0)
            namespace = getImplicitNamespace();

        List<PropertyValueItem> items = new ArrayList<PropertyValueItem>();
        name = Util.getGlobalName(namespace, name);
        // System.out.println("VARTAG: "+name);
        String qs = QUERY_PROPS_FOR_INDIVIDUAL.replace(VARTAG, name);
        String lastName = null;
        List<BindingSet> results = executeSelect(qs);
        for (BindingSet result : results) {
            PropertyValueItem item = getPropertyValueItem(result, name);
            // silently discard duplicate entries: same name, different
            // range/value
            // (we only support the first range/value assertion)
            if (!item.getOriginalName().equals(lastName)) {
                items.add(item);
                lastName = item.getOriginalName();
            }
        }
        return items;
    }

    @Override
    public List<PropertyDeclarationItem> getAttributes() throws RuntimeException {
        List<PropertyDeclarationItem> items = new ArrayList<PropertyDeclarationItem>();
        String qs = QUERY_ALL_DATA_PROPS;
        List<BindingSet> results = executeSelect(qs);
        for (BindingSet result : results) {
            PropertyDeclarationItem item = getPropertyDeclarationItem(result);
            items.add(item);
        }
        return items;

    }

    private PropertyDeclarationItem getPropertyDeclarationItem(BindingSet s) {
        String name = s.getValue("name").stringValue();
        String type = s.getValue("type") != null ? s.getValue("type").stringValue()
                : OWL.DATATYPEPROPERTY.stringValue();
        Value v = s.getValue("range");
        String range = null != v ? v.stringValue() : null;
        return new PropertyDeclarationItem(getImplicitNamespace(), name, type, range);
    }

    private PropertyValueItem getPropertyValueItem(BindingSet s, String individualName) {
        String name = s.getValue("name").stringValue();
        String type = s.getValue("type").stringValue();
        Value v = s.getValue("range");
        String range = null != v ? v.stringValue() : null;
        String value = s.getValue("value").stringValue();
        return new PropertyValueItem(getImplicitNamespace(), name, type, range, individualName, value);
    }

    @Override
    public List<String> getDomains() throws RuntimeException {
        List<String> domains = new ArrayList<>();
        for (IndividualItem item : getIndividuals(BeInCpps.OWNER_CLASS)) {
            domains.add(BeInCpps.getLocalName(item.getIndividualName()));
        }
        return domains;
    }

    @Override
    public List<String> getProjects() throws RuntimeException {
        String query = QUERY_ALL_DOMAINS_IDM_URI.replace(VARTAG, BeInCpps.SYSTEM_NS + BeInCpps.ownedBy)
                .replace(VARTAG2, Constants.IDM_PROJECTS_PREFIX);
        return doGetProjects(query);
    }

    private List<String> doGetProjects(String query) throws RuntimeException {
        List<String> domains = new ArrayList<>();
        List<BindingSet> results = executeSelect(query);
        for (BindingSet result : results) {
            domains.add(result.getValue("domain").stringValue());
        }
        return domains;
    }

    @Override
    public void createDomain(String name) throws IllegalArgumentException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Domain name is mandatory");
        }

        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Domain must not be qualified by a namespace: " + name);
        }

        if (!Util.isValidLocalName(name)) {
            throw new IllegalArgumentException("Not a valid Domain name: " + name);
        }

        name = Util.getGlobalName(BeInCpps.SYSTEM_NS, name);
        if (getIndividualDeclarationCount(name) > 0) {
            throw new IllegalArgumentException("Domain " + name + " already exists");
        }

        List<Statement> statements = new ArrayList<Statement>();
        URI assetUri = vf.createURI(name);
        URI classUri = vf.createURI(BeInCpps.OWNER_CLASS);
        statements.add(vf.createStatement(assetUri, RDF.TYPE, classUri));
        statements.add(vf.createStatement(assetUri, RDF.TYPE, ni));

        addStatements(statements);
    }

    @Override
    public List<PropertyValueItem> getAttributesByNS(String name, String namespace) throws RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Individual name is mandatory");
        }
        List<PropertyValueItem> items = new ArrayList<PropertyValueItem>();
        name = Util.getGlobalName(namespace, name);
        String qs = QUERY_PROPS_FOR_INDIVIDUAL.replace(VARTAG, name);
        String lastName = null;
        List<BindingSet> results = executeSelect(qs);
        for (BindingSet result : results) {
            PropertyValueItem item = getPropertyValueItem(result, name);
            if (!item.getOriginalName().equals(lastName)) {
                items.add(item);
                lastName = item.getOriginalName();
            }
        }
        return items;
    }

    @Override
    public void createUser(String id) throws IllegalArgumentException, RuntimeException {
        String origUsername = id;
        if (null == id || id.length() == 0) {
            throw new IllegalArgumentException("User name is mandatory");
        }

        if (!Util.isLocalName(id)) {
            throw new IllegalArgumentException("User must not be qualified by a namespace: " + id);
        }

        if (!Util.isValidLocalName(id)) {
            throw new IllegalArgumentException("Not a valid User name: " + id);
        }

        id = Util.getGlobalName(BeInCpps.SYSTEM_NS, id);
        if (getIndividualDeclarationCount(id) > 0) {
            throw new IllegalArgumentException("User " + id + " already exists");
        }
        List<Statement> statements = new ArrayList<Statement>();
        URI assetUri = vf.createURI(id);
        URI classUri = vf.createURI(BeInCpps.USER_CLASS);
        statements.add(vf.createStatement(assetUri, RDF.TYPE, classUri));
        statements.add(vf.createStatement(assetUri, RDF.TYPE, ni));
        addStatements(statements);
    }

    @Override
    public void connectIndividualToOrionConfig(String individualName, String orionConfigId) {
        if (individualName == null || individualName.length() == 0)
            throw new IllegalArgumentException("Individual name is mandatory");
        if (orionConfigId == null || orionConfigId.isEmpty())
            throw new IllegalArgumentException("Orion config is mandatory");
        setAttribute(BeInCpps.syncTo, individualName, orionConfigId, null, BeInCpps.SYSTEM_NS);
    }

    @Override
    public boolean isIndividualConnectedToOrionConfig(String individualName, String orionConfigId) {
        if (individualName == null || individualName.length() == 0)
            throw new IllegalArgumentException("Individual name is mandatory");
        if (orionConfigId == null || orionConfigId.isEmpty())
            throw new IllegalArgumentException("Orion config is mandatory");
        List<PropertyValueItem> attributesByNS = getAttributesByNS(individualName, getImplicitNamespace());
        for (PropertyValueItem attribute : attributesByNS) {
            if (attribute.getNormalizedName().equals(BeInCpps.syncTo)
                    || attribute.getNormalizedName().equals(BeInCpps.SYSTEM_NS + BeInCpps.syncTo)) {
                if (attribute.getPropertyValue().equals(orionConfigId))
                    return true;
            }
        }
        return false;
    }

    @Override
    public String getIndividualOrionConfig(String individualName) {
        if (individualName == null || individualName.length() == 0)
            throw new IllegalArgumentException("Individual name is mandatory");
        List<PropertyValueItem> attributesByNS = getAttributesByNS(individualName, getImplicitNamespace());
        for (PropertyValueItem attribute : attributesByNS) {
            if (attribute.getNormalizedName().equals(BeInCpps.syncTo)
                    || attribute.getNormalizedName().equals(BeInCpps.SYSTEM_NS + BeInCpps.syncTo)) {
                return attribute.getPropertyValue();
            }
        }
        return null;
    }

    @Override
    public void disconnectIndividualFromOrionConfig(String individualName) {
        if (individualName == null || individualName.length() == 0)
            throw new IllegalArgumentException("Individual name is mandatory");
        removeProperty(BeInCpps.SYSTEM_NS, BeInCpps.syncTo, individualName);
    }

    @Override
    public List<String> getOrionConfigs() throws RuntimeException {
        List<String> names = new ArrayList<>();
        for (IndividualItem item : getIndividuals(BeInCpps.ORION_CONFIG_CLASS)) {
            names.add(BeInCpps.getLocalName(item.getIndividualName()));
        }
        return names;
    }

    @Override
    public void createOrionConfig(OrionConfig orionConfig) {
        if (null == orionConfig || null == orionConfig.getId() || orionConfig.getId().length() == 0) {
            throw new IllegalArgumentException("Orion Context Broker Id is mandatory");
        }
        if (null == orionConfig || orionConfig.isEmpty()) {
            throw new IllegalArgumentException("Orion Context Broker URL is mandatory");
        }
        if (!Util.isValidURL(orionConfig.getUrl())) {
            throw new IllegalArgumentException("A well formed URL is required: " + orionConfig.getUrl());
        }
        String orionConfigId = Util.getGlobalName(BeInCpps.SYSTEM_NS, orionConfig.getId());
        if (getIndividualDeclarationCount(orionConfigId) > 0) {
            throw new IllegalArgumentException("Orion Context Broker configuration " + orionConfigId + " already exists");
        }
        List<Statement> statements = new ArrayList<>();
        URI assetUri = vf.createURI(orionConfigId);
        URI classUri = vf.createURI(BeInCpps.ORION_CONFIG_CLASS);
        statements.add(vf.createStatement(assetUri, RDF.TYPE, classUri));
        statements.add(vf.createStatement(assetUri, RDF.TYPE, ni));
        addStatements(statements);
        setAttribute(OrionConfig.hasURL, orionConfig.getId(), orionConfig.getUrl(), null, BeInCpps.SYSTEM_NS);
        if (null != orionConfig.getService() && orionConfig.getService().length() > 0) {
            setAttribute(OrionConfig.hasService, orionConfig.getId(), orionConfig.getService(), null, BeInCpps.SYSTEM_NS);
        }
        if (null != orionConfig.getServicePath() && orionConfig.getServicePath().length() > 0) {
            setAttribute(OrionConfig.hasServicePath, orionConfig.getId(), orionConfig.getServicePath(), null, BeInCpps.SYSTEM_NS);
        }
    }

    @Override
    public void deleteOrionConfig(String orionConfigId) {
        doDeleteIndividual(orionConfigId, true);
    }


    @Override
    public void deleteDomain(String name) throws IllegalArgumentException, IllegalStateException, RuntimeException {
        doDeleteIndividual(name, true);
    }

    @Override
    public void deleteUser(String name) throws IllegalArgumentException, IllegalStateException, RuntimeException {
        doDeleteIndividual(name, true);
    }

    @Override
    public void createClass(String name, String parentName) throws IllegalArgumentException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }

        // only "user-defined" classes can be moved
        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Class name must not be qualified by a namespace: " + name);
        }

        if (!Util.isValidLocalName(name)) {
            throw new IllegalArgumentException("Not a valid Class name: " + name);
        }

        name = Util.getGlobalName(getImplicitNamespace(), name);
        if (getClassDeclarationCount(name) > 0) {
            throw new IllegalArgumentException("Class " + name + " already exists");
        }

        URI classUri = vf.createURI(name);
        URI superClassUri = null;
        if (null == parentName || OWL.THING.stringValue().equals(parentName)) {
            superClassUri = OWL.THING;
        } else {
            parentName = Util.getGlobalName(getImplicitNamespace(), parentName);
            if (getClassDeclarationCount(parentName) == 0) {
                throw new IllegalArgumentException("SuperClass " + parentName + " does not exist");
            }
            superClassUri = vf.createURI(parentName);
        }

        List<Statement> statements = new ArrayList<Statement>();
        statements.add(vf.createStatement(classUri, RDF.TYPE, OWL.CLASS));
        statements.add(vf.createStatement(classUri, RDFS.SUBCLASSOF, superClassUri));

        addStatements(statements);
    }

    @Override
    public void moveClass(String name, String parentName) throws IllegalArgumentException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }

        if (name.equals(parentName)) {
            throw new IllegalArgumentException("Class parent could not be itself");
        }

        // only "user-defined" classes can be moved
        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Class name must not be qualified by a namespace: " + name);
        }

        name = Util.getGlobalName(getImplicitNamespace(), name);
        if (getClassDeclarationCount(name) == 0) {
            throw new IllegalArgumentException("Class " + name + " does not exist");
        }

        if (null == parentName || parentName.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }

        // classes can be moved only under "user-defined" classes, or under
        // owl:Thing
        if (!Util.isLocalName(parentName) && !OWL.THING.stringValue().equals(parentName)) {
            throw new IllegalArgumentException("Class name must not be qualified by a namespace: " + parentName);
        }

        parentName = Util.getGlobalName(getImplicitNamespace(), parentName);
        if (!OWL.THING.stringValue().equals(parentName) && getClassDeclarationCount(parentName) == 0) {
            throw new IllegalArgumentException("SuperClass " + parentName + " does not exist");
        }

        RepositoryConnection con = null;
        try {
            con = repo.getConnection();
            con.begin();

            URI classUri = vf.createURI(name);
            URI superClassUri = vf.createURI(parentName);
            con.remove(classUri, RDFS.SUBCLASSOF, null);
            con.add(vf.createStatement(classUri, RDFS.SUBCLASSOF, superClassUri));

            con.commit();
        } catch (RepositoryException e) {
            if (null != con) {
                try {
                    con.rollback();
                } catch (RepositoryException e1) {
                    throw new RuntimeException(e);
                }
            }
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void deleteClass(String name) throws IllegalArgumentException, IllegalStateException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }

        // only "user-defined" classes can be deleted
        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Class name must not be qualified by a namespace: " + name);
        }
        String shortName = name;
        name = Util.getGlobalName(getImplicitNamespace(), name);
        if (getClassDeclarationCount(name) == 0) {
            throw new IllegalArgumentException("Class " + shortName + " does not exist");
        }

        if (getDependencyCount(name) > 0) {
            throw new IllegalStateException("Class " + shortName + " cannot be deleted as it is referenced somewhere else");
        }

        URI classUri = vf.createURI(name);
        removeAllStatements(classUri, null, null);
    }

    @Override
    public void renameClass(String oldName, String newName) throws IllegalArgumentException, RuntimeException {
        if (null == oldName || oldName.length() == 0 || null == newName || newName.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }

        // only "user-defined" classes can be renamed
        if (!Util.isLocalName(oldName)) {
            throw new IllegalArgumentException("Class name must not be qualified by a namespace: " + oldName);
        }

        // classes can only be renamed as "user-defined" classes
        if (!Util.isLocalName(newName)) {
            throw new IllegalArgumentException("Class name must not be qualified by a namespace: " + newName);
        }

        oldName = Util.getGlobalName(getImplicitNamespace(), oldName);
        if (getClassDeclarationCount(oldName) == 0) {
            throw new IllegalArgumentException("Class " + oldName + " does not exist");
        }

        newName = Util.getGlobalName(getImplicitNamespace(), newName);
        if (getClassDeclarationCount(newName) > 0) {
            throw new IllegalArgumentException("Class " + newName + " already exists");
        }

        RepositoryConnection con = null;
        try {
            con = repo.getConnection();
            con.begin();

            URI oldUri = vf.createURI(oldName);
            URI newUri = vf.createURI(newName);
            RepositoryResult<Statement> subjStatements = con.getStatements(oldUri, null, null, false);
            RepositoryResult<Statement> objStatements = con.getStatements(null, null, oldUri, false);
            while (subjStatements.hasNext()) {
                Statement stmt = subjStatements.next();
                con.remove(stmt);
                con.add(vf.createStatement(newUri, stmt.getPredicate(), stmt.getObject()));
            }
            while (objStatements.hasNext()) {
                Statement stmt = objStatements.next();
                con.remove(stmt);
                con.add(vf.createStatement(stmt.getSubject(), stmt.getPredicate(), newUri));
            }

            con.commit();
        } catch (RepositoryException e) {
            if (null != con) {
                try {
                    con.rollback();
                } catch (RepositoryException e1) {
                    throw new RuntimeException(e);
                }
            }
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void createAssetModel(String name, String className, String domainName)
            throws IllegalArgumentException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Asset name is mandatory");
        }

        if (null == className || className.length() == 0) {
            throw new IllegalArgumentException("Class name is mandatory");
        }

        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Asset name must not be qualified by a namespace: " + name);
        }

        if (!Util.isValidLocalName(name)) {
            throw new IllegalArgumentException("Not a valid Asset name: " + name);
        }

        if (!Util.isLocalName(className)) {
            throw new IllegalArgumentException("Asset Class must not be qualified by a namespace: " + className);
        }

        name = Util.getGlobalName(getImplicitNamespace(), name);
        if (getIndividualDeclarationCount(name) > 0) {
            throw new IllegalArgumentException(
                    "Asset " + Util.getLocalName(getImplicitNamespace(), name) + " already exists");
        }

        className = Util.getGlobalName(getImplicitNamespace(), className);
        if (getClassDeclarationCount(className) == 0) {
            throw new IllegalArgumentException("Asset Class " + className + " does not exist");
        }

        List<Statement> statements = new ArrayList<Statement>();
        URI assetUri = vf.createURI(name);
        URI classUri = vf.createURI(className);
        statements.add(vf.createStatement(assetUri, RDF.TYPE, classUri));
        statements.add(vf.createStatement(assetUri, RDF.TYPE, ni));

        URI createdUri = vf.createURI(BeInCpps.SYSTEM_NS, BeInCpps.createdOn);
        Literal createdValue = vf.createLiteral(new Date());
        statements.add(vf.createStatement(assetUri, createdUri, createdValue));

        if (null != domainName && !domainName.isEmpty()) {
            if (!Util.isValidDomainURI(domainName)) {
                throw new IllegalArgumentException("Domain must be a valid IDM URI");
            }
            URI ownedByUri = vf.createURI(BeInCpps.SYSTEM_NS, BeInCpps.ownedBy);
            URI domainUri = null;
            try {
                domainUri = vf.createURI(Util.getIdmURI(domainName));
            } catch (MalformedURLException e) {
                throw new RuntimeIOException(e);
            }
            statements.add(vf.createStatement(assetUri, ownedByUri, domainUri));
        }

        addStatements(statements);
    }

    @Override
    public void deleteIndividual(String name) throws IllegalArgumentException, IllegalStateException, RuntimeException {
        doDeleteIndividual(name, false);
    }

    @Override
    public void createAsset(String name, String modelName, String domainName)
            throws IllegalArgumentException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Asset name is mandatory");
        }

        if (null == modelName || modelName.length() == 0) {
            throw new IllegalArgumentException("Model name is mandatory");
        }

        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Asset name must not be qualified by a namespace: " + name);
        }

        if (!Util.isValidLocalName(name)) {
            throw new IllegalArgumentException("Not a valid Asset name: " + name);
        }

        if (!Util.isLocalName(modelName)) {
            throw new IllegalArgumentException("Model name must not be qualified by a namespace: " + modelName);
        }

        name = Util.getGlobalName(getImplicitNamespace(), name);
        if (getIndividualDeclarationCount(name) > 0) {
            throw new IllegalArgumentException(
                    "Asset " + Util.getLocalName(getImplicitNamespace(), name) + " already exists");
        }

        modelName = Util.getGlobalName(getImplicitNamespace(), modelName);
        IndividualItem model = getIndividualDeclaration(modelName);
        if (model == null) {
            throw new IllegalArgumentException("Asset Model " + modelName + " does not exist");
        }

        List<Statement> statements = new ArrayList<Statement>();
        URI assetUri = vf.createURI(name);
        URI classUri = vf.createURI(model.getOriginalValue()); // class info is
        // hold by
        // Tuple.originalValue
        statements.add(vf.createStatement(assetUri, RDF.TYPE, classUri));
        statements.add(vf.createStatement(assetUri, RDF.TYPE, ni));

        URI createdUri = vf.createURI(BeInCpps.SYSTEM_NS, BeInCpps.createdOn);
        statements.add(vf.createStatement(assetUri, createdUri, vf.createLiteral(new Date())));

        URI instanceUri = vf.createURI(BeInCpps.SYSTEM_NS, BeInCpps.instanceOf);
        URI modelUri = vf.createURI(modelName);
        statements.add(vf.createStatement(assetUri, instanceUri, modelUri));

        if (null != domainName && !domainName.isEmpty()) {
            if (!Util.isValidDomainURI(domainName)) {
                throw new IllegalArgumentException("Domain must be a valid IDM URI");
            }
            URI ownedByUri = vf.createURI(BeInCpps.SYSTEM_NS, BeInCpps.ownedBy);
            URI domainUri = null;
            try {
                domainUri = vf.createURI(Util.getIdmURI(domainName));
            } catch (MalformedURLException e) {
                throw new RuntimeIOException(e);
            }
            statements.add(vf.createStatement(assetUri, ownedByUri, domainUri));
        }

        List<PropertyValueItem> props = getIndividualAttributes(modelName);
        for (PropertyValueItem prop : props) {
            String propName = prop.getOriginalName();
            String propValue = prop.getPropertyOriginalValue();
            if (!propName.startsWith(BeInCpps.SYSTEM_NS)) {
                URI propUri = vf.createURI(propName);
                Value pv = null;
                if (null != propValue && propValue.length() > 0) {
                    if (prop.getPropertyType() == Object.class) {
                        pv = vf.createURI(propValue);
                    } else {
                        pv = vf.createLiteral(propValue);
                    }
                } else {
                    pv = vf.createLiteral("");
                }
                statements.add(vf.createStatement(assetUri, propUri, pv));
            }
        }

        // execute update
        addStatements(statements);
    }

    @Override
    public void setAttribute(String name, String individualName, String value)
            throws IllegalArgumentException, RuntimeException {
        setAttribute(name, individualName, value, null);
    }

    @Override
    public void setAttribute(String name, String individualName, String value, Class<?> type)
            throws IllegalArgumentException, RuntimeException {
        setProperty(name, individualName, value, type, true);
    }

    @Override
    public void setAttribute(String name, String individualName, String value, Class<?> type, String namespace)
            throws IllegalArgumentException, RuntimeException {
        setProperty(name, individualName, value, type, true, namespace);
    }

    @Override
    public void setRelationship(String name, String individualName, String referredName)
            throws IllegalArgumentException, RuntimeException {
        setProperty(name, individualName, referredName, null, false);
    }

    @Override
    public void removeProperty(String name, String individualName) throws IllegalArgumentException, RuntimeException {
        removeProperty(null, name, individualName);
    }

    @Override
    public void removeProperty(String namespace, String name, String individualName) throws IllegalArgumentException, RuntimeException {
        if (StringUtils.isBlank(namespace))
            namespace = getImplicitNamespace();

        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Property name is mandatory");
        }

        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Property name must not be qualified by a namespace: " + name);
        }

        if (null == individualName || individualName.length() == 0) {
            throw new IllegalArgumentException("Individual name is mandatory");
        }

        if (!Util.isLocalName(individualName)) {
            throw new IllegalArgumentException(
                    "Individual name must not be qualified by a namespace: " + individualName);
        }

        individualName = Util.getGlobalName(getImplicitNamespace(), individualName);
        if (null == getIndividualDeclaration(individualName)) {
            throw new IllegalArgumentException("Individual does not exist: " + individualName);
        }

        name = Util.getGlobalName(namespace, name);
        if (null == getPropertyValue(individualName, name)) {
            throw new IllegalArgumentException("Property " + name + " is not set on Asset " + individualName);
        }

        URI indivUri = vf.createURI(individualName);
        URI propUri = vf.createURI(name);
        removeAllStatements(indivUri, propUri, null);

        // if no other assignments are left, remove the property declaration as
        // well
        if (getPropertyInstanceCount(name) == 0) {
            removeAllStatements(propUri, null, null);
        }
    }

    private ClassItem getClassItem(BindingSet s) {
        String clazz = s.getValue("name").stringValue();
        Value v = s.getValue("superclass");
        String sclazz = null != v ? v.stringValue() : OWL.THING.stringValue();
        // return new ClassItem(getImplicitNamespace(), clazz, sclazz);
        if (clazz.contains("#"))
            return new ClassItem(clazz.substring(0, clazz.indexOf("#") + 1), clazz, sclazz);
        else
            return new ClassItem(getImplicitNamespace(), clazz, sclazz);
    }

    /**
     * Adds the given node to the list of nodes which share the same parent. If
     * no siblings exist (yet), initialize a new list for the current parent.
     *
     * @param cn
     * @param siblingsMap
     */
    private void addToSiblings(ClassItem cn, Map<String, List<ClassItem>> siblingsMap) {
        List<ClassItem> siblings = siblingsMap.get(cn.getOriginalValue());
        if (null == siblings) {
            siblings = new ArrayList<ClassItem>();
            siblingsMap.put(cn.getOriginalValue(), siblings);
        }
        siblings.add(cn);
    }

    /**
     * Given a node, initializes its list of child nodes; each child is also
     * initialized with a reference to its parent (the given node). When done,
     * propagate the call recursively to all children.
     *
     * @param cn
     * @param classMap
     */
    private void setChildren(ClassItem cn, Map<String, List<ClassItem>> classMap) {
        List<ClassItem> children = classMap.get(cn.getOriginalName());
        if (null != children) {
            cn.getSubClasses().addAll(children);
            for (ClassItem child : children) {
                child.setSuperClass(cn);
                setChildren(child, classMap); // recursion
            }
        }
    }

    private List<IndividualItem> doGetIndividuals(String qs, String className) throws RuntimeException {
        List<IndividualItem> items = new ArrayList<IndividualItem>();
        List<BindingSet> results = executeSelect(qs);
        for (BindingSet result : results) {
            items.add(getIndividualItem(result, className));
        }
        return items;
    }

    private IndividualItem getIndividualItem(BindingSet s, String className) {
        String name = s.getValue("name").stringValue();
        String clazz = null != className ? className : s.getValue("class").stringValue();
        if (name.contains("#"))
            return new IndividualItem(name.substring(0, name.indexOf("#") + 1), name, clazz);
        return new IndividualItem(getImplicitNamespace(), name, clazz);
    }

    private void doDeleteIndividual(String name, boolean system)
            throws IllegalArgumentException, IllegalStateException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Individual name is mandatory");
        }

        if (!Util.isLocalName(name)) {
            throw new IllegalArgumentException("Individual name must not be qualified by a namespace: " + name);
        }

        String ns = system ? BeInCpps.SYSTEM_NS : getImplicitNamespace();
        String shortName = name;
        name = Util.getGlobalName(ns, name);
        IndividualItem indiv = getIndividualDeclaration(name);
        if (indiv != null) {
            List<BindingSet> dependencies = getDependencies(name);
            if (dependencies.size() > 0) {
                String msg = "Individual " + shortName + " cannot be deleted as it is referenced by: ";
                for (BindingSet bindingSet : dependencies) {
                    String depName = bindingSet.getValue("name").stringValue();
                    if (depName.contains("#")) {
                        depName = depName.substring(name.indexOf("#") + 1);
                    }
                    msg += depName + ", ";
                }
                msg = msg.substring(0, msg.lastIndexOf(","));

                throw new IllegalStateException(msg);
            }

            // when an individual is deleted, all its property assignments are
            // deleted too:
            // to be consistent with what we do when deleting a single
            // assignments, for each
            // deleted assignment regarding a "user-defined" property (i.e., not
            // in the "system"
            // namespace) we should check that at least one individual is still
            // referencing the
            // same property; if that is not the case, the property declaration
            // should be deleted
            // as well. Note that we must go through all these steps in a
            // specific order, as we
            // cannot count on transactions: first we collect all the names of
            // the properties
            // which are involved, then we delete the individual, and finally we
            // iterate on the
            // property names and do check/delete on each one
            List<String> propNames = new ArrayList<String>();
            if (!system) {
                List<PropertyValueItem> props = getIndividualAttributes(name);
                for (PropertyValueItem prop : props) {
                    String propName = prop.getOriginalName(); // get the full
                    // URI, not the
                    // normalized
                    // name
                    if (propName.startsWith(getImplicitNamespace())) {
                        propNames.add(propName);
                    }
                }
            }

            URI targetUri = vf.createURI(name);
            removeAllStatements(targetUri, null, null);

            if (!system) {
                for (String propName : propNames) {
                    // if no other assignments are left, remove the property
                    // declaration as well
                    if (getPropertyInstanceCount(propName) == 0) {
                        removeAllStatements(vf.createURI(propName), null, null);
                    }
                }
            }
        } else {
            throw new IllegalArgumentException("Individual does not exists: " + name);
        }
    }

    private IndividualItem getIndividualDeclaration(String name) throws RuntimeException {
        return getIndividualDeclarationImpl(name, getImplicitNamespace());
    }

    private IndividualItem getIndividualDeclarationByNS(String name, String namespace) throws RuntimeException {
        return getIndividualDeclarationImpl(name, namespace);
    }

    private IndividualItem getIndividualDeclarationImpl(String name, String namespace) {
        IndividualItem item = null;
        String qs = QUERY_SINGLE_INDIVIDUAL.replace(VARTAG, name);
        List<BindingSet> results = executeSelect(qs);
        for (BindingSet result : results) {
            String clazz = result.getValue("class").stringValue();
            item = new IndividualItem(namespace, name, clazz);
            break;
        }
        return item;
    }

    private List<PropertyDeclarationItem> getPropertyDeclarations(boolean data, String propName)
            throws RuntimeException {
        List<PropertyDeclarationItem> items = new ArrayList<PropertyDeclarationItem>();
        String qstr = null;
        if (null != propName) {
            qstr = data ? QUERY_DATA_PROP : QUERY_OBJECT_PROP;
            qstr = qstr.replace(VARTAG, propName);
        } else {
            qstr = data ? QUERY_DATA_PROPS : QUERY_OBJECT_PROPS;
        }
        String type = data ? OWL.DATATYPEPROPERTY.stringValue() : OWL.OBJECTPROPERTY.stringValue();
        String lastName = null;
        List<BindingSet> results = executeSelect(qstr);
        for (BindingSet result : results) {
            PropertyDeclarationItem item = getPropertyDeclarationItem(result, type);
            // silently discard duplicate entries: same name, different range
            // (we only support the first range assertion)
            if (!item.getOriginalName().equals(lastName)) {
                items.add(item);
                lastName = item.getOriginalName();
            }
        }
        return items;
    }

    private PropertyDeclarationItem getPropertyDeclarationItem(BindingSet s, String type) {
        String name = s.getValue("name").stringValue();
        Value v = s.getValue("range");
        String range = null != v ? v.stringValue() : null;
        return new PropertyDeclarationItem(getImplicitNamespace(), name, type, range);
    }

    private String getPropertyValue(String individualName, String propertyName) throws RuntimeException {
        // assuming both arguments are absolute URIs
        String qs = QUERY_PROP_FOR_INDIVIDUAL.replace(VARTAG, individualName).replace(VARTAG2, propertyName);
        List<BindingSet> results = executeSelect(qs);
        if (results.size() > 0) {
            return results.get(0).getBinding("value").getValue().stringValue();
        } else {
            return null;
        }
    }

    private int getClassDeclarationCount(String name) throws RuntimeException {
        // assuming arguments is an absolute URI
        String qs = QUERY_CLASS.replace(VARTAG, name);
        return executeSelect(qs).size();
    }

    private int getIndividualDeclarationCount(String name) throws RuntimeException {
        // assuming arguments is an absolute URI
        String qs = QUERY_SINGLE_INDIVIDUAL.replace(VARTAG, name);
        return executeSelect(qs).size();
    }

    private int getPropertyInstanceCount(String name) throws RuntimeException {
        // assuming arguments is an absolute URI
        String qs = QUERY_PROP_ASSIGNMENTS.replace(VARTAG, name);
        return executeSelect(qs).size();
    }

    private int getDependencyCount(String name) throws RuntimeException {
        // assuming arguments is an absolute URI
        // String qs = QUERY_DEPENDENCIES.replace(VARTAG, name);
        return getDependencies(name).size();
    }

    private List<BindingSet> getDependencies(String name) {
        String qs = QUERY_DEPENDENCIES.replace(VARTAG, name);
        return executeSelect(qs);
    }

    private void setProperty(String name, String individualName, String value, Class<?> type, boolean dataProp)
            throws IllegalArgumentException, RuntimeException {
        setProperty(name, individualName, value, type, dataProp, null);
    }

    private void setProperty(String name, String individualName, String value, Class<?> type, boolean dataProp, String namespace)
            throws IllegalArgumentException, RuntimeException {
        if (null == name || name.length() == 0) {
            throw new IllegalArgumentException("Property name is mandatory");
        }

        if (null == individualName || individualName.length() == 0) {
            throw new IllegalArgumentException("Individual name is mandatory");
        }

        if (!Util.isLocalName(individualName)) {
            throw new IllegalArgumentException(
                    "Individual name must not be qualified by a namespace: " + individualName);
        }
        if (StringUtils.isBlank(namespace))
            namespace = getImplicitNamespace();
        String individualName_ = Util.getGlobalName(getImplicitNamespace(), individualName);
        if (null == getIndividualDeclaration(individualName_)) {
            individualName_ = Util.getGlobalName(BeInCpps.SYSTEM_NS, individualName);
            if (null == getIndividualDeclaration(individualName_))
                throw new IllegalArgumentException("Individual does not exist: " + individualName);
        }
        individualName = individualName_;
        URI indivUri = vf.createURI(individualName);
        URI propUri = null;
        if (Util.isLocalName(name)) {
            propUri = vf.createURI(Util.getGlobalName(namespace, name));
        } else {
            propUri = vf.createURI(name);
        }

        List<Statement> statements = new ArrayList<Statement>();

        if (dataProp) {

            // get the declaration for this property, if any
            PropertyDeclarationItem propDecl = null;
            List<PropertyDeclarationItem> results = getPropertyDeclarations(true, propUri.stringValue());
            if (results.size() > 0) {
                // if multiple ranges are declared, get the first and ignore the
                // rest
                propDecl = results.get(0);
            }

            if (propDecl != null) {
                // this property already exists: the effective type comes from
                // the declared range
                // (the original "type" argument is ignored)
                // note that if no range is declared, type defaults to String
                type = propDecl.getPropertyType();
            } else {
                // this property must be created with the given range: normalize
                // type argument
                if (null != type) {
                    // caller provides a type: should be a supported one
                    if (!Util.isSupportedType(type)) {
                        throw new IllegalArgumentException("Unsupported Property type: " + type);
                    }
                } else {
                    // caller does not provide any type: default to String
                    type = String.class;
                }

                // check that the name is valid, then prepare statements
                if (Util.isLocalName(name)) {
                    if (!Util.isValidLocalName(name)) {
                        throw new IllegalArgumentException("Not a valid Property name: " + name);
                    }
                } else {
                    throw new IllegalArgumentException("Property names must not be qualified by a namespace: " + name);
                }

                // prepare declaration statements (with range)
                statements.add(vf.createStatement(propUri, RDF.TYPE, OWL.DATATYPEPROPERTY));
                statements.add(vf.createStatement(propUri, RDFS.RANGE, getRangeFromType(type)));
            }

            // check that provided value is legal, then prepare assignment
            // statement
            if (!Util.isValidValue(value, type)) {
                throw new IllegalArgumentException(
                        "Bad Property value: " + value + " (cannot be converted into " + type + ")");
            }

            Value object = null != value ? vf.createLiteral(value) : vf.createLiteral("");
            statements.add(vf.createStatement(indivUri, propUri, object));

        } else {

            // get the declaration for this property, if any
            boolean declareProp = true;
            List<PropertyDeclarationItem> results = getPropertyDeclarations(true, propUri.stringValue());
            if (results.size() > 0) {
                declareProp = false;
            }
            if (declareProp) {
                // this property is new and a declaration should be created:
                // check that the name is valid, then prepare statements
                if (Util.isLocalName(name)) {
                    if (!Util.isValidLocalName(name)) {
                        throw new IllegalArgumentException("Not a valid Property name: " + name);
                    }
                } else {
                    throw new IllegalArgumentException("Property names must not be qualified by a namespace: " + name);
                }

                // prepare declaration statement (range not supported)
                statements.add(vf.createStatement(propUri, RDF.TYPE, OWL.OBJECTPROPERTY));
            }

            URI referenceUri = null;
            if (null != value && value.length() > 0) {
                referenceUri = Util.isLocalName(value) ? vf.createURI(getImplicitNamespace(), value)
                        : vf.createURI(value);
                if (null == getIndividualDeclaration(referenceUri.stringValue())) {
                    referenceUri = Util.isLocalName(value) ? vf.createURI(BeInCpps.SYSTEM_NS, value)
                            : vf.createURI(value);
                    if (null == getIndividualDeclaration(referenceUri.stringValue()))
                        throw new IllegalArgumentException(
                                "Reference cannot be resolved to an existing Individual: " + value);
                }
            }

            Value object = null != referenceUri ? referenceUri : vf.createLiteral("");
            statements.add(vf.createStatement(indivUri, propUri, object));
        }

        // execute update
        removeAllStatements(indivUri, propUri, null);
        addStatements(statements);
    }

    private List<BindingSet> executeSelect(String query) {
        List<BindingSet> results = new ArrayList<BindingSet>();
        RepositoryConnection con = null;
        try {
            con = repo.getConnection();
            TupleQueryResult r = con.prepareTupleQuery(QueryLanguage.SPARQL, query).evaluate();
            while (r.hasNext()) {
                results.add(r.next());
            }
        } catch (RepositoryException e) {
            throw new RuntimeException(e);
        } catch (MalformedQueryException e) {
            throw new RuntimeException(e);
        } catch (QueryEvaluationException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return results;
    }

    private void addStatements(List<Statement> statements) {
        RepositoryConnection con = null;
        try {
            con = getConnection();
            if (!isInTransaction())
                con.begin(IsolationLevels.SERIALIZABLE);
            for (Statement statement : statements) {
                con.add(statement);
            }
            if (!isInTransaction())
                con.commit();
        } catch (RepositoryException e) {
            if (null != con) {
                try {
                    if (!isInTransaction())
                        con.rollback();
                } catch (RepositoryException e1) {
                    throw new RuntimeException(e);
                }
            }
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    if (!isInTransaction())
                        con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void removeAllStatements(Resource subject, URI predicate, Value object) {
        RepositoryConnection con = null;
        try {
            con = getConnection();
            if (!isInTransaction())
                con.begin(IsolationLevels.READ_COMMITTED);
            RepositoryResult<Statement> statements = con.getStatements(subject, predicate, object, false);
            while (statements.hasNext()) {
                con.remove(statements.next());
            }
            if (!isInTransaction())
                con.commit();
        } catch (RepositoryException e) {
            if (null != con) {
                try {
                    if (!isInTransaction())
                        con.rollback();
                } catch (RepositoryException e1) {
                    throw new RuntimeException(e);
                }
            }
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    if (!isInTransaction())
                        con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private URI getRangeFromType(Class<?> type) {
        if (String.class == type) {
            return XMLSchema.STRING;
        } else if (Integer.class == type) {
            return XMLSchema.INTEGER;
        } else if (Long.class == type) {
            return XMLSchema.LONG;
        } else if (Short.class == type) {
            return XMLSchema.SHORT;
        } else if (BigDecimal.class == type) {
            return XMLSchema.DECIMAL;
        } else if (Double.class == type) {
            return XMLSchema.DOUBLE;
        } else if (Float.class == type) {
            return XMLSchema.FLOAT;
        } else if (Calendar.class == type) {
            return XMLSchema.DATETIME;
        } else if (Boolean.class == type) {
            return XMLSchema.BOOLEAN;
        } else {
            throw new IllegalArgumentException("Unsupported type: " + type);
        }
    }

    /**
     * Only for internal testing, don't use!
     */
    public void runTest01() {
        RepositoryConnection con = null;
        URI name = vf.createURI("http://www.msee-ip.eu/bao#Bivolino-WeavingMachine");
        try {
            con = repo.getConnection();
            System.out.println("AS SUBJECT:");
            RepositoryResult<Statement> statements = con.getStatements(name, null, null, true);
            while (statements.hasNext()) {
                System.out.println(statements.next().toString());
            }
            System.out.println("");
            System.out.println("");
            System.out.println("AS OBJECT:");
            statements = con.getStatements(null, null, name, true);
            while (statements.hasNext()) {
                System.out.println(statements.next().toString());
            }
        } catch (RepositoryException e) {
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Only for internal testing, don't use!
     */
    public void runTest02() {
        RepositoryConnection con = null;
        try {
            con = repo.getConnection();
            RepositoryResult<Namespace> ns = con.getNamespaces();
            while (ns.hasNext()) {
                System.out.println(ns.next().toString());
            }
        } catch (RepositoryException e) {
            throw new RuntimeException(e);
        } finally {
            if (null != con) {
                try {
                    con.close();
                } catch (RepositoryException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
