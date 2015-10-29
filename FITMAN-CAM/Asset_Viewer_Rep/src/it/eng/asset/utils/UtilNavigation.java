package it.eng.asset.utils;

import it.eng.asset.resources.ConstantsView;
import it.eng.asset.view.vaadin.AssetComposingDetail;
import it.eng.asset.view.vaadin.AssetDetailEdit;
import it.eng.asset.view.vaadin.AssetRepository;
import it.eng.asset.view.vaadin.AssetRepositoryUI;
import it.eng.asset.view.vaadin.Detail;
import it.eng.asset.view.vaadin.ModelSession;

import java.util.HashMap;

import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.View;

public  class UtilNavigation {
	
	public static final int MAX_NAME_SERVICE = 100;
	public static final int MAX_DESCRIPTION_SERVICE = 400;
	
	public static ModelSession getModel()
	{
			return AssetRepositoryUI.getModel();
	}
	
	public static Navigator getNavigator() {
		
			Navigator nav = null;
			AssetRepositoryUI repUI= new AssetRepositoryUI();
			nav = repUI.getNavigator();
			return nav;
	}

	
	public static HashMap<String, Class<? extends View>> routes = new HashMap<String, Class<? extends View>>() {
		{
			put("" , AssetRepository.class); 
			put("/" + ConstantsView.Views.assetDetailView.name(), AssetDetailEdit.class);
			put("/" + ConstantsView.Views.publicServiceView.name(), AssetComposingDetail.class);
			put("/" + ConstantsView.Views.localServiceView.name(), Detail.class);
			
		}
	};
	

	
}
