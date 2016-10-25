package it.eng.ontorepo.test;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.print.attribute.standard.MediaSize;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import it.eng.ontorepo.*;
import org.w3c.dom.Document;

import it.eng.ontorepo.sesame2.Sesame2RepositoryDAO;

public class TestDriver {

    /**
     * USAGE:
     * arg1 = server URL
     * arg2 = repository name
     * arg3 = implicit namespace
     *
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {

        // defaults: if you pass anything else on the commmand line, it will override the following settings
        //String server = "http://tpvision-eng.it:8180/openrdf-sesame/";
        String server = "http://localhost:8180/openrdf-sesame/"; // if you are not running on a local instance, set the correct URL
        String repository = "DEFAULT"; // the name YOU gave to your test repository: change ad libitum
        String namespace = "http://www.msee-ip.eu/ontology/bivolino#"; // you SHOULD use TA_BIVOLINO.owl, so this is unlikely to change

        if (args.length >= 3) {
            server = args[0];
            repository = args[1];
            namespace = args[2];
        }

        Sesame2RepositoryDAO dao = new Sesame2RepositoryDAO(server, repository, namespace);

        // UNCOMMENT THE TESTS YOU WANT TO RUN

        testGetAttributes(dao);

        //dao.runTest01();
        //dao.runTest02();

        runAllReadMethods(dao);

//		runClassesTest(dao, "C:/fileStep1.xml", "C:/fileStep2.xml", "C:/fileStep3.xml", "C:/fileStep4.xml", "C:/fileStep5.xml");

//		runIndividualsTest1(dao, "C:/fileStep1.xml", "C:/fileStep2.xml", "C:/fileStep3.xml", "C:/fileStep4.xml", "C:/fileStep5.xml");

//		runIndividualsTest2(dao, "C:/fileStep1.xml", "C:/fileStep2.xml", "C:/fileStep3.xml", "C:/fileStep4.xml", "C:/fileStep5.xml", "C:/fileStep6.xml");

//		runIndividualsTest3(dao, "C:/fileStep1.xml", "C:/fileStep2.xml", "C:/fileStep3.xml", "C:/fileStep4.xml", "C:/fileStep5.xml");

        dao.release();
    }

    public static void testUpdatePrePost(RepositoryDAO dao, String filePre, String filePost)
            throws IOException, TransformerException {
    }

    public static void printTree(ClassItem cn, String ws, PrintStream ps) {
        ps.println(ws + cn.toString());
        List<ClassItem> children = cn.getSubClasses();
        if (null != children) {
            ws = ws + "\t";
            for (ClassItem child : children) {
                printTree(child, ws, ps); // recursion
            }
        }
    }

    public static void runAllReadMethods(RepositoryDAO dao) {
        ClassItem root = dao.getClassHierarchy();
        System.out.println("PRINTING CLASS DECLARATIONS **********");
        printTree(root, "", System.out);
        System.out.println("CLASS DECLARATIONS PRINTED **********");
        System.out.println();
        System.out.println();
        System.out.println();

        List<PropertyDeclarationItem> props = dao.getDataProperties();
        System.out.println("PRINTING DATATYPE PROPERTIES **********");
        for (PropertyDeclarationItem prop : props) {
            System.out.println(prop.toString());
        }
        System.out.println("DATATYPE PROPERTIES PRINTED **********");
        System.out.println();
        System.out.println();
        System.out.println();

        props = dao.getObjectProperties();
        System.out.println("PRINTING OBJECT PROPERTIES **********");
        for (PropertyDeclarationItem prop : props) {
            System.out.println(prop.toString());
        }
        System.out.println("OBJECT PROPERTIES PRINTED **********");
        System.out.println();
        System.out.println();
        System.out.println();

        List<IndividualItem> indivs = dao.getIndividuals();
        IndividualItem selectedIndiv = null;
        System.out.println("PRINTING ALL INDIVIDUALS **********");
        for (IndividualItem indiv : indivs) {
            System.out.println(indiv.toString());
            selectedIndiv = null == selectedIndiv ? indiv : selectedIndiv; // we capture the first item in the loop
        }
        System.out.println("ALL INDIVIDUALS PRINTED **********");
        System.out.println();
        System.out.println();
        System.out.println();

        if (selectedIndiv != null) {
            indivs = dao.getIndividuals(selectedIndiv.getClassName());
            System.out.println("PRINTING INDIVIDUALS OF A GIVEN CLASS **********");
            for (IndividualItem indiv : indivs) {
                System.out.println(indiv.toString());
            }
            System.out.println("INDIVIDUALS OF A GIVEN CLASS PRINTED **********");
            System.out.println();
            System.out.println();
            System.out.println();

            List<PropertyValueItem> vals = dao.getIndividualAttributes(selectedIndiv.getOriginalName());
            System.out.println("PRINTING PROPERTIES OF A GIVEN INDIVIDUAL **********");
            for (PropertyValueItem val : vals) {
                System.out.println(val.toString());
            }
            System.out.println("PROPERTIES OF A GIVEN INDIVIDUAL PRINTED **********");
            System.out.println();
            System.out.println();
            System.out.println();
        }

        System.out.println("PRINTING DOMAINS **********");

        List<String> domains = dao.getDomains();
        for (String domain : domains) {
            System.out.println(domain);
        }

        System.out.println("DOMAINS PRINTED **********");
        System.out.println();
        System.out.println();
        System.out.println();
    }

    public static void runClassesTest(RepositoryDAO dao,
                                      String fileStep1, String fileStep2, String fileStep3, String fileStep4, String fileStep5)
            throws IOException, TransformerException {
        printOntology(dao, fileStep1);

        dao.createClass("MyTestSubClass", "Liquid");
        printOntology(dao, fileStep2);

        try {
            dao.createClass("MyTestSubClass", "MoldedPart");
            System.out.println("TEST #1 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createClass("Rejected", "NonExisting");
            System.out.println("TEST #2 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createClass("msee:Rejected", "Liquid");
            System.out.println("TEST #3 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createClass(dao.getImplicitNamespace() + "Rejected", "Liquid");
            System.out.println("TEST #4 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createClass("", "Liquid");
            System.out.println("TEST #5 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createClass("&ABC", "Liquid");
            System.out.println("TEST #6 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.renameClass("MyTestSubClass", "MyTestSubClass2");
        printOntology(dao, fileStep3);

        dao.moveClass("MyTestSubClass2", "MoldedPart");
        printOntology(dao, fileStep4);

        dao.deleteClass("MyTestSubClass2");
        printOntology(dao, fileStep5);

        try {
            dao.deleteClass("Weaving");
            System.out.println("TEST #7 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.deleteClass("http://www.msee-ip.eu/ontology/system#ResourceDomain");
            System.out.println("TEST #8 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public static void runIndividualsTest1(RepositoryDAO dao,
                                           String fileStep1, String fileStep2, String fileStep3, String fileStep4, String fileStep5)
            throws IOException, TransformerException {
        printOntology(dao, fileStep1);

        dao.createDomain("MyDomain");
        printOntology(dao, fileStep2);

        try {
            dao.createDomain("MyDomain");
            System.out.println("TEST #1 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createDomain("%Rejected");
            System.out.println("TEST #2 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createDomain("http://www.msee-ip.eu/ontology/system#Rejected");
            System.out.println("TEST #3 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createDomain("msee:Rejected");
            System.out.println("TEST #4 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.createClass("MyTestSubClass", "Liquid");
        dao.createClass("MyTestSubSubClass", "MyTestSubClass");
        dao.createAssetModel("MyAssetModel1", "MyTestSubSubClass", "MyDomain");
        printOntology(dao, fileStep3);

        try {
            dao.deleteClass("MyTestSubSubClass");
            System.out.println("TEST #5 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.deleteDomain("MyDomain");
            System.out.println("TEST #6 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.renameClass("MyTestSubClass", "MyTestSubClass1");
        dao.renameClass("MyTestSubSubClass", "MyTestSubSubClass1");
        printOntology(dao, fileStep4);

        try {
            dao.deleteClass("MyTestSubSubClass1");
            System.out.println("TEST #7 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.deleteIndividual("MyAssetModel1");
        dao.deleteClass("MyTestSubSubClass1");
        dao.deleteClass("MyTestSubClass1");
        dao.deleteDomain("MyDomain");
        printOntology(dao, fileStep5);
    }

    public static void runIndividualsTest2(RepositoryDAO dao,
                                           String fileStep1, String fileStep2, String fileStep3, String fileStep4, String fileStep5, String fileStep6)
            throws IOException, TransformerException {
        printOntology(dao, fileStep1);

        dao.createAssetModel("MyAssetModel1", "Cutting", null);
        printOntology(dao, fileStep2);

        try {
            dao.createAssetModel("MyAssetModel1", "Cutting", null);
            System.out.println("TEST #1 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createAssetModel("%Rejected", "Cutting", null);
            System.out.println("TEST #2 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createAssetModel(dao.getImplicitNamespace() + "Rejected", "Cutting", null);
            System.out.println("TEST #3 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createAssetModel(dao.getImplicitNamespace() + "Rejected", "Cutting", null);
            System.out.println("TEST #4 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createAssetModel("Rejected", "NonExistent", null);
            System.out.println("TEST #5 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createAssetModel("Rejected", "http://www.msee-ip.eu/ontology/system#ResourceDomain", null);
            System.out.println("TEST #6 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.createAssetModel("Rejected", "Cutting", "NonExistent");
            System.out.println("TEST #7 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.setAttribute("Description", "MyAssetModel1", "MyAssetModel1 long textual description");
        dao.setAttribute("MyNewStringProperty", "MyAssetModel1", "ABC");
        dao.setAttribute("MyNewIntegerProperty", "MyAssetModel1", "123", Integer.class);
        dao.setAttribute("MyNewBooleanProperty", "MyAssetModel1", "true", Boolean.class);
        dao.setAttribute("MyNewDateProperty", "MyAssetModel1", Util.getDateTimeRepresentation(new GregorianCalendar()), Calendar.class);
        printOntology(dao, fileStep3);

        try {
            dao.setAttribute("MyRejectedProperty", "MyAssetModel1", "ABC", Integer.class);
            System.out.println("TEST #8 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.setAttribute("MyRejectedProperty", "MyAssetModel1", "ABC", Boolean.class);
            System.out.println("TEST #9 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.setAttribute("#%&MyRejectedProperty", "MyAssetModel1", "ABC");
            System.out.println("TEST #10 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.setAttribute("MyRejectedProperty", "NonExistent", "ABC");
            System.out.println("TEST #11 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.setAttribute("http://www.msee-ip.eu/ontology/system#createdOn", "MyAssetModel1", "ABC");
            System.out.println("TEST #12 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.setAttribute("Description", "MyAssetModel1", "MyAssetModel1 long textual description, modified");
        dao.setAttribute("MyNewStringProperty", "MyAssetModel1", "EFG", Calendar.class); // type should be ignored
        dao.setAttribute("MyNewIntegerProperty", "MyAssetModel1", "456", Calendar.class); // type should be ignored
        dao.setAttribute("MyNewBooleanProperty", "MyAssetModel1", "false");
        dao.setAttribute("MyNewDateProperty", "MyAssetModel1", null);
        printOntology(dao, fileStep4);

        try {
            dao.removeProperty("Description", "NonExistent");
            System.out.println("TEST #13 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.removeProperty("createdOn", "NonExistent");
            System.out.println("TEST #14 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.removeProperty("Description", "MyAssetModel1");
        dao.removeProperty("MyNewStringProperty", "MyAssetModel1");
        dao.removeProperty("MyNewIntegerProperty", "MyAssetModel1");
        dao.removeProperty("MyNewBooleanProperty", "MyAssetModel1");
        dao.removeProperty("MyNewDateProperty", "MyAssetModel1");
        printOntology(dao, fileStep5);

        try {
            dao.removeProperty("Description", "MyAssetModel1");
            System.out.println("TEST #15 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.removeProperty("MyNewStringProperty", "MyAssetModel1");
            System.out.println("TEST #16 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.removeProperty("http://www.msee-ip.eu/ontology/system#createdOn", "MyAssetModel1");
            System.out.println("TEST #17 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.removeProperty("createdOn", "MyAssetModel1");
            System.out.println("TEST #18 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.setAttribute("Description", "MyAssetModel1", "MyAssetModel1 long textual description");
        dao.setAttribute("MyNewStringProperty", "MyAssetModel1", "ABC");
        dao.setAttribute("MyNewIntegerProperty", "MyAssetModel1", "123", Integer.class);
        dao.setAttribute("MyNewBooleanProperty", "MyAssetModel1", "true", Boolean.class);
        dao.setAttribute("MyNewDateProperty", "MyAssetModel1", Util.getDateTimeRepresentation(new GregorianCalendar()), Calendar.class);
        dao.deleteIndividual("MyAssetModel1");
        printOntology(dao, fileStep6);
    }


    public static void runIndividualsTest3(RepositoryDAO dao,
                                           String fileStep1, String fileStep2, String fileStep3, String fileStep4, String fileStep5)
            throws IOException, TransformerException {
        printOntology(dao, fileStep1);

        dao.createClass("SubCutting", "Cutting");
        dao.createAssetModel("MyAssetModel1", "SubCutting", null);
        dao.setAttribute("Description", "MyAssetModel1", "MyAssetModel1 long textual description");
        dao.setAttribute("MyNewStringProperty", "MyAssetModel1", "ABC");
        dao.setAttribute("MyNewIntegerProperty", "MyAssetModel1", "123", Integer.class);
        dao.setAttribute("MyNewBooleanProperty", "MyAssetModel1", "true", Boolean.class);
        dao.setAttribute("MyNewDateProperty", "MyAssetModel1", Util.getDateTimeRepresentation(new GregorianCalendar()), Calendar.class);

        dao.createAsset("MyAsset1", "MyAssetModel1", "Bivolino");
        printOntology(dao, fileStep2);

        dao.renameClass("SubCutting", "SubCutting2");
        dao.setAttribute("Description", "MyAsset1", "MyAsset1 long textual description");
        dao.setAttribute("MyNewStringProperty", "MyAsset1", "EFG");
        dao.setAttribute("MyVeryNewStringProperty", "MyAsset1", "HIJ");
        dao.setAttribute("MyNewIntegerProperty", "MyAsset1", "456");
        dao.setAttribute("MyNewBooleanProperty", "MyAsset1", "false");
        dao.setAttribute("MyNewDateProperty", "MyAsset1", null);
        printOntology(dao, fileStep3);

        dao.setAttribute("Description", "MyAssetModel1", null);
        dao.setAttribute("MyNewStringProperty", "MyAssetModel1", null);
        dao.removeProperty("MyNewIntegerProperty", "MyAssetModel1");
        dao.setAttribute("MyVeryNewIntegerProperty", "MyAssetModel1", null, Integer.class);
        dao.setAttribute("MyNewBooleanProperty", "MyAssetModel1", null);
        dao.setAttribute("MyNewDateProperty", "MyAssetModel1", null);
        dao.setRelationship("MyNewRelationship", "MyAssetModel1", null);

        dao.createAsset("MyAsset2", "MyAssetModel1", null);
        dao.setRelationship("MyNewRelationship", "MyAsset2", "Cutting_1");
        printOntology(dao, fileStep4);

        try {
            dao.deleteIndividual("MyAssetModel1");
            System.out.println("TEST #1 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.setRelationship("MyNewRelationship", "MyAsset2", "NonExisting");
            System.out.println("TEST #2 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        try {
            dao.setRelationship("MyNewRelationship", "NonExisting", "Cutting_1");
            System.out.println("TEST #3 FAILED!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        dao.deleteIndividual("MyAsset2");
        dao.deleteIndividual("MyAsset1");
        dao.deleteIndividual("MyAssetModel1");
        dao.deleteClass("SubCutting2");
        printOntology(dao, fileStep5);
    }

    /**
     * author ascatox
     * Created at 2016-09-20
     */
    public static void testGetAttributes(RepositoryDAO dao) {
        List<PropertyDeclarationItem> attributes = dao.getAttributes();
        if (attributes == null || attributes.isEmpty())
            System.out.println("Attributes result is Empty");
        else {
            for (PropertyDeclarationItem attrItem :
                    attributes) {
                System.out.println(attrItem.toString());
            }
        }

    }

    private static void printOntology(RepositoryDAO dao, String outFile)
            throws IOException, TransformerException {
        OutputStream os = new FileOutputStream(outFile);
        Document doc = dao.readOntology();
        printDocument(doc, os);
        os.close();
    }

    private static void printDocument(Document doc, OutputStream out)
            throws IOException, TransformerException {
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer transformer = tf.newTransformer();
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
        transformer.setOutputProperty(OutputKeys.METHOD, "xml");
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
        transformer.transform(new DOMSource(doc), new StreamResult(new OutputStreamWriter(out, "UTF-8")));
    }
}