package freemarker.core;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

/**
 * Utility class, located in freemarker.core package in order to access package-private freemarker classes.
 */
public abstract class FreemarkerUtil {

    private static final Logger logger = LoggerFactory.getLogger(FreemarkerUtil.class);

    public static List<String> getVariablesInTemplate(String template) {
        List<String> toReturn = new ArrayList<String>();
        try {
            Template t = new Template("temp", template, new Configuration());
            TemplateElement te = t.getRootTreeNode();
            Enumeration templateChildren = te.children();
            while (templateChildren.hasMoreElements()) {
                TemplateElement o = (TemplateElement) templateChildren.nextElement();
                if (o instanceof DollarVariable) {
                    DollarVariable var = (DollarVariable) o;
                    if (var.getParameterCount() == 1) {
                        Identifier identifier = (Identifier) var.getParameterValue(0);
                        toReturn.add(identifier.getCanonicalForm());
                    }
                }
            }
        }
        catch (IOException e) {
            return null;
        }

        return toReturn;
    }

    public static String processTemplate(String template, Map<String, String> variables) {
        String toReturn = null;
        try {
            Template t = new Template("temp", template, new Configuration());
            StringWriter sw = new StringWriter();
            t.process(variables, sw);
            toReturn = sw.toString();
        }
        catch (IOException e) {
            logger.error("IOException while reading template from String", e);
            return null;
        } catch (TemplateException e) {
            logger.error("Template exception",e);
        }

        return toReturn;
    }

}
