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
		return buildBreadCrumb(whereIam, null);
	}

	public static Label getAssetDetailBreadCrumb(String whereIam, String assetName) {
		return buildBreadCrumb(whereIam, assetName);
	}

	
	
	private static Label buildBreadCrumb(String whereIam, String assetName) {
		Label label = null;
		
			if (whereIam.equals(ConstantsView.Views.assetRepositoryView.name()))
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS + "'><em>Repository</em></div>",
						ContentMode.HTML);
			else if (whereIam.equals(ConstantsView.Views.assetDetailView.name())) {
				if (assetName == null || assetName.isEmpty()) assetName="Asset Detail";
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS + "'><a href=''>Repository</a><span>&gt;</span><em> "+assetName+" </em></div>", ContentMode.HTML);

			} else if (whereIam.equals(ConstantsView.Views.localServiceView.name())) {
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS
						+ "'><a href=''>Repository</a><span>&gt;</span><a href='#!/"
						+ ConstantsView.Views.assetDetailView.name()
						+ "'> Asset Detail</a><span>&gt;</span><em>Local Service</em></div>", ContentMode.HTML);
				
			} else if (whereIam.equals(ConstantsView.Views.publicServiceView.name())) {
				label = new Label("<div id='" + ConstantsView.BREADCRUMB_CSS
						+ "'><a href=''>Repository</a><span>&gt;</span><a href='#!/"
						+ ConstantsView.Views.assetDetailView.name()
						+ "'> Asset Detail</a><span>&gt;</span><em>Public Service</em></div>", ContentMode.HTML);
			}
		

		return label;
	}

}
