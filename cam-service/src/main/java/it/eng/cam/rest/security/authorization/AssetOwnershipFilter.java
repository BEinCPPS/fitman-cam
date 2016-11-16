package it.eng.cam.rest.security.authorization;

import it.eng.cam.rest.security.authentication.CAMPrincipal;
import it.eng.ontorepo.Asset;

import javax.ws.rs.core.SecurityContext;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 09/11/2016.
 */
public class AssetOwnershipFilter {


    public static List<Asset> filterAll(List<Asset> assets, SecurityContext securityContext) {
        if (assets == null || assets.isEmpty() || securityContext == null) return assets;
        List<Asset> assetsToGive = new ArrayList<>();
        assets.stream().forEach(asset -> {
                assetsToGive.add(filter(asset, securityContext));
        });
        return assetsToGive;
    }

    public static Asset filter(Asset asset, SecurityContext securityContext) {
        if (asset == null || securityContext == null) return null;
        CAMPrincipal principal = (CAMPrincipal) securityContext.getUserPrincipal();
        if (principal.isAdmin()) return asset;
        for (CAMPrincipal.Organization organization :
                principal.getOrganizations()) {
            if (organization.getName().equals(asset.getDomain()))
                return asset;
        }
        return null;
    }


}
