package it.eng.vam.rest.impl;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetClass;
import it.eng.asset.bean.AssetRest;
import it.eng.asset.bean.LocalService;
import it.eng.asset.bean.LocalServiceRest;
import it.eng.asset.bean.PublicService;
import it.eng.asset.bean.PublicServiceRest;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.vam.rest.api.IVAMResource;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.StreamingOutput;

public class VAMResourceImpl extends BaseResource implements IVAMResource {

	@Override
	public StreamingOutput getClasses() {

		VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
		final AssetClass asset_class = managerRepositoryService.getHierarchyClass();
		if (asset_class == null)
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		return new StreamingOutput() {

			@Override
			public void write(OutputStream os) throws IOException, WebApplicationException {

				writeObject(os, asset_class);

			}
		};

	}

	@Override
	public StreamingOutput getAssets(String class_name) {
		VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
		final List<Asset> lAss = managerRepositoryService.getAssetSelected(class_name);
		if (lAss == null)
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		return new StreamingOutput() {

			@Override
			public void write(OutputStream os) throws IOException, WebApplicationException {

				writeObject(os, lAss);

			}
		};
		
			 
	}

	@Override
	public StreamingOutput getAsset(String asset_name) {

		VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
		final AssetRest asset = managerRepositoryService.getAssetFromNameRest(asset_name);
		if (asset == null)
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		return new StreamingOutput() {

			@Override
			public void write(OutputStream os) throws IOException, WebApplicationException {

				writeObject(os, asset);

			}
		};

	}

	@Override
	public StreamingOutput GetPublicServices() {
		
		VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
		final List<PublicService> public_list;
		try {
			public_list = managerRepositoryService.getPublicList();
		} catch (Exception e) {
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		}
		if (public_list == null)
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		return new StreamingOutput() {

			@Override
			public void write(OutputStream os) throws IOException, WebApplicationException {

				writeObject(os, public_list);

			}
		};
	}

	@Override
	public StreamingOutput GetLocalServices() {
		
		VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
		final List<LocalService> local_list;
		try {
			local_list = managerRepositoryService.getLocalServiceList();
		} catch (Exception e) {
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		}
		if (local_list == null)
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		return new StreamingOutput() {

			@Override
			public void write(OutputStream os) throws IOException, WebApplicationException {

				writeObject(os, local_list);

			}
		};		
	}

	@Override
	public StreamingOutput GetPublicService(String public_service_name) {

		VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
		final PublicServiceRest public_service;
		try {
			public_service = managerRepositoryService.getPublicServiceRest(public_service_name);
		} catch (Exception e) {
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		}
		if (public_service == null)
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		return new StreamingOutput() {

			@Override
			public void write(OutputStream os) throws IOException, WebApplicationException {

				writeObject(os, public_service);

			}
		};		
	}

	@Override
	public StreamingOutput GetLocalService(String local_service_name) {
		
		VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
		final LocalServiceRest local_service;
		try {
			local_service = managerRepositoryService.getLocalServiceRest(local_service_name);
		} catch (Exception e) {
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		}
		if (local_service == null)
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		return new StreamingOutput() {

			@Override
			public void write(OutputStream os) throws IOException, WebApplicationException {

				writeObject(os, local_service);

			}
		};		
	}

	// @Override
	// public StreamingOutput getFact(String factId) {
	// PIFactService pifactService = new PIFactServiceImpl();
	// final PIFact fact = pifactService.getFact(factId);
	// if (fact == null)
	// throw new WebApplicationException(Response.Status.NOT_FOUND);
	// return new StreamingOutput() {
	//
	// @Override
	// public void write(OutputStream os) throws IOException,
	// WebApplicationException {
	//
	// writeObject(os, fact);
	//
	// }
	// };
	// }

}