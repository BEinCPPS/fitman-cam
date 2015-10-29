package it.eng.sso.lsa.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

/**
 * Created with IntelliJ IDEA.
 * User: bekiarisv
 * Date: 22/1/13
 * Time: 11:42
 * To change this template use File | Settings | File Templates.
 */
public interface ILsaBean {
    @GET
    @Path("/lsaservice")
    Response authenticate(@QueryParam("uid") String uid, @QueryParam("password") String password);
}
