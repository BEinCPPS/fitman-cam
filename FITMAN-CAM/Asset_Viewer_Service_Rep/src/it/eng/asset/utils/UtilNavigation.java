package it.eng.asset.utils;

import it.eng.asset.resources.ConstantsView;
import it.eng.asset.view.vaadin.AssetComposing;
import it.eng.asset.view.vaadin.AssetComposingUI;
import it.eng.asset.view.vaadin.AssetDetailEdit;
import it.eng.asset.view.vaadin.AssetRepository;
import it.eng.asset.view.vaadin.Detail;
import it.eng.asset.view.vaadin.ModelSession;
import it.eng.asset.view.vaadin.PublicServiceDetail;

import java.util.HashMap;

import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.View;

public  class UtilNavigation {
	
	public static final int MAX_NAME_SERVICE = 100;
	public static final int MAX_DESCRIPTION_SERVICE = 400;
	
	public static ModelSession getModel()
	{
		return AssetComposingUI.getModel();
	}
	
	public static Navigator getNavigator() {
		
		Navigator nav = null;
		AssetComposingUI ui = new AssetComposingUI();
		nav = ui.getNavigator();
		return nav;
	}

		

	public static HashMap<String, Class<? extends View>> routesAas = new HashMap<String, Class<? extends View>>() {
		{
			put("" , AssetComposing.class);
			put("/" +  ConstantsView.Views.assetRepositoryView.name(), AssetRepository.class); 
			put("/" + ConstantsView.Views.assetDetailView.name(), AssetDetailEdit.class);
//			put("/" + ConstantsView.Views.publicServiceView.name(), AssetComposingDetail.class);
			put("/" + ConstantsView.Views.publicServiceView.name(), PublicServiceDetail.class);
			put("/" + ConstantsView.Views.localServiceView.name(), Detail.class);
			
		}
	};
	
	
	
}
