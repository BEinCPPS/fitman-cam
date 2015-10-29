package it.eng.asset.view.vaadin;

import it.eng.asset.bean.GenericService;
import it.eng.asset.bean.PublicService;
import it.eng.asset.resources.ConstantsView;
import it.eng.asset.resources.StyleConstants;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.asset.utils.UtilNavigation;
import it.eng.msee.ontorepo.Util;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.jensjansson.pagedtable.PagedTable;
import com.vaadin.data.Property;
import com.vaadin.data.Property.ReadOnlyException;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.util.IndexedContainer;
import com.vaadin.data.validator.StringLengthValidator;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.server.FileResource;
import com.vaadin.server.Resource;
import com.vaadin.server.VaadinService;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.FormLayout;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Image;
import com.vaadin.ui.Label;
import com.vaadin.ui.Table.Align;
import com.vaadin.ui.TextArea;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.Reindeer;

import de.steinwedel.messagebox.ButtonId;
import de.steinwedel.messagebox.Icon;
import de.steinwedel.messagebox.MessageBox;

public class AssetComposing  extends VerticalLayout implements View  {
	
	
	private VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
	
	private static final long serialVersionUID = 8147854381932107783L;
	private PagedTable listComposingAssets = new PagedTable();
	//private HorizontalLayout container = new HorizontalLayout();
	String basepath = VaadinService.getCurrent().getBaseDirectory().getAbsolutePath();
	//String str_value = "";
	final TextField serviceVal = new TextField("Name:");
	final TextArea description = new TextArea("Description:");
	final ComboBox ownerTemp = new ComboBox("Owner:");
	private String owner_selected = "";
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	public void enter(ViewChangeEvent event) {
		
		ModelSession model = UtilNavigation.getModel();
		if (!model.getInizialized()) {
			model.resetAll();
		}
		initLayout();

	}
	
	private void initLayout()  {

		/* Componente esterno */
		setMargin(true);
   	
		listComposingAssets = initList();
		listComposingAssets.setPageLength(10);
		listComposingAssets.setHeight(90, Unit.PERCENTAGE);
		//listComposingAssets.setWidth(100, Unit.PERCENTAGE);
		
		HorizontalLayout space = new HorizontalLayout();
		space.setHeight("10px");
		
		HorizontalLayout space1 = new HorizontalLayout();
		space1.setHeight("10px");
		
//		Button localBtn = new Button(" Add local Service");
//		localBtn.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));
//		localBtn.setSizeFull();
//		localBtn.addClickListener(new ClickListener() {
//			private static final long serialVersionUID = 1L;
//
//			@SuppressWarnings("deprecation")
//			@Override
//			public void buttonClick(ClickEvent event) {
//                final Window w = new Window("Add Local Service");
//
//                w.setModal(true);
//                w.setClosable(false);
//                w.setResizable(false);
//
//                getUI().addWindow(w);
//
//                w.setContent(new VerticalLayout() {
//                    {
//                        addComponent(new HorizontalLayout() {
//                            {
//                                setSizeUndefined();
//                                setMargin(true);
//
//                                FormLayout gridView = new FormLayout();
//                            	HorizontalLayout spaceComp = new HorizontalLayout();
//                        		spaceComp.setHeight("5px");
//                        		gridView.addComponent(spaceComp);
//
//                        		final ComboBox ownerTemp = new ComboBox("Owner:");
//                        		List<String> owners = managerRepositoryService.getOwners();
//                        		for (String own : owners) {
//
//                        			ownerTemp.addItem(own);
//									
//								}
//                        		ownerTemp.setWidth(270, Unit.PIXELS);
//
//                        		final Label value = new Label("");
//                     	       
//                                ownerTemp.setImmediate(true);
//                                ownerTemp.addListener(new Property.ValueChangeListener() {
//
//                                    /**
//									 * 
//									 */
//									private static final long serialVersionUID = -6200925783649788675L;
//
//									public void valueChange(ValueChangeEvent event) {
//                                        if (ownerTemp.getValue() != null) {
//                                        	
//                                        	owner_selected = ownerTemp.getValue().toString(); 
//                                        	
//                                        }
//
//                                        else
//                                        {
//                                        	value.setValue("*" + (String) ownerTemp.getValue());
//                                        	
//                                        }
//                                    }
//                                });
//
//                        		serviceVal.setWidth(270, Unit.PIXELS);
//                        		serviceVal.setImmediate(true);
//                        		serviceVal.setMaxLength(UtilNavigation.MAX_NAME_SERVICE);
//                        		serviceVal.addValidator(
//                        		new StringLengthValidator("Must be 1 to 100 characters long",
//                        			Util.MIN_NAME_LENGTH, UtilNavigation.MAX_NAME_SERVICE, false));
//                        		description.setWidth(270, Unit.PIXELS);
//                        		description.setHeight(160, Unit.PIXELS);
//                        		description.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);
//                        		description.setImmediate(true);
//                        		description.addValidator(
//                        		new StringLengthValidator("Must be 1 to 400 characters long",
//                        			Util.MIN_NAME_LENGTH, UtilNavigation.MAX_DESCRIPTION_SERVICE, false));
//                        		
//                        		gridView.addComponent(serviceVal);
//                        		gridView.addComponent(description);
//                        		gridView.addComponent(ownerTemp);
//                                
//                        		addComponent(gridView);
//                            }
//                        });
//
//                        addComponent(new HorizontalLayout() {
//                            {
//                                setMargin(true);
//                                setSpacing(true);
//                                addStyleName("footer");
//                                setWidth("100%");
//
//                                Button cancel = new Button("Cancel");
//                                cancel.addClickListener(new ClickListener() {
//                                    @Override
//                                    public void buttonClick(ClickEvent event) {
//                                    	serviceVal.setValue("");
//                                		description.setValue("");
//                                		ownerTemp.setValue("");
//                                		owner_selected = "";
//                                    	w.close();
//                                    }
//                                });
//                                cancel.setClickShortcut(KeyCode.ESCAPE, null);
//                                addComponent(cancel);
//                                setExpandRatio(cancel, 1);
//                                setComponentAlignment(cancel,
//                                        Alignment.TOP_RIGHT);
//
//                                Button ok = new Button("Save");
//                                ok.addStyleName("wide");
//                                ok.addStyleName("default");
//                                ok.addClickListener(new ClickListener() {
//                                    /**
//									 * 
//									 */
//									private static final long serialVersionUID = 1L;
//
//									@Override
//                                    public void buttonClick(ClickEvent event) {
//										if (!serviceVal.getValue().equals("")) {
//	                                    	LocalService ls = new LocalService();
//	                                    	ls.setName(serviceVal.getValue());
//	                                    	ls.setServiceDescription(description.getValue());
//	                                    	ls.setOwner(owner_selected);
//	                                    	int rit = managerRepositoryService.insertLocalService(ls);
//	                                        w.close();
//	
//	                                        ModelSession model = UtilNavigation.getModel();
//	                        				model.setInizialized(true);
//	                        				Navigator nav = UtilNavigation.getNavigator();
//	                        				nav.navigateTo("/" + ConstantsView.Views.servicesView.name());
//										}
//										else
//										{
//											MessageBox.showPlain(Icon.ERROR, "Add Local Service", "The service name is required.", de.steinwedel.messagebox.ButtonId.OK);
//										}
//                        			}
//                                });
//                                ok.setClickShortcut(KeyCode.ENTER, null);
//                                addComponent(ok);
//                            }
//                        });
//
//                    }
//                });
//
//            }
//		});
		
		Button publicBtn = new Button("New AaaS");
		publicBtn.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));
//		publicBtn.setSizeFull();
		publicBtn.addClickListener(new ClickListener() {
			@SuppressWarnings("deprecation")
			@Override
			public void buttonClick(ClickEvent event) {
                final Window w = new Window("New AaaS");

                w.setModal(true);
                w.setClosable(true);
                w.setResizable(false);

                getUI().addWindow(w);

                w.setContent(new VerticalLayout() {
                    {
                        addComponent(new HorizontalLayout() {
                            {
                                setSizeUndefined();
                                setMargin(true);

                                FormLayout gridView = new FormLayout();
                            	HorizontalLayout spaceComp = new HorizontalLayout();
                        		spaceComp.setHeight("5px");
                        		gridView.addComponent(spaceComp);

                        		
                        		final Label value = new Label("");
                        	       

                        		
                        		List<String> owners = managerRepositoryService.getOwners();
                        		for (String own : owners) {

                        			ownerTemp.addItem(own);
									
								}

                        		ownerTemp.setWidth(270, Unit.PIXELS);
                                ownerTemp.setImmediate(true);
                                ownerTemp.addListener(new Property.ValueChangeListener() {
                                    private static final long serialVersionUID = -5188369735622627751L;

                                    public void valueChange(ValueChangeEvent event) {
                                        if (ownerTemp.getValue() != null) {
                                        	
                                        	owner_selected = ownerTemp.getValue().toString(); 
                                        }
                                        
                                        else
                                        {
                                        	value.setValue("* Select a Value: " + (String) ownerTemp.getValue());
                                        	
                                        }
                                    }
                                });

                                


                        		serviceVal.setWidth(270, Unit.PIXELS);
                        		serviceVal.setMaxLength(UtilNavigation.MAX_NAME_SERVICE);
                        		serviceVal.setImmediate(true);
                        		serviceVal.addValidator(
                        		new StringLengthValidator("Must be 1 to 100 characters long",
                        			Util.MIN_NAME_LENGTH, UtilNavigation.MAX_NAME_SERVICE, false));

                        		description.setWidth(270, Unit.PIXELS);
                        		description.setHeight(160, Unit.PIXELS);
                        		description.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);
                        		description.setImmediate(true);
                        		description.addStyleName(StyleConstants.STYLE_ENG_FORMLAYOUT_COMPONENT_LABEL);
                        		description.addStyleName(StyleConstants.STYLE_ENG_FORMLAYOUT_COMPONENT_ERROR);
                        		description.addValidator(
                        		new StringLengthValidator("Must be 1 to 400 characters long",
                        			Util.MIN_NAME_LENGTH, UtilNavigation.MAX_DESCRIPTION_SERVICE, false));

                        		gridView.addComponent(serviceVal);
                        		gridView.addComponent(description);
                        		gridView.addComponent(ownerTemp);
                        	    gridView.addComponent(value);
                        	    
                        		addComponent(gridView);
                            }
                        });

                        addComponent(new HorizontalLayout() {
                            {
                                setMargin(true);
                                setSpacing(true);
                                addStyleName("footer");
                                setWidth("100%");

                                Button cancel = new Button("Cancel");
                                cancel.setIcon(new FileResource(new File(
										ConstantsView.CROSS_ICON)));
                                cancel.addClickListener(new ClickListener() {
                                    @Override
                                    public void buttonClick(ClickEvent event) {
                                    	serviceVal.setValue("");
                                		description.setValue("");
                                		ownerTemp.setValue("");
                                		owner_selected = "";
                                    	w.close();
                                    }
                                });
                                cancel.setClickShortcut(KeyCode.ESCAPE, null);
                                addComponent(cancel);
                                setExpandRatio(cancel, 1);
                                setComponentAlignment(cancel,
                                        Alignment.TOP_RIGHT);

                                Button ok = new Button("Save");
                                ok.setIcon(new FileResource(new File(
										ConstantsView.TICK_ICON)));
                                ok.addStyleName("wide");
                                ok.addStyleName("default");
                                ok.addClickListener(new ClickListener() {
                                    @Override
                                    public void buttonClick(ClickEvent event) {
                                    	if (!serviceVal.getValue().equals("")) {
	                                    	PublicService ps = new PublicService();
	                                    	ps.setName(serviceVal.getValue());
	                                    	ps.setServiceDescription(description.getValue());
	                                    	ps.setOwner(owner_selected);
	                                    	int rit = managerRepositoryService.insertPublicService(ps);
	                                        w.close();
	                                        ModelSession model = UtilNavigation.getModel();
	                        				model.setInizialized(true);
	                        				Navigator nav = UtilNavigation.getNavigator();
	                        				nav.navigateTo("/" + ConstantsView.Views.servicesView.name());
	                        				}
		                                    else
											{
												MessageBox.showPlain(Icon.ERROR, "Add Public Service", "The service name is required.", de.steinwedel.messagebox.ButtonId.OK);
											}
                                    }
                                });
                                ok.setClickShortcut(KeyCode.ENTER, null);
                                addComponent(ok);
                            }
                        });

                    }
                });

            }
		});		
		
//		HorizontalLayout hBtn = new HorizontalLayout();
////		hBtn.addComponent(localBtn, 0);
//		hBtn.addComponent(publicBtn, 1);
		
		GridLayout tableContr = new GridLayout(1,5);
		
		tableContr.addComponent(listComposingAssets,0,0);
		tableContr.addComponent(space,0,1);
		tableContr.addComponent(listComposingAssets.createControls(),0,2);
		tableContr.addComponent(space1,0,3);
		tableContr.addComponent(publicBtn,0,4);
		
		tableContr.setComponentAlignment(listComposingAssets, Alignment.MIDDLE_CENTER);
		tableContr.setComponentAlignment(publicBtn, Alignment.MIDDLE_LEFT);
		tableContr.setSizeFull();
		
		addComponent(tableContr);
		setComponentAlignment(tableContr, Alignment.MIDDLE_CENTER);
		
	}

	
	@SuppressWarnings({ "unused", "unchecked" })
	private PagedTable initList() {
		
		IndexedContainer  ic_service = new IndexedContainer();
		PagedTable pagedTableService = new PagedTable();

		
//		String type = "'";
		String name = "Name";
		String owner="Owned by";
		String desc = "Description ";
		String dateOfCreation="Created";
		String published ="Published ";
		String del = ".";
		String view = "-";
//		String pub = "Public";
					
		
//		ic_service.addContainerProperty(type, Button.class,  null);
		ic_service.addContainerProperty(name, String.class,  null);
		ic_service.addContainerProperty(desc , String.class,  null);
		ic_service.addContainerProperty(owner, String.class,  null);
		ic_service.addContainerProperty(dateOfCreation, String.class,  null);
		ic_service.addContainerProperty(published, String.class, null);
//		ic_service.addContainerProperty(pub, Button.class,  null);
		ic_service.addContainerProperty(del, Button.class, null);
		ic_service.addContainerProperty(view, Button.class, null);
		
		Resource deletIcoRs = new FileResource(new File(basepath +"/WEB-INF/Images/delete16.png"));
		Resource viewIco = new FileResource(new File(basepath +"/WEB-INF/Images/view.gif"));
		Resource okIco = new FileResource(new File(basepath +"/WEB-INF/Images/ok2.png"));
		Resource notIco = new FileResource(new File(basepath +"/WEB-INF/Images/no-entry3.png"));
		Resource publicIco = new FileResource(new File(basepath +"/WEB-INF/Images/public.png"));
		Resource localIco = new FileResource(new File(basepath +"/WEB-INF/Images/local.png"));

		Image del1 = new Image("", deletIcoRs);
		Image view1 = new Image("",viewIco);
		Image ok1 = new Image("",okIco);
		Image not1 = new Image("",notIco);
		Image pub1 = new Image("",publicIco);
		Image loc1 = new Image("",localIco);

		
		
		List<GenericService> lService = new ArrayList<GenericService>();
		
		try {
			lService = StaticDataServices();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(GenericService service: lService){

			
			String typeService = service.getType();
			Object id = ic_service.addItem();
//			if (typeService.equals("Local"))
//			{
//				ic_service.getContainerProperty(id, type).setValue(locButton());
//				ic_service.getContainerProperty(id, view).setValue(viewServiceDetailButton(service.getName(), service.getType()));	
//			}
//			else
//			{
//				ic_service.getContainerProperty(id, type).setValue(pubButton());
				ic_service.getContainerProperty(id, view).setValue(viewServiceDetailButton(service.getName(), service.getType()));
//			}
			ic_service.getContainerProperty(id, name).setValue(service.getName());
			ic_service.getContainerProperty(id, owner).setValue(service.getOwner());
			ic_service.getContainerProperty(id, desc).setValue(service.getServiceDescription());
			try {
				if(service.getCreated()!=null)
				ic_service.getContainerProperty(id, dateOfCreation).setValue(sdf.format(sdf.parse(service.getCreated())));
				if(service.getPublishedDate()!=null)
					ic_service.getContainerProperty(id, published).setValue(sdf.format(sdf.parse(service.getPublishedDate())));
			} catch (ReadOnlyException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			

			
			String publishedService = service.getPublished();
//			if (publishedService.equals("1"))
//			{
//				ic_service.getContainerProperty(id, pub).setValue(okButton());
//			}
//			else
//			{
//				ic_service.getContainerProperty(id, pub).setValue(notButton());
//			}
			ic_service.getContainerProperty(id, del).setValue(deleteServiceButton(service.getName(), service.getType()));			
	
		}

		pagedTableService.setContainerDataSource(ic_service);


		pagedTableService.setSelectable(true);
		pagedTableService.setImmediate(true);
		//PagedtableService.setSizeFull();
		pagedTableService.setHeight(100, Unit.PERCENTAGE);
		pagedTableService.setSortEnabled(true);
		
//		PagedtableService.setColumnWidth(type,22);
//		PagedtableService.setColumnWidth(name, 220);
//		PagedtableService.setColumnWidth(desc,280);
//		PagedtableService.setColumnWidth(owner,80);
//		PagedtableService.setColumnWidth(dateOfCreation,70);
//		PagedtableService.setColumnWidth(published,70);
//		PagedtableService.setColumnWidth(del,20);
//		PagedtableService.setColumnWidth(view,20);
//		PagedtableService.setColumnWidth(pub,20);
		
		pagedTableService.setColumnAlignment(name,Align.LEFT);
		pagedTableService.setColumnAlignment(owner,Align.LEFT);
		pagedTableService.setColumnAlignment(desc,Align.LEFT);
		pagedTableService.setColumnAlignment(dateOfCreation,Align.CENTER);
		pagedTableService.setColumnAlignment(published,Align.CENTER);
//		PagedtableService.setColumnAlignment(pub,Align.CENTER);
		pagedTableService.setColumnAlignment(del,Align.CENTER);
		pagedTableService.setColumnAlignment(view,Align.CENTER);
//		PagedtableService.setColumnAlignment(type,Align.CENTER);

//		PagedtableService.setColumnHeader(type, "");
		pagedTableService.setColumnHeader(del , "");
		pagedTableService.setColumnHeader(view, "");
		pagedTableService.setSizeFull();
		return pagedTableService;
	}

	
	protected Button deleteServiceButton(final String name_service, final String type_service) {
		Button deleteButton = new Button();
		deleteButton.setStyleName(Reindeer.BUTTON_SMALL);
		deleteButton.addStyleName("msee_button");
		deleteButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/delete16.png")));

		deleteButton.addClickListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, 
				        "Remove service", 
				        "Do you want to remove the "+name_service+" service?", 
				        new de.steinwedel.messagebox.MessageBoxListener() {
				                                        
				                @Override
				                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
									if (buttonId.equals(ButtonId.YES)) {
										if (type_service.equals("Local"))
										{
											try {
												managerRepositoryService.deleteLocalService(name_service);
											} catch (Exception e) {
												e.printStackTrace();
											}
										}
										else
										{
											try {
												managerRepositoryService.deletePublicService(name_service);
											} catch (Exception e) {
												e.printStackTrace();
											}
										}
										ModelSession model = UtilNavigation.getModel();
										model.setInizialized(true);
										Navigator nav = UtilNavigation.getNavigator();										
										nav.navigateTo("/" + ConstantsView.Views.servicesView.name());

									} 
				                }
				                
				        }, 
				        de.steinwedel.messagebox.ButtonId.NO, 
				        de.steinwedel.messagebox.ButtonId.YES);


			
			
			}
		});
		return deleteButton;
	}

	
	protected Button viewServiceDetailButton(final String name_service, final String type_service) {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/view.gif")));

		viewButton.addClickListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {

				
				ModelSession model = UtilNavigation.getModel();
				model.setInizialized(true);
				model.setService_name(name_service);
				Navigator nav = UtilNavigation.getNavigator();

				
				if (type_service.equals("Local")) {
					model.setLocal_service_name(name_service);
					nav.navigateTo("/" + ConstantsView.Views.localServiceView.name());
				}
				else {
					model.setService_name(name_service);
					nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());
				}

			}
		});
		return viewButton;
	}

	
	private List<GenericService> StaticDataServices() throws Exception{
		
		List<GenericService> lService = new ArrayList<GenericService>();
		
		lService = managerRepositoryService.getAllService();
		
		return lService;
	}

//	private Button locButton() {
//		Button viewButton = new Button();
//		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
//		viewButton.addStyleName("msee_button");
//		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/local.png")));
//		return viewButton;
//	}
//
//	private Button pubButton() {
//		Button viewButton = new Button();
//		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
//		viewButton.addStyleName("msee_button");
//		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/public.png")));
//		return viewButton;
//	}
//
//	private Button okButton() {
//		Button viewButton = new Button();
//		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
//		viewButton.addStyleName("msee_button");
//		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/ok2.png")));
//		return viewButton;
//	}

//	private Button notButton() {
//		Button viewButton = new Button();
//		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
//		viewButton.addStyleName("msee_button");
//		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/no-entry3.png")));
//		return viewButton;
//	}
}
