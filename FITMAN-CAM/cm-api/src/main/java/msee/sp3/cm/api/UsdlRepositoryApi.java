/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package msee.sp3.cm.api;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.*;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import msee.sp3.cm.api.resources.UsdlRepositoriesResource;
import msee.sp3.cm.api.resources.UsdlRepositoryResource;
import msee.sp3.cm.beans.IUsdlRepositoryBean;
import msee.sp3.cm.domain.UsdlRepository;
import org.apache.commons.lang.StringUtils;
import org.dozer.DozerBeanMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 *
 * @author Singular
 */
@Service("usdlRepositoryApi")
@Path("/usdlrepositories")
public class UsdlRepositoryApi {
    private Logger logger = LoggerFactory.getLogger(UsdlRepositoryApi.class);
    
    @Resource
    private IUsdlRepositoryBean usdlRepositoryBean;
    
    @Resource
    private DozerBeanMapper mapper;
    
    @GET
    @Path("/{name}")
    @Produces({"application/json", "application/xml"})
    public Response getUsdlRepositoryByName(@PathParam("name") String usdlRepositoryName) {
        UsdlRepository ur = usdlRepositoryBean.getUsdlRepository(usdlRepositoryName);
        if (ur != null) {
            return Response.ok(mapper.map(ur, UsdlRepositoryResource.class)).build();
        }
        else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }
    
    @PUT
    @Path("/{name}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response createUsdlRepository(@PathParam("name") String name, UsdlRepositoryResource usdlRepository) {

        if ((StringUtils.isBlank(name)) || (usdlRepository == null) || (StringUtils.isBlank(usdlRepository.getName())) ||
                (StringUtils.isBlank(usdlRepository.getUrl())) || (!name.equals(usdlRepository.getName()))) {
            return Response.status(Response.Status.BAD_REQUEST).entity("Invalid input: usdl repository names " +
                    "must not be empty and match between URL and body; url must not be empty.").build();
        }

        try {
            usdlRepositoryBean.createUsdlRepository(name, usdlRepository.getUrl());
        }
        catch (Exception e) {
            logger.error(String.format("Could not create usdl repository with name %s", name), e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.CREATED).build();
    }

    @POST
    @Path("/{name}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response updateUsdlRepositoryByName(@PathParam("name") String name, UsdlRepositoryResource usdlRepository) {
        try {
            usdlRepositoryBean.updateUsdlRepository(name, usdlRepository.getName(), usdlRepository.getUrl());
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        return Response.status(Response.Status.FOUND).build();
    }

    @DELETE
    @Path("/{name}")
    public Response deleteUsdlRepositoryByName(@PathParam("name") String name) {
        try {
            usdlRepositoryBean.deleteUsdlRepository(name);
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        return Response.status(Response.Status.FOUND).build();
    }

    /**
     * Paged request for usdl repositories
     * @param from
     * @param to
     * @return
     */
    @GET
    @Produces({"application/json", "application/xml"})
    public UsdlRepositoriesResource getUsdlRepositories(@QueryParam("from") int from, @QueryParam("to") int to) {

        UsdlRepositoriesResource response = new UsdlRepositoriesResource();

        List<UsdlRepository> usdlRepositories;

        if ((from == to) && (to == 0)) {
            usdlRepositories = usdlRepositoryBean.getUsdlRepositories(0, -1);
        }
        else {
            usdlRepositories = usdlRepositoryBean.getUsdlRepositories(from, to);
        }
        if (usdlRepositories != null) {
            List<UsdlRepositoryResource> urr = new ArrayList<UsdlRepositoryResource>(usdlRepositories.size());
            for (UsdlRepository ur : usdlRepositories) {
                urr.add(mapper.map(ur, UsdlRepositoryResource.class));
            }
            response.setUsdlRepositories(urr);
        }

        int totalNumUsdlRepositories = usdlRepositoryBean.countUsdlRepositories();
        response.setTotalNumberUsdlRepositories(totalNumUsdlRepositories);

        return response;
    }

    @PUT
    @Path("/{name}/usdl/{usdlId}")
    public Response uploadUsdl(@PathParam("name") String repositoryName, @PathParam("usdlId") String usdlId, String usdl) {
        String url = "";
        try {
            url = usdlRepositoryBean.uploadUsdlToRepository(repositoryName, usdlId, usdl);
        }
        catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST).entity(e.getMessage()).build();
        }
        catch (RuntimeException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
        }
        return Response.ok(url).build();
    }
}
