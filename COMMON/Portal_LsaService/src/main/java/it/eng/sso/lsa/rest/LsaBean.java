package it.eng.sso.lsa.rest;

import it.eng.liferay.cas.integration.AttributeNames;
import it.eng.liferay.cas.integration.LiferayOrganization;
import it.eng.liferay.cas.integration.LiferayRole;
import it.eng.sso.lsa.Platform;
import it.eng.sso.lsa.Principal;
import it.eng.sso.lsa.SAMLUtil;
import it.eng.sso.lsa.components.IAuthenticator;
import it.eng.sso.lsa.components.UserNotAllowedException;
import it.eng.sso.lsa.components.UserNotFoundException;
import it.eng.sso.lsa.ver.beans.VirtualEnterprise;

import java.io.StringWriter;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

import org.apache.commons.lang.StringUtils;
import org.opensaml.saml2.core.Assertion;
import org.opensaml.saml2.core.Attribute;
import org.opensaml.saml2.core.AttributeStatement;
import org.opensaml.saml2.core.AttributeValue;
import org.opensaml.saml2.core.Issuer;
import org.opensaml.saml2.core.NameID;
import org.opensaml.saml2.core.Subject;
import org.opensaml.xml.io.MarshallingException;
import org.opensaml.xml.schema.XSString;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSOutput;
import org.w3c.dom.ls.LSSerializer;

/**
 * Created with IntelliJ IDEA.
 * User: ASCATOX
 * Date: 21/1/13
 * Time: 22:20
 * To change this template use File | Settings | File Templates.
 */
@Service("lsaBean")
public class LsaBean implements ILsaBean {

    private static Logger logger = LoggerFactory.getLogger(LsaBean.class);
    private Platform platform;
    
    
   //private static String QUALIFIER_SAML="MSEE"; 
   
    public void setPlatform(Platform platform) {
		this.platform = platform;
	}

	@Resource
    private IAuthenticator authenticator;

    /**
     * Issuer URL for SAML2 document returned by {@link #authenticate(String, String)}.
     */
    private String issuerUrl;

    @Override
    @GET
    @Path("/authenticate")
    @Produces("text/xml")
    public Response authenticate(@QueryParam("uid") String uid, @QueryParam("password") String password) {
        logger.debug("LsaBean.authenticate({}, {})", uid, password);

        // validate input
        if (StringUtils.isBlank(uid) || StringUtils.isBlank(password)) {
            return Response.status(Response.Status.BAD_REQUEST).build();
        }

        Principal authenticatedPrincipal = null;
        // check credentials
        try {
            authenticatedPrincipal = authenticator.authenticateUserInBackend(uid, password);
        }
        catch (UserNotFoundException unfe) {
            logger.info("User {} not found", uid);
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        catch (UserNotAllowedException unae) {
            logger.info("User {} not allowed to login", uid);
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        catch (Exception e) {
            logger.error("exception", e);
        }

        if (authenticatedPrincipal == null) {
            logger.info("User {} not found", uid);
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        try {
            Element e = createSAMLObject(authenticatedPrincipal);
            return Response.ok(serializeElement(e)).build();
        }
        catch (Exception e) {
            logger.error("Exception occured trying to create SAML object", e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
        }
    }




    // see https://wiki.shibboleth.net/confluence/display/OpenSAML/OSTwoUsrManJavaCreateFromScratch
    private Element createSAMLObject(Principal user) throws MarshallingException {


        // Create the assertion
        Assertion assertion = SAMLUtil.ASSERTION_BUILDER.buildObject(Assertion.DEFAULT_ELEMENT_NAME);

        // Set issuer
        assertion.setIssuer(SAMLUtil.ISSUER_BUILDER.buildObject(Issuer.DEFAULT_ELEMENT_NAME));
        assertion.getIssuer().setValue(issuerUrl);

        // Set subject
        assertion.setSubject(SAMLUtil.SUBJECT_BUILDER.buildObject(Subject.DEFAULT_ELEMENT_NAME));
        assertion.getSubject().setNameID(SAMLUtil.NAME_ID_BUILDER.buildObject(NameID.DEFAULT_ELEMENT_NAME));
        assertion.getSubject().getNameID().setValue(user.getUid());
        assertion.getSubject().getNameID().setNameQualifier(platform.getPrefix());

     
        //Name
        // map attributes within SAML Attribute Statement
        AttributeStatement attrStatement = SAMLUtil.ATTRIBUTE_STMT_BUILDER.buildObject(AttributeStatement.DEFAULT_ELEMENT_NAME);
        assertion.getAttributeStatements().add(attrStatement);
        
        for (Map.Entry<String, Object> principalAttribute : user.getAttributes().entrySet()) {
            addAttribute(attrStatement, principalAttribute);
        }
        
        Element e = SAMLUtil.MARSHALLER_FACTORY.getMarshaller(assertion).marshall(assertion);
        return e;

    }

    /**
     * Utility method that handles properly cases of single- or multi-valued principal attributes. Returns the instance
     * of attrStatement passed as parameter, to allow builder-pattern-style chaining.
     * @param attrStatement
     * @param principalAttribute
     * @return
     */
    private AttributeStatement addAttribute(AttributeStatement attrStatement, Map.Entry<String, Object> principalAttribute) {
        Attribute attribute = SAMLUtil.ATTRIBUTE_BUILDER.buildObject(Attribute.DEFAULT_ELEMENT_NAME);
        attribute.setName(principalAttribute.getKey());

        if (principalAttribute.getValue() instanceof List) {
            List listOfValues = (List)principalAttribute.getValue();
            for (Object o : listOfValues) {
                XSString value = (XSString) SAMLUtil.STRING_BUILDER.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSString.TYPE_NAME);
                if(o instanceof LiferayRole){
                	 value.setValue(((LiferayRole) o).getName());
                	 attribute.setName(AttributeNames.ROLE);
                }
                else if(o instanceof LiferayOrganization){
                	value.setValue(((LiferayOrganization) o).getName());
                	attribute.setName(platform.getPrefix()+AttributeNames.ORGANIZATION);
                }
                else if(o instanceof VirtualEnterprise){
                	value.setValue(((VirtualEnterprise) o).getName());
                	attribute.setName(platform.getPrefix()+AttributeNames.VIRTUAL_ENTERPRISE);
                }
                
                else 
                	value.setValue((String) o);
               
                attribute.getAttributeValues().add(value);
            }
            attrStatement.getAttributes().add(attribute);
        }
        else if (principalAttribute.getValue() instanceof String) {
            XSString value = (XSString) SAMLUtil.STRING_BUILDER.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSString.TYPE_NAME);
            value.setValue((String) principalAttribute.getValue());
            attribute.getAttributeValues().add(value);
            attrStatement.getAttributes().add(attribute);
        }
        return attrStatement;
    }

    /**
     * Serialize an {@link Element} to string
     * @return
     */
    private String serializeElement(Element e) {

        Document document = e.getOwnerDocument();
        DOMImplementationLS domImplLS = (DOMImplementationLS) document.getImplementation();
        LSSerializer serializer = domImplLS.createLSSerializer();
        serializer.getDomConfig().setParameter("format-pretty-print", true);

        LSOutput lsOutput = domImplLS.createLSOutput();
        lsOutput.setEncoding("UTF-8");
        Writer stringWriter = new StringWriter();
        lsOutput.setCharacterStream(stringWriter);
        serializer.write(e, lsOutput);

        String result = stringWriter.toString();
        return result;
    }


    public String getIssuerUrl() {
        return issuerUrl;
    }

    public void setIssuerUrl(String issuerUrl) {
        this.issuerUrl = issuerUrl;
    }
}
