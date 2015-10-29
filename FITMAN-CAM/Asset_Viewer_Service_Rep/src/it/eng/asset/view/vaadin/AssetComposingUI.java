package it.eng.asset.view.vaadin;

import it.eng.asset.utils.UtilNavigation;

import com.jensjansson.pagedtable.PagedTable;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.User;
import com.vaadin.annotations.Theme;
import com.vaadin.annotations.Title;
import com.vaadin.navigator.Navigator;
import com.vaadin.server.VaadinRequest;
import com.vaadin.server.VaadinService;
import com.vaadin.server.VaadinSession;
import com.vaadin.ui.UI;
import com.vaadin.ui.VerticalLayout;

@Title("AssetComposing")
@Theme("reindeer")
public class AssetComposingUI extends UI {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4128343156851172445L;
	private PagedTable listComposingAssets = new PagedTable();
	private VerticalLayout externalPanel = new VerticalLayout();
	//private HorizontalLayout container = new HorizontalLayout();
	public static VerticalLayout layout = null;
	String basepath = VaadinService.getCurrent().getBaseDirectory().getAbsolutePath();



	
	public Navigator getNavigator() {
		if (VaadinSession.getCurrent().getAttribute("vam_nav_serv") == null) {
			Navigator nav = new Navigator(this, layout);
			for (String route : UtilNavigation.routesAas.keySet()) {
				nav.addView(route, UtilNavigation.routesAas.get(route));
			}
			VaadinSession.getCurrent().setAttribute("vam_nav_serv", nav);
			this.getNavigator().navigateTo("");

		}
		return (Navigator) VaadinSession.getCurrent().getAttribute("vam_nav_serv");
	}

	
	protected void init(VaadinRequest request) {

		layout = new VerticalLayout();
		setContent(layout);
		getModel().setLoggedInUser((User) request.getAttribute(WebKeys.USER));


	}
	
	
	public static ModelSession getModel() {
		if (VaadinSession.getCurrent().getAttribute("vam_modelSession_serv")  == null) {
			ModelSession model = new ModelSession();
			VaadinSession.getCurrent().setAttribute("vam_modelSession_serv", model);
		}
		return (ModelSession) VaadinSession.getCurrent().getAttribute("vam_modelSession_serv");
	}
	
}