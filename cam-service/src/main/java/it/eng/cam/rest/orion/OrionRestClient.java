package it.eng.cam.rest.orion;

import it.eng.cam.rest.orion.context.ContextContainerJSON;
import it.eng.cam.rest.orion.context.ContextElement;
import it.eng.cam.rest.orion.context.ContextResponse;
import it.eng.cam.rest.Constants;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * Created by ascatox on 28/11/16.
 */
public class OrionRestClient {

    private static final Logger logger = LogManager.getLogger(OrionRestClient.class.getName());

    public static List<ContextResponse> getContexts(String service, String subService, String contextName) {
        Client client = ClientBuilder.newClient();
        if (null == contextName) contextName = "";
        WebTarget webTarget = client.target(Constants.ORION_API_URL).path("contextEntities").path(contextName);
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        addServiceHeaders(service, subService, invocationBuilder);
        Response response = invocationBuilder.get();
        ContextContainerJSON contextContainerJSON = response.readEntity(ContextContainerJSON.class);
        if (null == contextContainerJSON
                || null == contextContainerJSON.getContextResponses()
                || contextContainerJSON.getContextResponses().isEmpty()) {
            logger.error(response.getStatus());
            return null;
        }
        return contextContainerJSON.getContextResponses();
    }

    public static ContextElement createContext(ContextElement context) {
        return createContext(Constants.DEFAULT_SERVICE, Constants.DEFAULT_SUB_SERVICE, context);
    }

    public static ContextElement createContext(String service, String subService,
                                               ContextElement context) {
        if (null == context) return null;
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.ORION_API_URL).path("contextEntities");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        addServiceHeaders(service, subService, invocationBuilder);
        Response response = invocationBuilder.post(Entity.entity(context, MediaType.APPLICATION_JSON));
        if (null == response || response.getStatus() != Response.Status.OK.getStatusCode()) {
            logger.error(response.getStatus());
            return null;
        }
        return context;
    }

    private static void addServiceHeaders(String service, String subService, Invocation.Builder invocationBuilder) {
        if (StringUtils.isNotBlank(service))
            invocationBuilder.header(Constants.SERVICE_HEADER, service);
        if (StringUtils.isNotBlank(subService))
            invocationBuilder.header(Constants.SUBSERVICE_HEADER, subService);
    }

}
