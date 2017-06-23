package it.eng.cam.rest.orion;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.orion.context.ContextElement;
import it.eng.cam.rest.orion.context.ContextResponse;
import it.eng.ontorepo.OrionConfig;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Created by ascatox on 28/11/16.
 */
public class OrionRestClient {

    private static final Logger logger = LogManager.getLogger(OrionRestClient.class.getName());

    public static ContextResponse queryContext(OrionConfig config, String contextName) throws Exception {
        if (null == config || config.isEmpty())
            throw new IllegalArgumentException("Orion configuration is mandatory.");
        Client client = ClientBuilder.newClient();
        if (StringUtils.isBlank(contextName)) contextName = "";
        WebTarget webTarget = client.target(config.getUrl()).path("v1").path("contextEntities").path(contextName);
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        addServiceHeaders(config.getService(), config.getServicePath(), invocationBuilder);
        Response response = invocationBuilder.get();
        ContextResponse contextResponse = response.readEntity(ContextResponse.class);
        if (null == contextResponse
                || response.getStatus() != Response.Status.OK.getStatusCode()) {
            logger.error(response.getStatus());
            final String responseString = response.readEntity(String.class);
            if (responseString.toLowerCase().contains("error")) {
                logger.error(responseString);
                throw new Exception("Error getting data for asset from OCB with error: " + responseString);
            }
            return null;
        }
        return contextResponse;
    }

    public static ContextElement postContext(OrionConfig config,
                                             ContextElement context) throws Exception {
        if (null == context) return null;
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(config.getUrl()).path("v1").path("contextEntities");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        addServiceHeaders(config.getService(), config.getServicePath(), invocationBuilder);
        Response response = invocationBuilder.post(Entity.entity(context, MediaType.APPLICATION_JSON));
        if (null == response || response.getStatus() != Response.Status.OK.getStatusCode()) {
            logger.error(response.getStatus());
            throw new Exception("Error in linking asset to OCB with status: " + response.getStatus());
        } else {
            final String responseString = response.readEntity(String.class);
            if (responseString.toLowerCase().contains("error")) {
                logger.error(responseString);
                throw new Exception("Error in linking asset to OCB with error: " + responseString);
            }
        }
        return context;
    }

    private static void addServiceHeaders(String service, String subService, Invocation.Builder invocationBuilder) {
        if (StringUtils.isNotBlank(service))
            invocationBuilder.header(Constants.SERVICE_HEADER, service);
        else
            invocationBuilder.header(Constants.SERVICE_HEADER, Constants.DEFAULT_SERVICE);
        if (StringUtils.isNotBlank(subService))
            invocationBuilder.header(Constants.SUB_SERVICE_HEADER, subService);
        else
            invocationBuilder.header(Constants.SUB_SERVICE_HEADER, Constants.DEFAULT_SUB_SERVICE);
    }
}