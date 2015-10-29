package it.eng.sso.lsa;

import org.opensaml.Configuration;
import org.opensaml.DefaultBootstrap;
import org.opensaml.common.SAMLObjectBuilder;
import org.opensaml.saml2.core.*;
import org.opensaml.xml.ConfigurationException;
import org.opensaml.xml.XMLObjectBuilder;
import org.opensaml.xml.XMLObjectBuilderFactory;
import org.opensaml.xml.io.MarshallerFactory;
import org.opensaml.xml.schema.XSString;

/**
 * Created with IntelliJ IDEA.
 * User: bekiarisv
 * Date: 23/1/13
 * Time: 00:53
 * To change this template use File | Settings | File Templates.
 */
public class SAMLUtil {

    public static SAMLObjectBuilder<Assertion> ASSERTION_BUILDER;
    public static SAMLObjectBuilder<Issuer> ISSUER_BUILDER;
    public static SAMLObjectBuilder<Subject> SUBJECT_BUILDER;
    public static SAMLObjectBuilder<AttributeStatement> ATTRIBUTE_STMT_BUILDER;
    public static SAMLObjectBuilder<Attribute> ATTRIBUTE_BUILDER;
    public static SAMLObjectBuilder<NameID> NAME_ID_BUILDER;
    public static XMLObjectBuilder STRING_BUILDER;
    public static XMLObjectBuilderFactory builderFactory;
    // Marshaller
    public static MarshallerFactory MARSHALLER_FACTORY;


    static {
        try {
            DefaultBootstrap.bootstrap();
        } catch (ConfigurationException e) {
            e.printStackTrace();
        }
        // Get the builder factory
        builderFactory = Configuration.getBuilderFactory();

        // Setup builders
        ASSERTION_BUILDER = (SAMLObjectBuilder<Assertion>) builderFactory.getBuilder(Assertion.DEFAULT_ELEMENT_NAME);
        ISSUER_BUILDER = (SAMLObjectBuilder<Issuer>) builderFactory.getBuilder(Issuer.DEFAULT_ELEMENT_NAME);
        SUBJECT_BUILDER = (SAMLObjectBuilder<Subject>) builderFactory.getBuilder(Subject.DEFAULT_ELEMENT_NAME);
        ATTRIBUTE_STMT_BUILDER = (SAMLObjectBuilder<AttributeStatement>) builderFactory.getBuilder(AttributeStatement.DEFAULT_ELEMENT_NAME);
        ATTRIBUTE_BUILDER = (SAMLObjectBuilder<Attribute>) builderFactory.getBuilder(Attribute.DEFAULT_ELEMENT_NAME);
        NAME_ID_BUILDER = (SAMLObjectBuilder<NameID>) builderFactory.getBuilder(NameID.DEFAULT_ELEMENT_NAME);

        STRING_BUILDER = builderFactory.getBuilder(XSString.TYPE_NAME);
        
        // marshaller factory
        MARSHALLER_FACTORY = Configuration.getMarshallerFactory();
    }
}
