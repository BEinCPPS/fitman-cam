package it.eng.asset.view.vaadin;


import it.eng.asset.utils.UtilNavigation;

import javax.servlet.annotation.WebServlet;

import com.vaadin.annotations.Theme;
import com.vaadin.annotations.Title;
import com.vaadin.annotations.VaadinServletConfiguration;
import com.vaadin.navigator.Navigator;
import com.vaadin.server.VaadinRequest;
import com.vaadin.server.VaadinService;
import com.vaadin.server.VaadinServlet;
import com.vaadin.server.VaadinSession;
import com.vaadin.ui.Label;
import com.vaadin.ui.UI;
import com.vaadin.ui.VerticalLayout;

/* 
 * UI class is the starting point for your app. You may deploy it with VaadinServlet
 * or VaadinPortlet by giving your UI class name a parameter. When you browse to your
 * app a web page showing your UI is automatically generated. Or you may choose to 
 * embed your UI to an existing web page. 
 */
@Title("Asset Repository")
@Theme("reindeer")
public class AssetRepositoryUI extends UI {

	final Label nameC = new Label("Asset Class: -");
	
	public static VerticalLayout layout = null;
	
	@WebServlet(value = "/*", asyncSupported = true)
	@VaadinServletConfiguration(productionMode = false, ui = AssetRepositoryUI.class, widgetset = "com.vaadin.portal.gwt.PortalDefaultWidgetSet")
	public static class Servlet extends VaadinServlet {

	}


	String basepath = VaadinService.getCurrent().getBaseDirectory()
			.getAbsolutePath();

	public Navigator getNavigator() {
		if (VaadinSession.getCurrent().getAttribute("vam_nav_VAM") == null) {
			Navigator nav = new Navigator(this, layout);
			for (String route : UtilNavigation.routes.keySet()) {
				nav.addView(route, UtilNavigation.routes.get(route));
			}
			VaadinSession.getCurrent().setAttribute("vam_nav_VAM", nav);
			nav.navigateTo("");
		}
		return (Navigator) VaadinSession.getCurrent().getAttribute("vam_nav_VAM");
	}

	protected void init(VaadinRequest request) {
		
		layout = new VerticalLayout();
		setContent(layout);
	}

		public static ModelSession getModel() {
		if (VaadinSession.getCurrent().getAttribute("vam_modelSession_VAM")  == null) {
			ModelSession model = new ModelSession();
			VaadinSession.getCurrent().setAttribute("vam_modelSession_VAM", model);
		}
		return (ModelSession) VaadinSession.getCurrent().getAttribute("vam_modelSession_VAM");
	}
	

}