package it.eng.asset.view.vaadin;

import it.eng.asset.resources.ConstantsView;

import com.vaadin.shared.ui.label.ContentMode;
import com.vaadin.ui.CustomComponent;
import com.vaadin.ui.Label;

public class BreadCrumb extends CustomComponent {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static Label getBreadCrumb(String whereIam) {
		return makeBreadCrumb(whereIam, null, null);
	}
	
	public static Label getAssetBreadCrumb(String whereIam, String assetName) {
		return makeBreadCrumb(whereIam, assetName, null);
	}

	public static Label getAssetServiceBreadCrumb(String whereIam, String assetName, String serviceName) {
		return makeBreadCrumb(whereIam, assetName, serviceName);
	}	
	
	private static Label makeBreadCrumb(String whereIam, String assetName, String serviceName ) {
		Label label = null;
		
			if (whereIam.equals(ConstantsView.Views.servicesView.name())){
				String val = assetName!=null? assetName:"Asset as a Service";
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS + "'><em>"+val+"</em></div>",
						ContentMode.HTML);
			}else if (whereIam.equals(ConstantsView.Views.assetDetailView.name())) {
				
				String val = assetName!=null? assetName:"Public Service";
				
				if (serviceName == null) serviceName = "Asset Detail";
			
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS
						+ "'><a href=''>Asset as a Service</a><span>&gt;</span><a href='#!/"
						+ ConstantsView.Views.publicServiceView.name()
						+ "'>"+val+"</a><span>&gt;</span><em>"+serviceName+"</em></div>", ContentMode.HTML);
				
				
			} else if (whereIam.equals(ConstantsView.Views.localServiceView.name())) {
				String val = assetName!=null? assetName:"Local Service";
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS + "'><a href=''>Asset as a Service</a><span>&gt;</span><em>"+val+"</em></div>", ContentMode.HTML);
				
			} else if (whereIam.equals(ConstantsView.Views.publicServiceView.name())) {
				String val = assetName!=null? assetName:"Public Service";
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS + "'><a href=''>Asset as a Service</a><span>&gt;</span><em> "+val+"</em></div>", ContentMode.HTML);
			}
		

		return label;
	}

}
