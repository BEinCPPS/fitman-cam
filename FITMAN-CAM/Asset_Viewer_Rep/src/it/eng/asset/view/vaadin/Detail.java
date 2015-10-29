package it.eng.asset.view.vaadin;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.LocalService;
import it.eng.asset.bean.PropertyUSDL;
import it.eng.asset.resources.ConstantsView;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.asset.utils.UtilNavigation;
import it.eng.msee.ontorepo.Util;
import it.eng.vam.rest.RestClientNimbus;
import it.eng.vam.rest.RestClientNimbusImpl;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jensjansson.pagedtable.PagedTable;
import com.vaadin.data.Property;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.data.Validator;
import com.vaadin.data.util.IndexedContainer;
import com.vaadin.data.validator.StringLengthValidator;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.server.FileResource;
import com.vaadin.server.VaadinService;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.FormLayout;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.Table;
import com.vaadin.ui.Table.Align;
import com.vaadin.ui.TextArea;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.Reindeer;

import de.steinwedel.messagebox.ButtonId;
import de.steinwedel.messagebox.Icon;
import de.steinwedel.messagebox.MessageBox;

public class Detail extends VerticalLayout implements View  {

	private PagedTable classGrid = new PagedTable("");
	private HorizontalLayout tabControl= new HorizontalLayout();
	private static final long serialVersionUID = 1085005971972994377L;
	private Table compactView;
	private GridLayout detail;
	private HorizontalLayout detailButton;
	private GridLayout saveGrdiButton;
	private GridLayout pannelDt ;
	private TextArea descriptionDt;
	final Window wAsset = new Window();
	private Button addAsset = new Button ("Add Asset");
	private Button SaveButton = new Button ("Save");
	private Boolean publish_online = true;
	final List<TextField> list_item = new ArrayList<TextField>();
	
	final VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
	Asset obj_asset = new Asset();
	LocalService localS = new LocalService();
	String basepath = VaadinService.getCurrent().getBaseDirectory().getAbsolutePath();
	String localName = "";

	String descriptionLocalService = "";
	String ownerSelected = "";
	String selectedTemplate = "";
	
	@Override
	public void enter(ViewChangeEvent event) {
		
		ModelSession model = UtilNavigation.getModel();
		
		if (AssetRepositoryUI.getModel().getInizialized() == null)
				return;
		
		addComponent(BreadCrumb.getBreadCrumb(ConstantsView.Views.localServiceView.name() ));

		
		localName = model.getLocal_service_name();
		initLayout();
		
	}

	
	private void initLayout() {

		
		 try {
			this.localS  = managerRepositoryService.getLocalService(localName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 if (!localS.getNameAsset().equals("")) {
			 this.obj_asset = managerRepositoryService.getAssetFromName(localS.getNameAsset());
		 } else {
			 this.obj_asset.setName("");
		 }

		setMargin(true);
		detail  = new GridLayout(4,6);
		detail.setHeight("230px");
		detail.setWidth("800px");
		initFormDetails();

		HorizontalLayout space = new HorizontalLayout();
		space.setHeight("10px");
		
		HorizontalLayout space1 = new HorizontalLayout();
		space1.setHeight("10px");

		compactView = new Table();
		compactView = initList(localName);
		compactView.setSizeFull();
		compactView.setHeight("60px");
		compactView.setWidth("730px");
		
		VerticalLayout spaceVert = new VerticalLayout();
		spaceVert.setWidth("130px");

		detailButton = new HorizontalLayout();
		addAsset = addAssetToLocalServiceButton(localS.getName());
		detailButton.addComponent(addAsset,0);
		detailButton.setComponentAlignment(addAsset, Alignment.BOTTOM_LEFT);
		

        HorizontalLayout sp2 = new HorizontalLayout();
        sp2.setHeight("7px");
        sp2.setWidth("428px");
        HorizontalLayout rigth = new HorizontalLayout();
        rigth.addComponent(sp2,0);
        
		SaveButton = SaveLocalServiceButton(localS.getName());
		rigth.addComponent(SaveButton,1);
		rigth.setComponentAlignment(SaveButton, Alignment.BOTTOM_RIGHT);
		detailButton.addComponent(rigth);
		pannelDt= new GridLayout(2,5);
		pannelDt.addComponent(spaceVert, 0, 0);
		pannelDt.addComponent(detail,1,0);
		pannelDt.addComponent(space,1,1);
		pannelDt.addComponent(compactView,1,2);
		pannelDt.addComponent(space1,1,3);
		pannelDt.addComponent(detailButton,1,4);
//		
//		pannelDt.setComponentAlignment(detail, Alignment.TOP_LEFT);
//		pannelDt.setComponentAlignment(compactView, Alignment.MIDDLE_CENTER);

		addComponent(pannelDt);

	}

	@SuppressWarnings("deprecation")
	private void initFormDetails(){

		Label nameLabelDt;
		nameLabelDt = new Label("Local Service: "+ localS.getName());
		nameLabelDt.addStyleName(Reindeer.LABEL_H2);
		detail.addComponent(nameLabelDt,0,0,2,0);

		Label descrCV;
		descrCV = new Label("<b>Description: &nbsp;&nbsp;</b>",Label.CONTENT_XHTML);
		descriptionDt = new TextArea();
		descriptionDt.setValue(localS.getServiceDescription());
		descriptionDt.setWordwrap(true);
		descriptionDt.setWidth("700px");
		descriptionDt.setRows(2);
		descriptionDt.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);
		descriptionDt.setImmediate(true);
        Collection<Validator> collVal = descriptionDt.getValidators();
        if (collVal.size() == 0 ) {

    		descriptionDt.addValidator(
    				new StringLengthValidator("Must be "+ Util.MIN_NAME_LENGTH +" to "+UtilNavigation.MAX_DESCRIPTION_SERVICE+" characters long",
    					Util.MIN_NAME_LENGTH, UtilNavigation.MAX_DESCRIPTION_SERVICE, false));
    		descriptionDt.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);
        
        }

		detail.addComponent(descrCV,0,1);
		detail.addComponent(descriptionDt,1,1,3,1);
		
		Label dateCreationCv = new Label("<b>Created</b>",Label.CONTENT_XHTML);
		String data = "";
		if (localS.getCreated() != null) {
			data = localS.getCreated();
		}
		Label dateCreationValCv = new Label();
		dateCreationValCv.setValue(data);
		dateCreationValCv.addStyleName(Reindeer.LABEL_SMALL);
		detail.addComponent(dateCreationCv,0,2);
		detail.addComponent(dateCreationValCv,1,2);
		detail.setComponentAlignment(dateCreationCv, Alignment.MIDDLE_LEFT);
		detail.setComponentAlignment(dateCreationValCv, Alignment.MIDDLE_CENTER);

		Label datePubblicationCv = new Label("<b>Published:</b>",Label.CONTENT_XHTML);
		String publ ="";
		if (localS.getPublishedDate() != null) {
			publ = localS.getPublishedDate();
		}
		Label datePubblicationValCv = new Label();
		datePubblicationValCv.setValue(publ);
		datePubblicationValCv.addStyleName(Reindeer.LABEL_SMALL);
	
		HorizontalLayout btn = new HorizontalLayout();
		
		
		        
        //FINE LISTENER
        //Button del_local_service = deleteServiceButton(localName);
        Button publish = publishLocalService(localS.getName());
        
        HorizontalLayout spa = new HorizontalLayout();
        spa.setWidth("5px");
        spa.setHeight("3px");
		btn.addComponent(publish, 0);
		btn.addComponent(spa, 1);
		//btn.addComponent(del_local_service, 2);
		detail.addComponent(datePubblicationCv,0,3);
		detail.addComponent(datePubblicationValCv,1,3);
		detail.addComponent(btn,2,3);
		detail.setComponentAlignment(datePubblicationCv, Alignment.MIDDLE_LEFT);
		detail.setComponentAlignment(datePubblicationValCv, Alignment.MIDDLE_CENTER);
		detail.setComponentAlignment(btn, Alignment.MIDDLE_LEFT);
		
		
		Label owner = new Label("<b>Owner</b>",Label.CONTENT_XHTML);
		//org.addStyleName(Reindeer.LABEL_SMALL);
		final ComboBox selectOR = new ComboBox();
		List<String> owners = managerRepositoryService.getOwners();
		for (String own : owners) {
			selectOR.addItem(own);
		}
		selectOR.addListener(new ValueChangeListener() {
			
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			@Override
			public void valueChange(ValueChangeEvent event) {

				ownerSelected = selectOR.getValue().toString();
		
			}
		});
		if(localS.getOwner() != null) {

			selectOR.setValue(localS.getOwner());
			
		}
		detail.addComponent(owner,0,4);
		detail.addComponent(selectOR,1,4);

		
		HorizontalLayout spacedet = new HorizontalLayout();
		spacedet.setWidth("60px");
		detail.addComponent(spacedet,0,5);
		
	}

	@SuppressWarnings({ "unchecked" })
	private PagedTable initList(String local_service_name){
		
			 	String view = "";
				String classT = "Class";
				String asset = "Asset";
				String model = "Model";
				String owner = "Owner";
				String created = "Created";
				//String desc = "Service Description";
				
				Label actionDel = new Label(".");
			//	actionDel.addStyleName(Reindeer.);
				
				IndexedContainer  ic_asset = new IndexedContainer();
				PagedTable Pagedtable = new PagedTable();

				ic_asset.addContainerProperty(asset, String.class, null);
				ic_asset.addContainerProperty(owner, String.class,  null);		
				ic_asset.addContainerProperty(classT, String.class,  null);
				ic_asset.addContainerProperty(model, String.class,  null);
				ic_asset.addContainerProperty(created, String.class, null);
				ic_asset.addContainerProperty(actionDel, Button.class, null);
				ic_asset.addContainerProperty(view, Button.class, null);

		
			 	Object id = ic_asset.addItem();
			 	ic_asset.getContainerProperty(id, asset).setValue(obj_asset.getName());
			 	if (obj_asset.getOwner() != null) {
			 		ic_asset.getContainerProperty(id, owner).setValue(obj_asset.getOwner());
			 	}
			 	else {
			 		ic_asset.getContainerProperty(id, owner).setValue("");
				 	
			 	}
			 	
			 	ic_asset.getContainerProperty(id, owner).setValue(obj_asset.getOwner());
			 	if (obj_asset.getAssetClass() != null) {
			 		ic_asset.getContainerProperty(id, classT).setValue(obj_asset.getAssetClass());
			 	}
			 	else {
			 		ic_asset.getContainerProperty(id, classT).setValue("");
				 	
			 	}
			 	
			 	ic_asset.getContainerProperty(id, model).setValue(obj_asset.getModel());
			 	if (obj_asset.getCreated() != null) {
					ic_asset.getContainerProperty(id, created).setValue(obj_asset.getCreated().toString());
			 	}
			 	else {
			 		ic_asset.getContainerProperty(id, created).setValue("");
			 	}
				if (!obj_asset.getName().equals(""))
				{
					ic_asset.getContainerProperty(id, view).setValue(viewServiceDetailButton(obj_asset.getName(), obj_asset.getAssetClass()));
					ic_asset.getContainerProperty(id, actionDel).setValue(deleteGridAssetButton(local_service_name));
				}

				Pagedtable.setContainerDataSource(ic_asset);
				Pagedtable.setColumnHeader(view, "");
				Pagedtable.setColumnHeader(actionDel, "");
		 	
		return Pagedtable;
				
		
			
	}
	
	
	protected Button viewServiceDetailButton(final String name_asset, final String name_class) {
		Button viewButton = new Button();
		viewButton.setStyleName(Reindeer.BUTTON_SMALL);
		viewButton.addStyleName("msee_button");
		viewButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/view.gif")));

		viewButton.addClickListener(new ClickListener() {
			
			private static final long serialVersionUID = 1L;

			@Override
			public void buttonClick(ClickEvent event) {
				
				ModelSession model = UtilNavigation.getModel();
				model.setInizialized(true);
				model.setAsset_name(name_asset);
				model.setClass_name(name_class);
				Navigator nav = UtilNavigation.getNavigator();			
				nav.navigateTo("/" + ConstantsView.Views.assetDetailView.name());
			}
		});
		return viewButton;
	}


	protected Button deleteServiceButton(final String name_service) {
		Button deleteButton = new Button("Delete");

		deleteButton.addClickListener(new ClickListener() {
			private static final long serialVersionUID = 1L;

			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, 
				        "Delete", 
				        "Do you want to delete the "+name_service+" service?", 
				        new de.steinwedel.messagebox.MessageBoxListener() {
				                                        
				                @Override
				                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
									if (buttonId.equals(ButtonId.YES)) {
										try {
											managerRepositoryService.deleteLocalService(localName);
										} catch (Exception e) {
											e.printStackTrace();
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


	protected Button deleteGridAssetButton(final String name_service) {
		Button deleteButton = new Button();
		deleteButton.setStyleName(Reindeer.BUTTON_SMALL);
		deleteButton.addStyleName("msee_button");
		deleteButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/delete16.png")));

		deleteButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, 
				        "Delete", 
				        "Do you want to delete a service?", 
				        new de.steinwedel.messagebox.MessageBoxListener() {
				                                        
				                @Override
				                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
									if (buttonId.equals(ButtonId.YES)) {
										try {
											managerRepositoryService.updateassetLocalService(name_service);

											ModelSession model = UtilNavigation.getModel();
											model.setInizialized(true);
											Navigator nav = UtilNavigation.getNavigator();			
											nav.navigateTo("/" + ConstantsView.Views.localServiceView.name());

										} catch (Exception e) {
											e.printStackTrace();
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
	
	protected Button addAssetToLocalServiceButton(final String name_local_service) {
		Button addAttributeBt = new Button("Add Asset");
		addAttributeBt.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));
		addAttributeBt.setWidth("150px");


		addAttributeBt .addClickListener(new ClickListener() {
	       
		private static final long serialVersionUID = 1L;

			@SuppressWarnings({ "serial" })
			@Override
	        public void buttonClick(ClickEvent event) {
	            final Window wAsset = new Window("Add Asset");
	            
	            wAsset.setModal(true);
	            wAsset.setClosable(true);
	            wAsset.setResizable(false);

	            getUI().addWindow(wAsset);

	            wAsset.setContent(new VerticalLayout() {
	            	{
				        addComponent(new HorizontalLayout() {
				            {
				            	setMargin(true);
				            	FormLayout vlExternal = new FormLayout();

				            	VerticalLayout fl = new VerticalLayout();
								initClassGridtable(name_local_service);
				        		fl.addComponent(classGrid);
				    			tabControl.addComponent(classGrid.createControls());
				    			fl.addComponent(tabControl);
				    			fl.setComponentAlignment(classGrid, Alignment.MIDDLE_CENTER);
				    			vlExternal.addComponent(fl);
				    			vlExternal.setComponentAlignment(fl, Alignment.MIDDLE_CENTER);
				    			addComponent(vlExternal);
				    			setComponentAlignment(vlExternal, Alignment.MIDDLE_RIGHT);
				    			
				            }

				        });
				        
                        addComponent(new HorizontalLayout() {
                            {
                                setMargin(true);
                                setSpacing(true);
                                addStyleName("footer");
                                setWidth("100%");

                                Button cancel = new Button("Close");
                                cancel.addClickListener(new ClickListener() {
                                    @Override
                                    public void buttonClick(ClickEvent event) {
                                    	wAsset.close();
                                    }
                                });
                                cancel.setClickShortcut(KeyCode.ESCAPE, null);
                                addComponent(cancel);
                                setExpandRatio(cancel, 1);
                                setComponentAlignment(cancel,
                                        Alignment.TOP_RIGHT);

                            }
                        });

				    }
				});

	        }					
				
	    });
		return addAttributeBt;
	}
	
	
	
	private void initClassGridtable(String name_service_select) {
		
		IndexedContainer  ic_asset = new IndexedContainer();
		
	
		classGrid.addStyleName("reindeer");
        classGrid.setPageLength(10);

		String classT = "Class";
		String name = "Asset";
		String model = "Model";
		String owner = "Owner";
		String created = "Created";
		String selected = "'";
		
		ic_asset.addContainerProperty(name, String.class, null);
		ic_asset.addContainerProperty(classT, String.class,  null);
		ic_asset.addContainerProperty(model, String.class,  null);
		ic_asset.addContainerProperty(owner, String.class,  null);
		ic_asset.addContainerProperty(created, Date.class, null);
		ic_asset.addContainerProperty(selected, Button.class, null);

		List<Asset> lAss = new ArrayList<Asset>();
		lAss = managerRepositoryService.getAsset2Select();

		 int i = 1;
		 for(Asset object: lAss){
			 
	 	Object id = ic_asset.addItem();
			 	
			 	ic_asset.getContainerProperty(id, name).setValue(object.getName());

				if (object.getAssetClass() != null)
				{
					ic_asset.getContainerProperty(id, classT).setValue(object.getAssetClass());
				}
				else
				{
					ic_asset.getContainerProperty(id, classT).setValue("");
				}
					
				if (object.getModel() != null)
				{
					ic_asset.getContainerProperty(id, model).setValue(object.getModel());
				}
				else
				{
					ic_asset.getContainerProperty(id, model).setValue("");
				}
				ic_asset.getContainerProperty(id, owner).setValue(object.getOwner());

				ic_asset.getContainerProperty(id, created).setValue(object.getCreated());
				
				ic_asset.getContainerProperty(id, selected).setValue(selectedAssetDetailButton(object.getName(), name_service_select ));
			 
		 }
		
		 classGrid.setContainerDataSource(ic_asset);
			
		 classGrid.setColumnWidth(name,186);
		 classGrid.setColumnWidth(classT,50);
		 classGrid.setColumnWidth(model,126);
		 classGrid.setColumnWidth(owner,50);
		 classGrid.setColumnWidth(created,70);
		 classGrid.setColumnWidth(selected,27);
		
		 classGrid.setColumnAlignment(name,Align.LEFT);
		 classGrid.setColumnAlignment(classT,Align.LEFT);
		 classGrid.setColumnAlignment(model,Align.LEFT);
		 classGrid.setColumnAlignment(owner,Align.LEFT);
		 classGrid.setColumnAlignment(created,Align.CENTER);
		 classGrid.setColumnAlignment(selected,Align.CENTER);

		 classGrid.setColumnHeader(selected,"");
		 
		 classGrid.setSelectable(true);
		 classGrid.setImmediate(true);
		 classGrid.setSortEnabled(true);

	}


	protected Button selectedAssetDetailButton(final String name_asset, final String name_service) {
		Button editButton = new Button();
		editButton.setStyleName(Reindeer.BUTTON_SMALL);
		editButton.addStyleName("msee_button");
		editButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/ok22.png")));

		editButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			@Override
			public void buttonClick(ClickEvent event) {
				
				int rit= managerRepositoryService.updateLocalService4Asset(name_asset, name_service);
				if (rit == 1){
					wAsset.close();				
					ModelSession model = UtilNavigation.getModel();
					model.setInizialized(true);
					Navigator nav = UtilNavigation.getNavigator();			
					nav.navigateTo("/" + ConstantsView.Views.localServiceView.name());
				}

				
				
				
			}			
		});
		return editButton;
	}

	
private Button publishLocalService(final String name_service) {

	
	Button publish = new Button("Publish");
	publish = new Button("Publish");

	publish.addClickListener(new ClickListener() {
		
		private static final long serialVersionUID = 1L;

		@SuppressWarnings({ "serial", "deprecation" })
		@Override
		public void buttonClick(ClickEvent event) {
			final Window w = new Window("Local Service: "+ name_service);

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

							FormLayout fv_template_step1 = new FormLayout();

							List<String> list_templates = new ArrayList<String>();
							
							try {
								
								RestClientNimbus rest_client = new RestClientNimbusImpl();
								list_templates = rest_client.getServiceTemplates();
								
							} catch (Exception e) {

								publish_online = false;
								list_templates.add("Shirt Manufacturing");
								list_templates.add("Textile Machinery");

							}

							
							
							final Label label_error = new Label("");
							final ComboBox selectTemp = new ComboBox("Template:");
							selectTemp.setWidth(235, Unit.PIXELS);
							
							for (String item : list_templates) {
								
								selectTemp.addItem(item);
								
							}

							selectTemp.setNullSelectionAllowed(false);
							selectTemp.addListener(new Property.ValueChangeListener() {
								private static final long serialVersionUID = -5188369735622627751L;

								public void valueChange(ValueChangeEvent event) {
									if (selectTemp.getValue() != null) {
										selectedTemplate = (String) selectTemp.getValue();
									} else {
										selectedTemplate = "";
										label_error.setValue("Template must be select.");
									}
								}
							});
							selectTemp.setImmediate(true);

							fv_template_step1.addComponent(selectTemp);
							fv_template_step1.addComponent(label_error);
							addComponent(fv_template_step1);
						}
					});

					addComponent(new HorizontalLayout() {
						{
							setMargin(true);
							setSpacing(true);
							addStyleName("footer");
							setWidth("100%");

							Button cancel = new Button("Cancel");
							cancel.addStyleName("wide");
							cancel.addStyleName("default");
							cancel.addClickListener(new ClickListener() {
								@Override
								public void buttonClick(ClickEvent event) {
									selectedTemplate = "";
									w.close();
								}
							});
							cancel.setClickShortcut(KeyCode.ESCAPE, null);
							addComponent(cancel);
							setExpandRatio(cancel, 1);
							setComponentAlignment(cancel, Alignment.TOP_RIGHT);

							Button ok = new Button("Next");
							// ok.setStyleName(Reindeer.BUTTON_SMALL);
							ok.addStyleName("wide");
							ok.addStyleName("default");
							ok.addClickListener(new ClickListener() {
								@Override
								public void buttonClick(ClickEvent event) {

									if (selectedTemplate.equals("")) {

										MessageBox.showPlain(Icon.WARN, "Alert", "Template is required.", ButtonId.CLOSE);

									} else {
										// w.close();
										final Window w1 = new Window("Local Service: "+ name_service);
										w1.setModal(true);
										w1.setClosable(true);
										w1.setResizable(false);
										getUI().addWindow(w1);

										w1.setContent(new VerticalLayout() {
											{
												addComponent(new HorizontalLayout() {
													{
														setSizeUndefined();
														setMargin(true);

														FormLayout gridView = new FormLayout();

														Label lbl_templateSelect = new Label();
														lbl_templateSelect.setValue(selectedTemplate);
														lbl_templateSelect.addStyleName(Reindeer.LABEL_H2);
														gridView.addComponent(lbl_templateSelect);

														
														List<PropertyUSDL> prop = ListPropertyUSDL(selectedTemplate);

														for (PropertyUSDL obj_prop : prop) {

															TextField propTempl = new TextField(obj_prop.getName() );
															gridView.addComponent(propTempl);
															list_item.add(propTempl);
															propTempl.setWidth(270, Unit.PIXELS);

														}


														HorizontalLayout spaceComp = new HorizontalLayout();
														spaceComp.setHeight("5px");
														addComponent(spaceComp);
														addComponent(gridView);

													}
												});

												addComponent(new HorizontalLayout() {
													{
														setMargin(true);
														setSpacing(true);
														addStyleName("footer");
														setWidth("100%");

														Button cancel_step1 = new Button("Cancel");
														cancel_step1.addStyleName("wide");
														cancel_step1.addStyleName("default");
														cancel_step1.addClickListener(new ClickListener() {
															@Override
															public void buttonClick(ClickEvent event) {
																selectedTemplate = "";
																w.close();
																w1.close();
															}
														});
														cancel_step1.setClickShortcut(KeyCode.ESCAPE, null);
														addComponent(cancel_step1);
														setExpandRatio(cancel_step1, 1);
														setComponentAlignment(cancel_step1, Alignment.TOP_RIGHT);

														
														Button prev = new Button("Prev");
														prev.addClickListener(new ClickListener() {
															@Override
															public void buttonClick(ClickEvent event) {
																w1.close();
															}
														});
														prev.setClickShortcut(KeyCode.ESCAPE, null);
														addComponent(prev);
														setExpandRatio(prev, 1);
														setComponentAlignment(prev, Alignment.TOP_RIGHT);

														Button ok = new Button("Publish");
														ok.addStyleName("wide");
														ok.addStyleName("default");
														ok.addClickListener(new ClickListener() {
															@Override
															public void buttonClick(ClickEvent event) {
						                                    
																try {
						                                    		
						                                    		if (publish_online) {
						            									RestClientNimbus rest_client = new RestClientNimbusImpl();
							                                    		Map<String,String> map_prop = new HashMap<String, String>();
							                                    		for (TextField field : list_item) {
								                                    		map_prop.put(field.getCaption(), field.getValue());																			
																		}
							                                    		boolean ret = rest_client.instantiateTemplates(selectedTemplate,map_prop);
																		if (ret) {
							                                    		try {
																			managerRepositoryService.publishLocalService(name_service);

																		} catch (Exception e) {
																			e.printStackTrace();
																		}
								                                        w.close();
								                                        w1.close();
								                                        ModelSession model = UtilNavigation.getModel();
																		model.setInizialized(true);
																		Navigator nav = UtilNavigation.getNavigator();			
																		nav.navigateTo("/" + ConstantsView.Views.localServiceView.name());
																		}
																		else {
																			
																			MessageBox.showPlain(Icon.ERROR, "Publish", "Publish Service failure", de.steinwedel.messagebox.ButtonId.OK);
																			
																		}
							                                    	}


																} catch (Exception e) {
																	publish_online = false;
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

	return publish ;

}
                                    	
     
	protected Button SaveLocalServiceButton(final String name_local_service) {
		Button addAttributeBt = new Button("Save");
		addAttributeBt.setWidth("150px");
		

		addAttributeBt .addClickListener(new ClickListener() {
	       
		private static final long serialVersionUID = 1L;

			@SuppressWarnings({ "serial" })
			@Override
	        public void buttonClick(ClickEvent event) {
				String descriptionService = descriptionDt.getValue();
				int rit = managerRepositoryService.updateLocalService(name_local_service, descriptionService, ownerSelected);
				if (rit != 1) {
					MessageBox.showPlain(Icon.ERROR, "Update", "Object cannot be updated.", de.steinwedel.messagebox.ButtonId.OK);					
				} 
				else
				{

					ModelSession model = UtilNavigation.getModel();
					model.setInizialized(true);
					Navigator nav = UtilNavigation.getNavigator();
					nav.navigateTo("/" + ConstantsView.Views.localServiceView.name());

				}
				ownerSelected = "";
	        }					
				
	    });
		return addAttributeBt;
	}


	private List<PropertyUSDL> ListPropertyUSDL(String service_tamplate) {
		
		List<PropertyUSDL> prop = new ArrayList<PropertyUSDL>();
		
		if (publish_online) {

			try {

				RestClientNimbus rest_client = new RestClientNimbusImpl();
				List<String> list_variable = rest_client.getTemplateVariables(service_tamplate);
				
				for (String string : list_variable) {
					
					PropertyUSDL pp = new PropertyUSDL();
					pp.setName(string + ": ");
					prop.add(pp);
					
				}

			} catch (Exception e) {
				publish_online = false;
			}
			
		
		} 

		if (!publish_online) 
		{

			PropertyUSDL pp = new PropertyUSDL();
			pp.setName("title: ");
			prop.add(pp);

			PropertyUSDL pp1 = new PropertyUSDL();
			pp1.setName("description: ");
			prop.add(pp1);

			PropertyUSDL pp2 = new PropertyUSDL();
			pp2.setName("Valid From: ");
			prop.add(pp2);

			PropertyUSDL pp3 = new PropertyUSDL();
			pp3.setName("validThrough: ");
			prop.add(pp3);

			PropertyUSDL pp4 = new PropertyUSDL();
			pp4.setName("priceComponent1: ");
			prop.add(pp4);
			
			PropertyUSDL pp5 = new PropertyUSDL();
			pp5.setName("currency1: ");
			prop.add(pp5);

			PropertyUSDL pp6 = new PropertyUSDL();
			pp6.setName("Unit1: ");
			prop.add(pp6);

			PropertyUSDL pp7 = new PropertyUSDL();
			pp7.setName("value1: ");
			prop.add(pp7);

			PropertyUSDL pp8 = new PropertyUSDL();
			pp8.setName("priceComponent2: ");
			prop.add(pp8);
			
			PropertyUSDL pp9 = new PropertyUSDL();
			pp9.setName("currency2: ");
			prop.add(pp9);

			PropertyUSDL pp10 = new PropertyUSDL();
			pp10.setName("Unit2: ");
			prop.add(pp10);

			PropertyUSDL pp11 = new PropertyUSDL();
			pp11.setName("value2: ");
			prop.add(pp11);
			

		}
		
		
		return prop;
	}

	
	
}
