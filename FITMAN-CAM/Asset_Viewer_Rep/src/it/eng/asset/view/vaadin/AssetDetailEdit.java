package it.eng.asset.view.vaadin;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.GenericService;
import it.eng.asset.bean.Property;
import it.eng.asset.resources.ConstantsView;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.asset.utils.UtilNavigation;
import it.eng.msee.ontorepo.Util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.jensjansson.pagedtable.PagedTable;
import com.vaadin.data.Validator;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.data.util.IndexedContainer;
import com.vaadin.data.validator.StringLengthValidator;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.server.FileResource;
import com.vaadin.server.Resource;
import com.vaadin.server.VaadinService;
import com.vaadin.ui.AbstractSelect;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.FormLayout;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.TabSheet;
import com.vaadin.ui.Table.Align;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.Reindeer;

import de.steinwedel.messagebox.ButtonId;
import de.steinwedel.messagebox.Icon;
import de.steinwedel.messagebox.MessageBox;

public class AssetDetailEdit  extends VerticalLayout implements View   {
	
	private static final long serialVersionUID = 8147854381932107783L;
	private PagedTable dataPropertyEdit = new PagedTable();
	private PagedTable listServiceEdit = new PagedTable();
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private VerticalLayout externalPanel = new VerticalLayout();
	private FormLayout hTitle = new FormLayout();
    private Label nameLabel;
    private Label assetClassLabel;
    private Label assetModelLabel;
    private Label ownerLabel;
    private Label timestampLabel;
	private VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
	
	// Campi Add Attribute
	final ComboBox select_data_property = new ComboBox("Name: ");
	private TextField value_property = new TextField("Value: ");
	private Asset current;
	// add relationship
	private String selected_asset = "";
	private ComboBox selectObjProperty;
	private ComboBox select_asset_to_prop;
	private Boolean create_property = false;
	

	//Insert Attribute
	private String selected_asset_insert = "";
	final ComboBox combo_type = returnTypeProperty();
	final String combo_type_select = "";
	
		String basepath = VaadinService.getCurrent()
			.getBaseDirectory().getAbsolutePath();
    

	//insert relation
	String selected_relationship = "";
	String selected_relationship_value = "";
		
	@Override
	public void enter(ViewChangeEvent event) {

		
		ModelSession model = UtilNavigation.getModel();
		
			if (AssetRepositoryUI.getModel().getInizialized() == null)
				return;

		addComponent(BreadCrumb.getAssetDetailBreadCrumb(ConstantsView.Views.assetDetailView.name(), model.getAsset_name()));
		
		try {
			initLayout();
		} catch (Exception e) {
			String rit = e.getMessage(); 
			e.printStackTrace();
			MessageBox.showPlain(Icon.ERROR, "Asset Detail", rit, de.steinwedel.messagebox.ButtonId.OK);
		
		}
	}
	
	private void initLayout() throws Exception {
		setWidth("99%");
		addComponent(externalPanel);
        setMargin(true);
        ModelSession model = UtilNavigation.getModel();
        String name_asset = model.getAsset_name();
        String name_class = model.getClass_name();
    	current = managerRepositoryService.getAsset(name_asset, name_class);
		String assetName= current.getName();
		String assetClass = current.getAssetClass();
		String assetModel = current.getModel();			
		String owner= current.getOwner();
		String timestamp = "";
		if (current.getCreated() != null ) {
			timestamp = sdf.format(current.getCreated());
		}
		nameLabel = new Label ("	<b>Name: </b> "+ assetName, Label.CONTENT_XHTML);
		nameLabel.addStyleName(Reindeer.LABEL_H2);
		
		assetClassLabel = new Label ("	<b>Class: </b> "+ assetClass, Label.CONTENT_XHTML);
		assetClassLabel.addStyleName(Reindeer.LABEL_SMALL);
		
		assetModelLabel = new Label ("	<b>Model: </b> "+ assetModel, Label.CONTENT_XHTML);
		assetModelLabel.addStyleName(Reindeer.LABEL_SMALL);
		
		ownerLabel = new Label ("	<b>Owner: </b> "+ owner, Label.CONTENT_XHTML);
		ownerLabel.addStyleName(Reindeer.LABEL_SMALL);
		
		timestampLabel = new Label ("	<b>Created: </b> "+ timestamp, Label.CONTENT_XHTML);
		timestampLabel.addStyleName(Reindeer.LABEL_SMALL);
		
		
		hTitle.setSpacing(true);
		hTitle.addComponentAsFirst(nameLabel);
		hTitle.addComponent(assetClassLabel);
		hTitle.addComponent(assetModelLabel);
		hTitle.addComponent(timestampLabel);
		hTitle.addComponent(ownerLabel);
        

		externalPanel.addComponent(hTitle,0);

		TabSheet tab = new TabSheet();
		
		
		try {
			dataPropertyEdit = initDataProperty(assetName);
		} catch (Exception e) {
			String rit = e.getMessage(); 
			e.printStackTrace();
			MessageBox.showPlain(Icon.ERROR, "Asset Detail", rit, de.steinwedel.messagebox.ButtonId.OK);
		
		}
		try {
			listServiceEdit = initListService(assetName);
		} catch (Exception e) {
			String rit = e.getMessage(); 
			e.printStackTrace();
			MessageBox.showPlain(Icon.ERROR, "Asset Detail", rit, de.steinwedel.messagebox.ButtonId.OK);
		
		}
		
		
		
        listServiceEdit.setHeight("150px");
        //dataPropertyEdit.setHeight("150px");
        HorizontalLayout sp = new HorizontalLayout();
        sp.setHeight("5px");
        sp.setWidth(80,Unit.PERCENTAGE);
       
        HorizontalLayout sp1 = new HorizontalLayout();
        sp1.setHeight("7px");
        
        HorizontalLayout sp2 = new HorizontalLayout();
        sp2.setHeight("7px");
       
        HorizontalLayout control = new HorizontalLayout();
        control.addComponent(dataPropertyEdit.createControls());
        control.setWidth(90,Unit.PERCENTAGE);
		
        VerticalLayout legLayout = new VerticalLayout();
		legLayout.addComponent(dataPropertyEdit);
		legLayout.addComponent(sp);
		legLayout.addComponent(control);
		legLayout.addComponent(sp1);

		HorizontalLayout bt = new HorizontalLayout();
		
		Button newAttributeBt = new Button("New Attribute");
		newAttributeBt .setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));
		newAttributeBt .setSizeFull();
		newAttributeBt .setWidth("150px");
		newAttributeBt .addClickListener(new ClickListener() {
    		private static final long serialVersionUID = 3594111502374785946L;
			@SuppressWarnings({ "serial", "deprecation" })
			@Override
            public void buttonClick(ClickEvent event) {
                final Window w = new Window("New Attribute");

                w.setModal(true);
                w.setClosable(true);
                w.setResizable(false);

                getUI().addWindow(w);

                w.setContent(new VerticalLayout() {
					private static final long serialVersionUID = 5609933262351175622L;
					{
				        addComponent(new HorizontalLayout() {
				            {
				            	List<Property> pr = new ArrayList<Property>();
				            	pr  = managerRepositoryService.getDataProperty(current.getName());
				            	final Label value = new Label("");
				            	int i = 1;
				            	String value_property_select = "";
				            	String value_property_type = "";
				            	for (Property prop : pr) {
				            		if (i==1) {
				            			value_property_select = prop.getName();
				            			String str_type_value = prop.getType_value();
				            			if (str_type_value != null ) {
				            				value_property_type = prop.getType_value().replace("http://www.w3.org/2001/XMLSchema#", "");	
				            			} 
				            			//value_property_type = str_type_value;
				            			
				            		}
				            		if(!prop.getName().contains("system#"))
				            			select_data_property.addItem(prop.getName());
				            		i++;
								}
				            	combo_type.setValue(value_property_type);
				    	 		combo_type.setEnabled(false);
				            	select_data_property.setValue(value_property_select);
				            	selected_asset_insert = value_property_select;
				            	select_data_property.setInvalidAllowed(true);
                        		select_data_property.setNullSelectionAllowed(false);
                                select_data_property.setNewItemsAllowed(true);
                                select_data_property.setImmediate(true);				            		 
                                select_data_property.addListener(new ValueChangeListener() {
									
									@Override
									public void valueChange(ValueChangeEvent event) {
									     if (select_data_property.getValue() != null) {
									    	 	selected_asset_insert  = (String) select_data_property.getValue();
									    	 	String ritorno_esistenza = "";
									    	 	ritorno_esistenza =  managerRepositoryService.PropertyExist(selected_asset_insert);
									    	 	if (!ritorno_esistenza.equals("")) {
									    	 		combo_type.setValue(ritorno_esistenza.replace("http://www.w3.org/2001/XMLSchema#", ""));
									    	 		setImmediate(true);
									    	 		combo_type.setEnabled(false);
									    	 	} else {
									    	 		create_property = true;
									    	 		setImmediate(true);
									    	 		combo_type.setEnabled(true);
									    	 	}
	                                        }	
									}
								});
				                setSizeUndefined();
				                setMargin(true);
				                FormLayout gridView = new FormLayout();
				                HorizontalLayout or = new HorizontalLayout();
				                or.addComponent(select_data_property);
				                
				                
				        		gridView.addComponent(select_data_property);
				        		gridView.addComponent(combo_type);
				        		value_property.setImmediate(true);
				        		value_property.setMaxLength(Util.MAX_NAME_LENGTH);
				                Collection<Validator> collVal = value_property.getValidators();
				                if (collVal.size() == 0 ) {
				                	value_property.addValidator(
					        				new StringLengthValidator("Must be 1 to 255 characters long",
					        					Util.MIN_NAME_LENGTH, Util.MAX_NAME_LENGTH, false));
				                	value_property.setMaxLength(Util.MAX_NAME_LENGTH);
				                }
				        		gridView.addComponent(value_property);
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
				                cancel.addClickListener(new ClickListener() {
				                    @Override
				                    public void buttonClick(ClickEvent event) {
				                    	selected_asset_insert = "";
				                    	combo_type.setValue("");
				                    	select_data_property.setValue("");
				                    	value_property.setValue("");
				    	    	 		combo_type.setEnabled(true);
				    	    	 		setImmediate(true);
				                    	w.close();
				                    }
				                });
				                cancel.setClickShortcut(KeyCode.ESCAPE, null);
				                cancel.setIcon(new FileResource(new File(ConstantsView.CROSS_ICON)));
				                addComponent(cancel);
				                setExpandRatio(cancel, 1);
				                setComponentAlignment(cancel,
				                        Alignment.TOP_RIGHT);

				                Button ok = new Button("Save");
				                ok.addStyleName("wide");
				                ok.addStyleName("default");
				                ok.addClickListener(new ClickListener() {
				                    public void buttonClick(ClickEvent event) {

				                    	Class<?> class_type = returnClassType(combo_type.getValue().toString());
				                    	String value = value_property.getValue();
				                    	String asset = current.getName();
				                    	try {

					                    	String rit = managerRepositoryService.insertDataProperty(asset, selected_asset_insert, value, class_type);
					                    	if (!rit.equals("OK"))
					                    	{
					                    		MessageBox.showPlain(Icon.ERROR, "Attribute", rit, de.steinwedel.messagebox.ButtonId.OK);
					                    	}
					    	    	 		combo_type.setEnabled(true);
					    	    	 		w.close();
					    					ModelSession model = UtilNavigation.getModel();
					    					model.setInizialized(true);
					    					Navigator nav = UtilNavigation.getNavigator();
					    					nav.navigateTo("/" + ConstantsView.Views.assetDetailView.name());

				                    		
										} catch (Exception e) {
											e.printStackTrace();
										}
				                    }

									private Class<?> returnClassType(String value) {
										
										Class<?> ret = null;
										
										if (value.equals("string")) {
											ret = String.class;
										} else if (value.equals("date")) {
											ret = Date.class;
										} else if (value.equals("int")) {
											ret = Integer.class;
										} else if (value.equals("decimal")) {
											ret = Double.class;
										} else if (value.equals("boolean")) {
											ret = Boolean.class;
										}
										return ret;
									}
				                });
				                ok.setClickShortcut(KeyCode.ENTER, null);
				                ok.setIcon(new FileResource(new File(ConstantsView.TICK_ICON)));
				                addComponent(ok);
				            }
				        });

				    }
				});

            }					
				
        });
		


		
		
		Button addObjBt = new Button("New Relationship");
		addObjBt.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));
		addObjBt.setSizeFull();
		addObjBt.setWidth("150px");
		addObjBt.addClickListener(new ClickListener() {
            /**
		 * 
		 */
		private static final long serialVersionUID = 1L;

			@SuppressWarnings({ "serial", "deprecation" })
			@Override
            public void buttonClick(ClickEvent event) {
                final Window w = new Window("Add Relationship");

                w.setModal(true);
                w.setClosable(true);
                w.setResizable(false);

                getUI().addWindow(w);

                w.setContent(new VerticalLayout() {
				    /**
					 * 
					 */
					private static final long serialVersionUID = -6369552602712584974L;

					{
				        addComponent(new HorizontalLayout() {
				            {
				            	List<Property> pr = new ArrayList<Property>();
				            	pr  = managerRepositoryService.getOBjectProperty();

				            	
				            	
				            	selectObjProperty = new ComboBox("Name: ");
				            	selectObjProperty.setWidth(350, Unit.PIXELS);
				            	for (Property prop : pr) {
				            		if(!prop.getName().contains("system#"))
				            			selectObjProperty.addItem(prop.getName());
								}

				            	selectObjProperty.setInvalidAllowed(true);
				            	selectObjProperty.setNullSelectionAllowed(false);
				            	selectObjProperty.setNewItemsAllowed(true);
				            	selectObjProperty.setImmediate(true);				            		 
				            	selectObjProperty.setFilteringMode(AbstractSelect.Filtering.FILTERINGMODE_CONTAINS);
				            	selectObjProperty.addListener(new ValueChangeListener() {
									
									@Override
									public void valueChange(ValueChangeEvent event) {
									     if (selectObjProperty.getValue() != null) {
									    	 selected_relationship  = (String) selectObjProperty.getValue();
									    	 	String ritorno_esistenza = "";
									    	 	ritorno_esistenza =  managerRepositoryService.PropertyExist(selected_relationship);
									    	 	if (!ritorno_esistenza.equals("")) {
									    	 		
									    	 	} else {
									    	 		create_property = true;
									    	 		
									    	 	}
	                                        }	
										
									}
								});
				            	
								setSizeUndefined();
				                setMargin(true);
				                FormLayout gridView = new FormLayout();
				        		gridView.addComponent(selectObjProperty);

				            	select_asset_to_prop = selectIndividualRelationship("Target: ");
				            	select_asset_to_prop.setWidth(350, Unit.PIXELS);
				            	select_asset_to_prop.setFilteringMode(AbstractSelect.Filtering.FILTERINGMODE_CONTAINS);
				            	select_asset_to_prop.setNullSelectionAllowed(false);
				            	select_asset_to_prop.setNewItemsAllowed(false);
				            	select_asset_to_prop.addListener(new ValueChangeListener() {
									
									@Override
									public void valueChange(ValueChangeEvent event) {
										selected_relationship_value = select_asset_to_prop.getValue().toString();
									}
								});
				            	
				            	gridView.addComponent(select_asset_to_prop);
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
				                cancel.addClickListener(new ClickListener() {
				                    @Override
				                    public void buttonClick(ClickEvent event) {
				                    	selected_relationship = "";
				                    	selected_relationship_value = "";
				                    	w.close();
				                    }
				                });
				                cancel.setClickShortcut(KeyCode.ESCAPE, null);
				                cancel.setIcon(new FileResource(new File(ConstantsView.CROSS_ICON)));
				                addComponent(cancel);
				                setExpandRatio(cancel, 1);
				                setComponentAlignment(cancel,
				                        Alignment.TOP_RIGHT);

				                Button ok = new Button("Save");
				                ok.addStyleName("wide");
				                ok.addStyleName("default");
				                ok.addClickListener(new ClickListener() {
				                    public void buttonClick(ClickEvent event) {

				                    	String asset = current.getName();
				                    	String rit =  managerRepositoryService.insertObjectProperty(asset, selected_relationship, selected_relationship_value);
				                    	if (!rit.equals("OK"))
				                    	{
				                    		MessageBox.showPlain(Icon.ERROR, "Add Relationship", rit, de.steinwedel.messagebox.ButtonId.OK);
				                    	} else {
				                    		ModelSession model = UtilNavigation.getModel();
					    					model.setInizialized(true);
					    					Navigator nav = UtilNavigation.getNavigator();
					    					nav.navigateTo("/" + ConstantsView.Views.assetDetailView.name());
					    					w.close();
				                    		
				                    	}
				                    		
				                    	
				                    }
				                });
				                ok.setClickShortcut(KeyCode.ENTER, null);
				                ok.setIcon(new FileResource(new File(ConstantsView.TICK_ICON)));
				                addComponent(ok);
				            }
				        });

				    }
				});
            }					
        });
		
		
		bt.addComponent(newAttributeBt ,0);
		bt.addComponent(addObjBt,1);
		
		legLayout.addComponent(bt);
		legLayout.addComponent(sp2);
		
		tab.addTab(legLayout, "Properties");
		
		VerticalLayout tabService = new VerticalLayout();
		tabService.addComponent(listServiceEdit);
		
		tab.addTab(tabService,"AaaS");
		
		Button deleteBt = new Button("Delete");
		deleteBt.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/sm_not.png")));
		deleteBt.setSizeFull();
		deleteBt.addClickListener(new ClickListener() {
		            /**
				 * 
				 */
				private static final long serialVersionUID = 1L;

					@SuppressWarnings({ })
					@Override
		            public void buttonClick(ClickEvent event) {

						MessageBox.showPlain(Icon.QUESTION, 
						        "Delete " + current.getName(), 
						        "Do you really want to delete the "+ current.getName()+ " asset?", 
						        new de.steinwedel.messagebox.MessageBoxListener() {
						                                        
						                @Override
						                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
						                       if (buttonId.equals(ButtonId.YES)) {
														String name_asset = current.getName();
														String rit = managerRepositoryService.deleteAsset(name_asset);
														if (!rit.equals("OK"))
														{
															MessageBox.showPlain(Icon.ERROR, "Delete", rit, de.steinwedel.messagebox.ButtonId.OK);
														}
														else
														{
									    					ModelSession model = UtilNavigation.getModel();
									    					model.setInizialized(true);
									    					Navigator nav = UtilNavigation.getNavigator();
									    					nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());

														}
													
												} 
 
						                }
						        }, 
						        de.steinwedel.messagebox.ButtonId.NO, 
						        de.steinwedel.messagebox.ButtonId.YES);
						}
		        });
		
		HorizontalLayout space = new HorizontalLayout();
		space.setHeight("10px");

		GridLayout hBtn = new GridLayout(1,1);
		hBtn.addComponent(deleteBt, 0, 0);

		externalPanel.addComponent(tab,1);
		externalPanel.addComponent(space,2);
		externalPanel.addComponent(hBtn,3);
		externalPanel.setComponentAlignment(hBtn, Alignment.BOTTOM_RIGHT);
	}

	
	@SuppressWarnings("unchecked")
	private PagedTable initDataProperty(String nameAsset) {
		
		IndexedContainer  ic_data_property = new IndexedContainer();
		PagedTable pagedTable = new PagedTable();

		
		String prop = "";
		String name = "Name";
		String value = "Value";
		String delete = ".";
		String edit = ",";
		
		ic_data_property.addContainerProperty(prop, Button.class, null);
		ic_data_property.addContainerProperty(name, String.class,  null);
		ic_data_property.addContainerProperty(value, String.class,  null);
		ic_data_property.addContainerProperty(delete, Button.class, null);
		ic_data_property.addContainerProperty(edit, Button.class, null);

		List<Property> lProperty = new ArrayList<Property>();
	
		lProperty = managerRepositoryService.getProperty(nameAsset);
		for(Property property: lProperty){

			String nameProperty = property.getName();
			String valueProperty = property.getValue();
			String typeProperty = property.getType();
			String typeValueProperty = property.getType_value();
			Object id = ic_data_property.addItem();

			String TypeOut = decode(typeProperty);
			
			if (TypeOut.equals("Data"))
			{
				ic_data_property.getContainerProperty(id, prop).setValue(DataButton());
			}
			else
			{
				ic_data_property.getContainerProperty(id, prop).setValue(ObjButton());
			}
			ic_data_property.getContainerProperty(id, name).setValue(nameProperty); 
			ic_data_property.getContainerProperty(id, value).setValue(valueProperty);
		 	ic_data_property.getContainerProperty(id, delete).setValue(deletePropertyButton(nameAsset, nameProperty));
		 	ic_data_property.getContainerProperty(id, edit).setValue(editPropertyButton(nameAsset, nameProperty, valueProperty, TypeOut));
			  
		}

		pagedTable.setContainerDataSource(ic_data_property);
		pagedTable.setColumnWidth(prop, 50);
		pagedTable.setColumnWidth(name, 148);
		pagedTable.setColumnWidth(value, 568);
		pagedTable.setColumnWidth(delete , 40);
		pagedTable.setColumnWidth(edit, 40);
		pagedTable.setColumnHeader(delete , "");
		pagedTable.setColumnHeader(edit, "");
		pagedTable.setColumnAlignment(prop, Align.CENTER);
		pagedTable.setSizeFull();
		return pagedTable;
	}
	

	private String decode(String typeProperty) {
		String in = typeProperty.replace("java.lang.","");
		String out = "";
		if (in.equals("Object")) {
				out = in;
		} else {
			out = "Data";
		}
		return out;
	}

	@SuppressWarnings("unchecked")
	private PagedTable initListService(String nameAsset) throws Exception{

		
		String view = "View";
//		String type = ".";
		String name = "Name";
		String owner = "Owned by";
		String desc = "Description";
		String published = "Published";
		
		Resource okIco = new FileResource(new File(basepath +"/WEB-INF/Images/ok2.png"));
		Resource notIco = new FileResource(new File(basepath +"/WEB-INF/Images/no-entry3.png"));
		Resource publicIco = new FileResource(new File(basepath +"/WEB-INF/Images/public.png"));
		Resource localIco = new FileResource(new File(basepath +"/WEB-INF/Images/local.png"));

		IndexedContainer  ic_service = new IndexedContainer();
		PagedTable PagedtableService = new PagedTable();

//		ic_service.addContainerProperty(type, Button.class, null);
		ic_service.addContainerProperty(name, String.class, null);
		ic_service.addContainerProperty(owner, String.class, null);
		ic_service.addContainerProperty(desc, String.class, null);
		ic_service.addContainerProperty(published, String.class, null);
		ic_service.addContainerProperty(view, Button.class, null);

		List<GenericService> lService = new ArrayList<GenericService>();
		
		lService = managerRepositoryService.getServiceXAsset(nameAsset);
		for(GenericService service: lService){

			String typeService = service.getType();
			Object id = ic_service.addItem();
//			if (typeService.equals("Local"))
//			{
//				ic_service.getContainerProperty(id, type).setValue(locButton());
//			}
//			else
//			{
//				ic_service.getContainerProperty(id, type).setValue(pubButton());
//			}

			ic_service.getContainerProperty(id, name).setValue(service.getName());
			ic_service.getContainerProperty(id, owner).setValue(service.getOwner());
			ic_service.getContainerProperty(id, desc).setValue(service.getServiceDescription());
		
			if (service.getPublishedDate()!=null)
			{
				ic_service.getContainerProperty(id, published).setValue(service.getPublishedDate());
			}
			else
			{
				ic_service.getContainerProperty(id, published).setValue("");
			}
			ic_service.getContainerProperty(id, view).setValue(viewServiceDetailButton(service.getName(), service.getType()));
		}

		PagedtableService.setContainerDataSource(ic_service);
		
		
		PagedtableService.setSelectable(true);
		PagedtableService.setImmediate(true);
		PagedtableService.setSizeFull();
		PagedtableService.setSortEnabled(true);
//		PagedtableService.setColumnWidth(type, 50);
		PagedtableService.setColumnWidth(published, 65);
		PagedtableService.setColumnWidth(view, 40);
		PagedtableService.setColumnWidth(name, 270);
		PagedtableService.setColumnWidth(desc, 358);
		PagedtableService.setColumnAlignment(view, Align.CENTER);
		PagedtableService.setColumnAlignment(published, Align.CENTER);
//		PagedtableService.setColumnAlignment(type, Align.CENTER);
//		PagedtableService.setColumnHeader(type , "");
		
		return PagedtableService;
		
	}

	
	protected Button deletePropertyButton(final String name_asset, final String name_property) {
		Button deleteButton = new Button();
		deleteButton.setStyleName(Reindeer.BUTTON_SMALL);
		deleteButton.addStyleName("msee_button");
		deleteButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/delete16.png")));
		

		deleteButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = -8028460334401810059L;

			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, 
				        "Delete", 
				        "Do you want to delete property?", 
				        new de.steinwedel.messagebox.MessageBoxListener() {
				                                        
				                @Override
				                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
									if (buttonId.equals(ButtonId.YES)) {
										
										String rit = managerRepositoryService.deleteProperty(name_asset, name_property);
										if (!rit.equals("OK")) {
											
											MessageBox.showPlain(Icon.ERROR, "Alert", rit, de.steinwedel.messagebox.ButtonId.OK);
											
										}
										else {
					    					ModelSession model = UtilNavigation.getModel();
					    					model.setInizialized(true);
					    					Navigator nav = UtilNavigation.getNavigator();
					    					nav.navigateTo("/" + ConstantsView.Views.assetDetailView.name());
										}
										
										
									} 
				                }
				                
				        }, 
				        de.steinwedel.messagebox.ButtonId.NO, 
				        de.steinwedel.messagebox.ButtonId.YES);


			
			
			}
		});
		return deleteButton;
	}



	protected Button editPropertyButton(final String nameAsset, final String name_property, final String valueProp, final String type) {
		Button detailButton = new Button();
		detailButton.setStyleName(Reindeer.BUTTON_SMALL);
		detailButton.addStyleName("msee_button");
		detailButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/view.gif")));

		detailButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 7448025584108809783L;

			@SuppressWarnings("deprecation")
			@Override
			public void buttonClick(ClickEvent event) {
				
				
				if (type.equals("Data"))
				{
		            final Window w1 = new Window("Attribute: "+ name_property);

		            w1.setModal(true);
		            w1.setClosable(true);
		            w1.setResizable(false);
		            getUI().addWindow(w1);


						w1.setContent(new VerticalLayout() {
							private static final long serialVersionUID = -2825380289611123334L;
							{
						        addComponent(new HorizontalLayout() {
					
									private static final long serialVersionUID = 1L;

									{
						                setSizeUndefined();
						                setMargin(true);
						                value_property.setWidth(200, Unit.PIXELS);
						                value_property.setValue(valueProp);
						                value_property.setMaxLength(Util.MAX_NAME_LENGTH);
						                value_property.setImmediate(true);
		                                Collection<Validator> collVal = value_property.getValidators();
		                                if (collVal.size() == 0 ) {
							                value_property.addValidator(
									                new StringLengthValidator("Must be 1 to 255 characters long",
									                	Util.MIN_NAME_LENGTH, Util.MAX_NAME_LENGTH, false));
		                                	value_property.setMaxLength(Util.MAX_NAME_LENGTH);
		                                
		                                }

						                FormLayout gridView = new FormLayout();
						        		gridView.addComponent(value_property);
						                addComponent(gridView);
						            }
						        });

						        addComponent(new HorizontalLayout() {
		
									private static final long serialVersionUID = 1L;

									{
						                setMargin(true);
						                setSpacing(true);
						                addStyleName("footer");
						                setWidth("100%");
						                Button cancel = new Button("Cancel");
						                cancel.addClickListener(new ClickListener() {
						                  
											private static final long serialVersionUID = 1L;

											@Override
						                    public void buttonClick(ClickEvent event) {
												value_property.setValue("");
						                        w1.close();
						                    }
						                });
						                cancel.setClickShortcut(KeyCode.ESCAPE, null);
						                cancel.setIcon(new FileResource(new File(
												ConstantsView.CROSS_ICON)));
						                addComponent(cancel);
						                setExpandRatio(cancel, 1);
						                setComponentAlignment(cancel,
						                        Alignment.TOP_RIGHT);

						                Button ok = new Button("Save");
						                ok.addStyleName("wide");
						                ok.addStyleName("default");
						                ok.addClickListener(new ClickListener() {
											private static final long serialVersionUID = 1L;

											public void buttonClick(ClickEvent event) {

						                    	String value_prop_modified = value_property.getValue();
						                    	String rit =  managerRepositoryService.updateDataPropertyAsset(nameAsset, name_property, value_prop_modified);
						                    	if (!rit.equals("OK"))
						                    	{
						                    		MessageBox.showPlain(Icon.ERROR, "Attribute", rit, de.steinwedel.messagebox.ButtonId.OK);
						                    	}
						                    	else
						                    	{
							    					ModelSession model = UtilNavigation.getModel();
							    					model.setInizialized(true);
							    					Navigator nav = UtilNavigation.getNavigator();
							    					nav.navigateTo("/" + ConstantsView.Views.assetDetailView.name());
							    					w1.close();
						                    	}
						                    	
						                    }
						                });
						                ok.setClickShortcut(KeyCode.ENTER, null);
						                ok.setIcon(new FileResource(new File(
												ConstantsView.TICK_ICON)));
						                addComponent(ok);
						            }
						        });

						    }
						});
   
				}
				else if (type.equals("Object"))
				{

		            final Window w1 = new Window("Relationship: " +name_property);

		            w1.setModal(true);
		            w1.setClosable(true);
		            w1.setResizable(false);
		            getUI().addWindow(w1);

		            try {
		            	w1.setContent(new VerticalLayout() {
						    /**
							 * 
							 */
							private static final long serialVersionUID = -8697207384706982227L;

							{
						        addComponent(new HorizontalLayout() {
						            /**
									 * 
									 */
									private static final long serialVersionUID = 1L;

									{
						                setSizeUndefined();
						                setMargin(true);
						                final ComboBox sel_individual = new ComboBox("Target ");
						                final Label label_error = new Label("");
						                List<Asset> lAsset = managerRepositoryService.getAllAsset();
						                
						                for (Asset asset : lAsset) {
											
						                	sel_individual.addItem(asset.getName());
						                	
										}
						                
						                sel_individual.addListener(new ValueChangeListener() {
											private static final long serialVersionUID = 1L;

											@Override
											public void valueChange(ValueChangeEvent event) {
												if (sel_individual.getValue() != null) {
													selected_asset = (String) sel_individual.getValue();
												} else {
													selected_asset = "";
													label_error.setValue("Template must be select.");
												}
												
											}
										});
						                
						                sel_individual.setImmediate(true);
						                sel_individual.setNullSelectionAllowed(false);
						                sel_individual.setWidth(270, Unit.PIXELS);
						                FormLayout gridView = new FormLayout();
						        		gridView.addComponent(sel_individual);
						        		gridView.addComponent(label_error);
						                addComponent(gridView);
						            }
						        });

						        addComponent(new HorizontalLayout() {
						            /**
									 * 
									 */
									private static final long serialVersionUID = 1L;

									{
						                setMargin(true);
						                setSpacing(true);
						                addStyleName("footer");
						                setWidth("100%");
						                Button cancel = new Button("Cancel");
						                cancel.addClickListener(new ClickListener() {
						                    /**
											 * 
											 */
											private static final long serialVersionUID = 1L;

											@Override
						                    public void buttonClick(ClickEvent event) {
						                    	selected_asset = "";
						                        w1.close();
						                    }
						                });
						                cancel.setClickShortcut(KeyCode.ESCAPE, null);
						                cancel.setIcon(new FileResource(new File(ConstantsView.CROSS_ICON)));
						                addComponent(cancel);
						                setExpandRatio(cancel, 1);
						                setComponentAlignment(cancel,
						                        Alignment.TOP_RIGHT);

						                Button ok = new Button("Save");
						                ok.addStyleName("wide");
						                ok.addStyleName("default");
						                ok.addClickListener(new ClickListener() {
						                    /**
											 * 
											 */
											private static final long serialVersionUID = 1L;

											public void buttonClick(ClickEvent event) {

						                    	if (!selected_asset.equals("")) {
							                    	String rit =  managerRepositoryService.updateObjectPropertyAsset(nameAsset, name_property, selected_asset);
							                    	if (!rit.equals("OK"))
							                    	{
							                     		MessageBox.showPlain(Icon.ERROR, "Relationship", rit, de.steinwedel.messagebox.ButtonId.OK);
										            } else {
										            
										            	ModelSession model = UtilNavigation.getModel();
								    					model.setInizialized(true);
								    					Navigator nav = UtilNavigation.getNavigator();
								    					nav.navigateTo("/" + ConstantsView.Views.assetDetailView.name());
								    					w1.close();
										            }
						                    		
						                    		
						                    	}
						                    	
						                    	
						                    	
						                    }
						                });
						                ok.setClickShortcut(KeyCode.ENTER, null);
						                ok.setIcon(new FileResource(new File(ConstantsView.TICK_ICON)));
						                addComponent(ok);
						            }
						        });

						    }
						});
					} catch (Exception e) {
						e.printStackTrace();
					}		            	
				}

			}
		});
		return detailButton;
	}

	
	
	private ComboBox selectIndividualRelationship(String label) {

		ComboBox filter = new ComboBox(label);		

			 List<Asset> lAss = new ArrayList<Asset>();
			 lAss = managerRepositoryService.getAllAsset();
			 
			 for(Asset object: lAss){
				 
				 String name = object.getName();
				 filter.addItem(name);
			 }		 

			 filter.setWidth("150px");

		return filter;
	}

	
	protected Button viewServiceDetailButton(final String name_service, final String type_service) {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/view.gif")));

		viewButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 6104650910664879956L;

			@Override
			public void buttonClick(ClickEvent event) {

				
				ModelSession model = UtilNavigation.getModel();
				model.setInizialized(true);
				
				Navigator nav = UtilNavigation.getNavigator();
				
				model.setService_name(name_service);
				
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
	
	protected ComboBox returnTypeProperty()
	{
		ComboBox combo_type = new ComboBox("Type: ");
		combo_type.addItem("string");
		combo_type.addItem("date");
		combo_type.addItem("int");
		combo_type.addItem("decimal");
		combo_type.addItem("boolean");
		
		return combo_type;
		
	}
	

	private Button locButton() {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/local.png")));
		return viewButton;
	}

	private Button pubButton() {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/public.png")));
		return viewButton;
	}

	private Button okButton() {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/ok2.png")));
		return viewButton;
	}

	private Button notButton() {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/no-entry3.png")));
		return viewButton;
	}	

	private Button DataButton() {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(ConstantsView.ATTRIBUTE_ICON)));
		return viewButton;
	}	
	private Button ObjButton() {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(ConstantsView.RELATIONSHIP_ICON)));
		return viewButton;
	}	


}
