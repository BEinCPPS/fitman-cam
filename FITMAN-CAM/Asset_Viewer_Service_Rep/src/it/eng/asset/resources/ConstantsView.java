package it.eng.asset.resources;

import com.vaadin.server.VaadinService;

public class ConstantsView {

	public static final String INTESTAZIONE_XML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
			+ "\n";
	public static final int RESPONSE_OK = 200;
	public static final int RESPONSE_ERROR = 500;
	public static final String BREADCRUMB_CSS = "breadcrumb_vaad";

	public enum Views {
		assetRepositoryView, publicServiceView, localServiceView, servicesView, assetDetailView
	};
	
	
	public static String basepath = VaadinService.getCurrent().getBaseDirectory().getAbsolutePath();
	
	public static final String TICK_ICON = basepath+ "/WEB-INF/Images/tick.png";
	public static final String CROSS_ICON = basepath+ "/WEB-INF/Images/cross.png";
	
	public static final String ATTRIBUTE_ICON = basepath+ "/WEB-INF/Images/text_page.png";
	public static final String RELATIONSHIP_ICON = basepath+ "/WEB-INF/Images/link.png";
	public static final String NEXT_ICON = basepath+ "/WEB-INF/Images/next.png";
	public static final String PREV_ICON = basepath+ "/WEB-INF/Images/previous.png";
	public static final String PUBLISH_ICON = basepath+ "/WEB-INF/Images/publish.png";
	
	
}
