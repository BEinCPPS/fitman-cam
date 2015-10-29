package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.*;
import msee.sp3.cm.api.resources.SearchByCriteria;
import msee.sp3.cm.beans.IFiwareMarketplaceBean;
import msee.sp3.cm.beans.IUserBean;
import msee.sp3.cm.domain.FiwareMarketplace;
import msee.sp3.cm.domain.ServiceProvider;
import msee.sp3.cm.domain.TrustedMarketplace;
import msee.sp3.cm.fiware.marketplaceri.client.StatefulMarketplaceClient;
import msee.sp3.cm.fiware.marketplaceri.client.exception.AuthenticationException;
import org.dozer.DozerBeanMapper;
import org.fiware.apps.marketplace.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.ws.rs.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Federated invocations to backend FI-WARE Marketplaces
 */
@Service("federationApi")
@Path("/fed")
public class FederationApi {

    private Logger logger = LoggerFactory.getLogger(FederationApi.class);

    @Resource
    private DozerBeanMapper mapper;

    @Resource
    private IUserBean userBean;

    @Resource(name = "fiwareMarketplaceBean")
    private IFiwareMarketplaceBean fiwareBean;

    /**
     *
     * @return a list of all Offering resources available on all of the user's trusted marketplaces.
     */
    @GET
    @Path("/{username}/offerings/all")
    public List<OfferingResource> listOfferings(@PathParam("username") String username) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        List<OfferingResource> toReturn = new ArrayList<OfferingResource>();
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    List<ServiceManifestation> allOfferings = smc.getAllServices();
                    if (allOfferings != null) {
                        for (ServiceManifestation sm : allOfferings) {
                            OfferingResource or = new OfferingResource();
                            mapper.map(sm, or);
                            or.setMarketplaceName(tm.getFiwareMarketplace().getName());
                            toReturn.add(or);
                        }
                    }
                }
            }
        }
        return toReturn;
    }

    /**
     *
     * @return a list of all Offering resources available on all of the user's trusted marketplaces.
     */
//    @GET
//    @Path("/{username}/offerings/{marketplace}")
//    public List<OfferingResource> listOfferingsOfMarketplace(@PathParam("username") String username,
//                                                             @PathParam("marketplace") String marketplace) {
//
//
//    }

    @GET
    @Path("/{username}/search/{searchTerm}")
    public List<SearchResultEntryResource> search(@PathParam("username") String username, @PathParam("searchTerm") String searchTerm) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        List<SearchResultEntryResource> toReturn = new ArrayList<SearchResultEntryResource>();
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    List<SearchResultEntry> searchResultEntries = smc.search(searchTerm);
                    if (searchResultEntries != null) {
                        for (SearchResultEntry sre : searchResultEntries) {
                            SearchResultEntryResource srer = new SearchResultEntryResource();
                            mapper.map(sre, srer);
                            FiwareMarketplaceResource fmr = new FiwareMarketplaceResource();
                            mapper.map(tm.getFiwareMarketplace(), fmr);
                            srer.setMarketplaceResource(fmr);
                            toReturn.add(srer);
                        }
                    }
                }
            }
        }
        return toReturn;
    }

    @GET
     @Path("/search/{searchTerm}")
     public List<SearchResultEntryResource> searchInAllMarketplaces(@PathParam("searchTerm") String searchTerm) {
        List<FiwareMarketplace> marketplaces = fiwareBean.getFiwareMarketplaces(0, -1);
        List<SearchResultEntryResource> toReturn = new ArrayList<SearchResultEntryResource>();
        if ((marketplaces != null) && (!marketplaces.isEmpty())) {
            for (FiwareMarketplace tm : marketplaces) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm, null, null);
                if (smc != null) {
                    List<SearchResultEntry> searchResultEntries = smc.search(searchTerm);
                    if (searchResultEntries != null) {
                        for (SearchResultEntry sre : searchResultEntries) {
                            SearchResultEntryResource srer = new SearchResultEntryResource();
                            mapper.map(sre, srer);
                            FiwareMarketplaceResource fmr = new FiwareMarketplaceResource();
                            mapper.map(tm, fmr);
                            srer.setMarketplaceResource(fmr);
                            toReturn.add(srer);
                        }
                    }
                }
            }
        }
        return toReturn;
    }

    @POST
    @Path("/search/criteria")
    public List<OfferingResource> searchByCriteriaInAllMarketplaces(SearchByCriteria searchCriteria) {
        List<FiwareMarketplace> marketplaces = fiwareBean.getFiwareMarketplaces(0, -1);
        List<OfferingResource> toReturn = new ArrayList<OfferingResource>();
        org.fiware.apps.marketplace.model.SearchByCriteria criteria = new org.fiware.apps.marketplace.model.SearchByCriteria();
        mapper.map(searchCriteria, criteria);
        if ((marketplaces != null) && (!marketplaces.isEmpty())) {
            for (FiwareMarketplace tm : marketplaces) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm, null, null);
                if (smc != null) {
                    SearchResultOffering searchResult = smc.findOfferingsByCriteria(criteria);
                    if (searchResult != null && searchResult.getOffering() != null && !searchResult.getOffering().isEmpty()) {
                        for (ServiceOffering offering : searchResult.getOffering()) {
                            OfferingResource offeringResource = new OfferingResource();
                            mapper.map(offering, offeringResource);
                            offeringResource.setMarketplaceName(tm.getName());
                            toReturn.add(offeringResource);
                        }
                    }
                }
            }
        }
        return toReturn;
    }

    /**
     * List all stores for a user. We obtain the list of trusted marketplaces and then list each marketplace's stores.
     * @return
     */
    @GET
    @Path("/{username}/allstores/")
    public List<StoreResource> listAllStores(@PathParam("username") String username) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        List<StoreResource> toReturn = new ArrayList<StoreResource>();
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    List<Store> fiStores = smc.findStores();
                    if (fiStores != null) {
                        for (Store s : fiStores) {
                            StoreResource sr = new StoreResource();
                            mapper.map(s, sr);
                            sr.setMarketplace(tm.getFiwareMarketplace().getName());
                            toReturn.add(sr);
                        }
                    }
                }
            }
        }
        return toReturn;
    }

    /**
     * List all stores for a user. We obtain the list of trusted marketplaces and then list each marketplace's stores.
     * @return
     */
    @GET
    @Path("/{username}/mystores")
    public List<StoreResource> listMyStores(@PathParam("username") String username) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        List<StoreResource> toReturn = new ArrayList<StoreResource>();
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    List<Store> fiStores = smc.findStores();
                    if (fiStores != null) {
                        for (Store s : fiStores) {
                            if (s.getCreator().getUsername().equals(username)) {
                                StoreResource sr = new StoreResource();
                                mapper.map(s, sr);
                                sr.setMarketplace(tm.getFiwareMarketplace().getName());
                                toReturn.add(sr);
                            }
                        }
                    }
                }
            }
        }
        return toReturn;
    }

    @PUT
    @Path("/{username}/stores/{storename}")
    @Consumes({"application/json", "application/xml"})
    public void createNewStore(@PathParam("username") String username, @PathParam("storename") String storeName, StoreResource store) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    Store fiStore = new Store();
                    mapper.map(store, fiStore);
                    smc.saveStore(fiStore);
                }
            }
        }
    }

    @POST
    @Path("/{username}/stores/{storename}")
    @Consumes({"application/json", "application/xml"})
    public void updateStore(@PathParam("username") String username, @PathParam("storename") String storeName, StoreResource store) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    Store fiStore = new Store();
                    mapper.map(store, fiStore);
                    smc.updateStore(storeName, fiStore);
                }
            }
        }
    }

    @DELETE
    @Path("/{username}/stores/{storename}")
    public void deleteStore(@PathParam("username") String username, @PathParam("storename") String storeName) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    smc.deleteStore(storeName);
                }
            }
        }
    }

    @GET
    @Path("/{username}/stores/{storename}/allservices")
    @Produces({"application/json", "application/xml"})
    public List<ServiceResource> listServices(@PathParam("username") String username, @PathParam("storename") String storeName) {
        List<ServiceResource> services = new ArrayList<ServiceResource>();
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    List<org.fiware.apps.marketplace.model.Service> storeServices = smc.findServices(storeName);
                    for (org.fiware.apps.marketplace.model.Service s : storeServices) {
                        ServiceResource sr = new ServiceResource();
                        mapper.map(s, sr);
                        sr.setMarketplaceName(tm.getFiwareMarketplace().getName());
                        sr.setStoreName(storeName);
                        services.add(sr);
                    }
                }
            }
        }
        return services;
    }

    @GET
    @Path("/{username}/stores/{storename}/service/{servicename}")
    @Produces({"application/json", "application/xml"})
    @Deprecated
    public ServiceResource getService(@PathParam("username") String username, @PathParam("storename") String storeName,
                              @PathParam("servicename") String serviceName) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    org.fiware.apps.marketplace.model.Service svc = smc.findService(storeName, serviceName);
                    ServiceResource sr = new ServiceResource();
                    mapper.map(svc, sr);
                    return sr;
                }
            }
        }
        return null;
    }

    @GET
    @Path("/marketplaces/{marketplaceName}/stores/{storename}/service/{servicename}")
    @Produces({"application/json", "application/xml"})
    public List<OfferingResource> getServiceOfferings(@PathParam("marketplaceName") String marketplaceName,
                                      @PathParam("storename") String storeName,
                                      @PathParam("servicename") String serviceName) {
        List<OfferingResource> toReturn = new ArrayList<OfferingResource>();
        FiwareMarketplace fm = fiwareBean.getFiwareMarketplace(marketplaceName);
        StatefulMarketplaceClient smc = obtainMarketplaceClient(fm, null, null);
        if (smc != null) {
            org.fiware.apps.marketplace.model.Service svc = smc.findService(storeName, serviceName);
            for (ServiceOffering so : svc.getOfferings()) {
                OfferingResource or = new OfferingResource();
                mapper.map(so, or);
                or.setMarketplaceName(fm.getName());
                toReturn.add(or);
            }
        }
        return toReturn;
    }

    @PUT
    @Path("/{username}/stores/{storename}/service/{servicename}")
    @Consumes({"application/json", "application/xml"})
    public void createService(@PathParam("username") String username, @PathParam("storename") String storeName,
                              @PathParam("servicename") String serviceName, ServiceResource service) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    org.fiware.apps.marketplace.model.Service svc = new org.fiware.apps.marketplace.model.Service();
                    mapper.map(service, svc);
                    logger.info("Service to be registered: {}", svc);
                    try {
                        smc.saveService(storeName, svc);
                    }
                    catch (Exception e) {
                        logger.error("Failed saving service {} to marketplace {}", service.getName());
                    }
                }
            }
        }
        else {
            logger.warn("Could not create service {} for creator {}, no trusted marketplaces defined.");
        }
    }

    @POST
    @Path("/{username}/stores/{storename}/service/{servicename}")
    @Consumes({"application/json", "application/xml"})
    public void updateService(@PathParam("username") String username, @PathParam("storename") String storeName,
                              @PathParam("servicename") String serviceName, ServiceResource service) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    org.fiware.apps.marketplace.model.Service svc = new org.fiware.apps.marketplace.model.Service();
                    mapper.map(service, svc);
                    logger.info("Service {} to be update to {}", serviceName, svc);
                    smc.updateService(storeName, serviceName, svc);
                }
            }
        }
    }

    @DELETE
    @Path("/{username}/stores/{storename}/service/{servicename}")
    public void deleteService(@PathParam("username") String username, @PathParam("storename") String storeName,
                              @PathParam("servicename") String serviceName) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if ((sp.getTrustedMarketplaces() != null) && (!sp.getTrustedMarketplaces().isEmpty())) {
            for (TrustedMarketplace tm : sp.getTrustedMarketplaces()) {
                StatefulMarketplaceClient smc = obtainMarketplaceClient(tm.getFiwareMarketplace(), username, sp.getPasswordHash());
                if (smc != null) {
                    smc.deleteService(storeName, serviceName);
                }
            }
        }
    }

    /**
     * helper method to obtain a configured, ready-to-use instance of fiware marketplace client
     */
    private StatefulMarketplaceClient obtainMarketplaceClient(FiwareMarketplace fiMarketplace, String username, String password) {
        StatefulMarketplaceClient smc = new StatefulMarketplaceClient();
        if (username == null) {
            try {
                smc.startSessionWithBuiltinPrincipal(fiMarketplace.getUrl());
            } catch (AuthenticationException e) {
                logger.error("Failed to authenticate with marketplace at " + fiMarketplace.getUrl(), e);
                return null;
            }
        }
        else {
            try {
                smc.startSession(fiMarketplace.getUrl(), username, password);
            } catch (AuthenticationException e) {
                logger.error(String.format("Failed to authenticate as %s with marketplace at %s", username,
                        fiMarketplace.getUrl()), e);
                return null;
            }
        }
        return smc;
    }
}
