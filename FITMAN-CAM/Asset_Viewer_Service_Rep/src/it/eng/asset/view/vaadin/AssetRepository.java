package it.eng.asset.view.vaadin;

import it.eng.asset.bean.Asset;
import it.eng.asset.component.TreeMenu;
import it.eng.asset.resources.ConstantsView;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.asset.utils.UtilNavigation;
import it.eng.msee.ontorepo.Util;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.jensjansson.pagedtable.PagedTable;
import com.vaadin.data.Property;
import com.vaadin.data.Property.ValueChangeEvent;
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
import com.vaadin.ui.HorizontalSplitPanel;
import com.vaadin.ui.Label;
import com.vaadin.ui.Notification;
import com.vaadin.ui.Table.Align;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.Reindeer;

import de.steinwedel.messagebox.ButtonId;
import de.steinwedel.messagebox.Icon;
import de.steinwedel.messagebox.MessageBox;

public class AssetRepository extends VerticalLayout implements View {
	
	private static final long serialVersionUID = 1L;
	private HorizontalLayout editorLayout = new HorizontalLayout();
	private HorizontalLayout tabControl= new HorizontalLayout();

	private PagedTable classGrid = new PagedTable("");
	final String name_asset_insert = ""; 
	private VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
	final Label nameC = new Label("Asset Class: ");
	private TextField asset_type_name = new TextField("Asset: ");
	private ComboBox owner_field = new ComboBox("Owner: ");
	PagedTable ownerGrid = new PagedTable();
	IndexedContainer  ic_owner = new IndexedContainer();
	private HorizontalSplitPanel hSplitPanel = new HorizontalSplitPanel();
	//private HorizontalLayout fl = new HorizontalLayout();
	private String owner_selected = "";
	final ComboBox filter = new ComboBox();		
	String name_class = "";
	static TreeMenu treePanel = null;
	private TextField input_owner = new TextField();
	private Label lbOwners = new Label("Owners");

	
	String basepath = VaadinService.getCurrent()
			.getBaseDirectory().getAbsolutePath();
	
	@Override
	public void enter(ViewChangeEvent event) {
		
		
		ModelSession model = UtilNavigation.getModel();

		if (!model.getInizialized()) {

			if (AssetComposingUI.getModel().getInizialized() == null)
				return;

			//model.resetAll();
			
		}



		if (model.getClass_name() != null) {
			name_class = model.getClass_name();
		}

		
		initLayout();
		initEditor();
		
		
	}
		

	private void initEditor() {

			Button addClassBt = new Button("New Asset Model");
			addClassBt = createAssetModelButton(name_class);
			editorLayout.addComponent(addClassBt);
			editorLayout.setComponentAlignment(addClassBt, Alignment.BOTTOM_RIGHT);
	}
	
	private void initLayout() {
		
		addComponent(BreadCrumb.getBreadCrumb(ConstantsView.Views.assetRepositoryView.name()));
		hSplitPanel.setHeight("500px");
		hSplitPanel.setMaxSplitPosition(23, Unit.PERCENTAGE);

		addComponent(hSplitPanel);

		VerticalLayout leftLayout = new VerticalLayout();
		leftLayout.setSpacing(true);
		hSplitPanel.addComponent(leftLayout);
	
		
		treePanel = new TreeMenu();

		Label treeName =new Label("Asset Classes");
		treeName.addStyleName(Reindeer.LABEL_H2);
		
		
		GridLayout gridTitle = new GridLayout(3,1);
		
		
		
		HorizontalLayout titleHalf = new HorizontalLayout();
		
		HorizontalLayout spaceHalf = new HorizontalLayout();
		
		spaceHalf.setWidth("90px");
        
		titleHalf.addComponent(treeName);
		titleHalf.addComponent(spaceHalf);
		//gridTitle.addComponent(spaceHalf,1,0);
        Button btOwner = OwnersButton();
		titleHalf.addComponent(btOwner);

		gridTitle.addComponent(titleHalf,0,0);
        //gridTitle.addComponent(btOwner,2,0);

        //gridTitle.setComponentAlignment(btOwner, Alignment.TOP_RIGHT);

        leftLayout.addComponentAsFirst(gridTitle);
        leftLayout.addComponent(treePanel);

		
		if (!name_class.equals("")) {
			initRightPanel();
		}
		else {
			initEmptyRightPanel();
		}
        
		
		
	}
	
	private void initEmptyRightPanel() {

		//fl.setVisible(false);	
		Notification.show("Info", "Select an Asset Class.", Notification.TYPE_HUMANIZED_MESSAGE);
	}


	private void initRightPanel() {
				
	
		//fl.setVisible(true);
		
		HorizontalLayout spazio = new HorizontalLayout();
		spazio.setWidth("5px");
		spazio.setHeight("3px");

		VerticalLayout rightPanel = new VerticalLayout();

		initFilter(name_class);
		//fl.addComponent(filter, 2);
		nameC.setWidth("260px");
		nameC.addStyleName(Reindeer.LABEL_H2);
		nameC.setValue(name_class);

		HorizontalLayout space = new HorizontalLayout();
		space.setHeight("10px");
		HorizontalLayout space2 = new HorizontalLayout();
		space2.setHeight("10px");

		FormLayout fmLayout = new FormLayout();
		
		fmLayout.addComponent(nameC);
		
		GridLayout FilterPannel =new GridLayout(4,1);

		Label lb_filter = new Label("Filter Model By: ");
		FilterPannel.addComponent(lb_filter,1,0);
		FilterPannel.addComponent(filter,2,0);
		//fl.setSpacing(true);
		//fl.setComponentAlignment(nameC, Alignment.MIDDLE_CENTER);
		//fl.setComponentAlignment(fl, Alignment.MIDDLE_CENTER);
		FilterPannel.setWidth(93, Unit.PERCENTAGE);
		
		//editorLayout.setWidth(90, Unit.PERCENTAGE);

        VerticalLayout tabLayout = new VerticalLayout();
		
		if (filter.getValue() != null) {
		
			initClassGridtable(name_class, filter.getValue().toString());
			//tableContr.addComponent(classGrid,0,0);
			//tableContr.addComponent(space2,0,1);
			tabLayout.addComponent(classGrid); 
			tabControl.setWidth(707, Unit.PIXELS);
			editorLayout.setWidth(707, Unit.PIXELS);
			
			tabControl.addComponent(classGrid.createControls());
			tabLayout.addComponent(tabControl);
			tabLayout.setComponentAlignment(classGrid, Alignment.MIDDLE_CENTER);
			tabLayout.setComponentAlignment(tabControl, Alignment.MIDDLE_CENTER);
    	
		}

	//	GridLayout upPanel = new  GridLayout(2,4);
		//upPanel.addComponent(headPannel,0,0,1,0);
		tabLayout.addComponent(editorLayout);
		//upPannel.setComponentAlignment(headPannel, Alignment.TOP_CENTER);
		//upPanel.setComponentAlignment(classGrid, Alignment.MIDDLE_CENTER);
		tabLayout.setComponentAlignment(editorLayout, Alignment.BOTTOM_RIGHT);

		tabLayout.setSpacing(true);
		tabLayout.setMargin(true);

		//rightPanel.addComponent(headPannel);
        //rightPanel.setComponentAlignment(headPannel, Alignment.MIDDLE_CENTER);
		rightPanel.addComponent(fmLayout, 0);
		rightPanel.addComponent(FilterPannel, 1);
		rightPanel.addComponent(tabLayout, 2);
		
		hSplitPanel.addComponent(rightPanel);
		
	}
	
	@SuppressWarnings({ "deprecation", "null" })
	private void initFilter(final String classe_corrente) {

		filter.addItem("Any");
		filter.addItem("Show models only");
		filter.setNullSelectionAllowed(false);
		filter.setNewItemsAllowed(false);
		
		if (classe_corrente != null || !classe_corrente.equals("") )
		{
			 List<String> lAss = new ArrayList<String>();
			 lAss = managerRepositoryService.getListModel(classe_corrente);
			 
			 for(String object: lAss){
				 filter.addItem(object);
			 }		 
		}
		filter.setValue("Any");
        filter.setImmediate(true);
        filter.addListener(new Property.ValueChangeListener() {

			private static final long serialVersionUID = 1L;

			public void valueChange(ValueChangeEvent event) {
                if (filter.getValue() != null) {
                    initClassGridtable(classe_corrente, filter.getValue().toString());
            	}
                
            }
        });
		filter.setWidth("270px");
	}
	
	
	@SuppressWarnings("unchecked")
	private void initClassGridtable(String ClassSelected, String opt_model) {
		
		IndexedContainer  ic_asset = new IndexedContainer();
		
		classGrid.addStyleName("reindeer");
        classGrid.setPageLength(10);

		String view = "";
		String classT = "Class";
		String name = "Asset";
		String model = "Model";
		String owner = "Owner";
		String created = "Created";
		//String aas = "'";
		String newAsset = "-";
		
		Label actionDel = new Label(".");
		
		
		ic_asset.addContainerProperty(name, String.class, null);
		ic_asset.addContainerProperty(classT, String.class,  null);
		ic_asset.addContainerProperty(model, String.class,  null);
		ic_asset.addContainerProperty(owner, String.class,  null);
		ic_asset.addContainerProperty(created, Date.class, null);
		//ic_asset.addContainerProperty(aas, Button.class, null);
		ic_asset.addContainerProperty(actionDel, Button.class, null);
		ic_asset.addContainerProperty(view, Button.class, null);
		ic_asset.addContainerProperty(newAsset, Button.class, null);

		List<Asset> lAss = new ArrayList<Asset>();
			
		 if (opt_model.equals("Any"))
		 {
			 lAss = managerRepositoryService.getAssetSelected(ClassSelected);
			 
		 } else if (opt_model.equals("Show models only")) {
			 
			 lAss = managerRepositoryService.getAssetOnlyModel(ClassSelected);
			 
		 } else {

			 lAss = managerRepositoryService.getAssetSingleModel(ClassSelected, filter.getValue().toString());
			 
		 }
		 int i = 1;
		 for(Asset object: lAss){
			 
			 //Gestione delle Colonne
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
				//ic_asset.getContainerProperty(id, aas).setValue(editAssetDetailButton(object.getModel(), object.getOwner()));
			//	ic_asset.getContainerProperty(id, aas).setValue(editAssetDetailButton(object.getName(), object.getOwner()));
				ic_asset.getContainerProperty(id, view).setValue(viewAssetDetailButton(object.getName(), object.getAssetClass() ));
				ic_asset.getContainerProperty(id, actionDel).setValue(deleteAssetDetailButton(object.getName()));
				
				
				if (object.getModel() == null || object.getModel().equals(""))
				{
					ic_asset.getContainerProperty(id, newAsset).setValue(newAssetButton(object.getName(), object.getOwner()));
				}
					
					
					
			 i++;
			 
		 }
		
		 classGrid.setContainerDataSource(ic_asset);
			
		 classGrid.setColumnWidth(name,186);
		 classGrid.setColumnWidth(classT,50);
		 classGrid.setColumnWidth(model,126);
		 classGrid.setColumnWidth(owner,50);
		 classGrid.setColumnWidth(created,70);
		 classGrid.setColumnWidth(actionDel,27);
		 classGrid.setColumnWidth(view,27);
		 //classGrid.setColumnWidth(aas,27);
		 classGrid.setColumnWidth(newAsset,27);
		
		 classGrid.setColumnAlignment(name,Align.LEFT);
		 classGrid.setColumnAlignment(classT,Align.LEFT);
		 classGrid.setColumnAlignment(model,Align.LEFT);
		 classGrid.setColumnAlignment(owner,Align.LEFT);
		 classGrid.setColumnAlignment(created,Align.CENTER);
		 classGrid.setColumnAlignment(actionDel,Align.CENTER);
		 classGrid.setColumnAlignment(view,Align.CENTER);
		 //classGrid.setColumnAlignment(aas,Align.CENTER);
		 classGrid.setColumnAlignment(newAsset,Align.CENTER);

		 //classGrid.setColumnHeader(aas,"");
		 classGrid.setColumnHeader(newAsset,"");
		 classGrid.setColumnHeader(view,"");
		 classGrid.setColumnHeader(actionDel,"");
		 
		 classGrid.setSelectable(true);
		 classGrid.setImmediate(true);
		 //classGrid.setSizeFull();
		 classGrid.setSortEnabled(true);

	}

	protected Button viewAssetDetailButton(final String asset_name, final String class_name) {
		Button detailButton = new Button();
		detailButton.setStyleName(Reindeer.BUTTON_SMALL);
		detailButton.addStyleName("msee_button");
		detailButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/view.gif")));

		detailButton.addClickListener(new ClickListener() {
			
			private static final long serialVersionUID = 6510651585344484492L;

			@Override
			public void buttonClick(ClickEvent event) {

				ModelSession model = UtilNavigation.getModel();
				model.setInizialized(true);
				model.setAsset_name(asset_name);
				model.setClass_name(class_name);
				Navigator nav = UtilNavigation.getNavigator();
				nav.navigateTo("/" + ConstantsView.Views.assetDetailView.name());
			}
		});
		return detailButton;
	}

	

	protected Button deleteAssetDetailButton(final String asset_name) {
		Button deleteButton = new Button();
		deleteButton.setStyleName(Reindeer.BUTTON_SMALL);
		deleteButton.addStyleName("msee_button");
		deleteButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/delete16.png")));
		

		deleteButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 3261475970118700692L;

			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, 
				        "Delete", 
				        "Do you want to continue?", 
				        new de.steinwedel.messagebox.MessageBoxListener() {
				                                        
				                @Override
				                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
									if (buttonId.equals(ButtonId.YES)) {
										
										try {
											
											String rit = 	managerRepositoryService.deleteAsset(asset_name);
											
											if (!rit.equals("OK")) {
												MessageBox.showPlain(Icon.ERROR, "Alert", rit, ButtonId.CLOSE);
											}
											else {

												ModelSession model = UtilNavigation.getModel();
	                            				model.setInizialized(true);
	                            				Navigator nav = UtilNavigation.getNavigator();
	                            				nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());

											}
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


	protected Button editAssetDetailButton(final String model,final String Owner) {
		Button editButton = new Button();
		editButton.setStyleName(Reindeer.BUTTON_SMALL);
		editButton.addStyleName("msee_button");
		editButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/Delineato-icon.png")));

		editButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 7269707623124863212L;

			@SuppressWarnings("deprecation")
			@Override
			public void buttonClick(ClickEvent event) {

	            final Window w1 = new Window("Edit Asset Model");

	            w1.setModal(true);
	            w1.setClosable(true);
	            w1.setResizable(false);
	            getUI().addWindow(w1);
	            
	            w1.setContent(new VerticalLayout() {
					private static final long serialVersionUID = -465569178770455315L;

					{
				        addComponent(new HorizontalLayout() {
				        	private static final long serialVersionUID = 1L;
							{
				                setSizeUndefined();
				                setMargin(true);
				                FormLayout gridView = new FormLayout();
				        		gridView.addComponent(owner_field);
                        		owner_field.setWidth(270, Unit.PIXELS);
                        		List<String> owners = managerRepositoryService.getOwners();
                        		for (String own : owners) {

                        			owner_field.addItem(own);
									
								}

                        		owner_field.addListener(new Property.ValueChangeListener() {
									
									private static final long serialVersionUID = 1L;

									@Override
									public void valueChange(ValueChangeEvent event) {
										owner_selected = owner_field.getValue().toString();
									}
								});

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
									private static final long serialVersionUID = 1L;

									@Override
				                    public void buttonClick(ClickEvent event) {
										owner_selected = "";
				                        w1.close();
				                    }
				                });
				                cancel.setClickShortcut(KeyCode.ESCAPE, null);
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

				                    	String rit =  managerRepositoryService.updateAsset(model , owner_selected);
				                    	if (!rit.equals("OK"))
				                    	{
				                    		MessageBox.showPlain(Icon.ERROR, "Alert", rit, ButtonId.CLOSE);
				                    	}
				                    	else {
				                    		owner_selected = "";
				                    		owner_field.setValue("");
				                    		w1.close();
                                			ModelSession model = UtilNavigation.getModel();
                            				model.setInizialized(true);
                            				Navigator nav = UtilNavigation.getNavigator();
                            				nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());

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
		return editButton;
	}
	
	protected Button newAssetButton(final String model, final String owner) {
		Button newAssetButton = new Button();
		newAssetButton.setStyleName(Reindeer.BUTTON_SMALL);
		newAssetButton.addStyleName("msee_button");
		newAssetButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));

		newAssetButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = -6774442492244201837L;

			@SuppressWarnings("deprecation")
			@Override
			public void buttonClick(ClickEvent event) {

				final Window w = new Window("New Asset");
	            w.setModal(true);
	            w.setClosable(true);
	            w.setResizable(false);

	            getUI().addWindow(w);

	            w.setContent(new VerticalLayout() {
	                /**
					 * 
					 */
					private static final long serialVersionUID = -8205836033004280771L;

					{
	                    addComponent(new HorizontalLayout() {
	                        /**
							 * 
							 */
							private static final long serialVersionUID = 1L;

							{
	                            setSizeUndefined();
	                            setMargin(true);
	                            FormLayout gridView = new FormLayout();
                                List<String> owners = managerRepositoryService.getOwners();
                        		for (String own : owners) {
                        			owner_field.addItem(own);
								}
                        		owner_field.setWidth(270, Unit.PIXELS);
                        		owner_field.addListener(new Property.ValueChangeListener() {
									
									private static final long serialVersionUID = 1L;

									@Override
									public void valueChange(ValueChangeEvent event) {
										owner_selected = owner_field.getValue().toString();
											
									}
								});

                        		asset_type_name.setImmediate(true);
                        		asset_type_name.setMaxLength(Util.MAX_NAME_LENGTH);
                                Collection<Validator> collVal = asset_type_name.getValidators();
                                if (collVal.size() == 0 ) {

	                        		asset_type_name.addValidator(
	                                		 new StringLengthValidator("Must be 1 to 255 characters long",
	                                				 Util.MIN_NAME_LENGTH, Util.MAX_NAME_LENGTH, false));
	                        		asset_type_name.setMaxLength(Util.MAX_NAME_LENGTH);
                                
                                }

	                            gridView.addComponent(asset_type_name);
	                        	gridView.addComponent(owner_field);
	                    		asset_type_name.setWidth(270, Unit.PIXELS);
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
										asset_type_name.setValue("");
										w.close();
	                                }
	                            });
	                            cancel.setClickShortcut(KeyCode.ESCAPE, null);
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

										String name_asset_insert_new_singole_asset = asset_type_name.getValue();
	                                	if (!name_asset_insert_new_singole_asset.equals("")) {

	                                		//String owner = "";
	                                		String rit =  managerRepositoryService.insertAsset(owner_selected, model , name_asset_insert_new_singole_asset);
		                                	if (!rit.equals("OK"))
		                                	{
		                                   		MessageBox.showPlain(Icon.ERROR, "Alert", rit + "Parameter: "+ owner_selected + " * " + model, ButtonId.CLOSE);				                    	
		   				                 	}
	                                		
	                                		else {
	                                			
	    										asset_type_name.setValue("");
	    										w.close();
	                                			ModelSession model = UtilNavigation.getModel();
	                            				model.setInizialized(true);
	                            				Navigator nav = UtilNavigation.getNavigator();
	                            				nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());

	                                		}
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
		return newAssetButton;
	}

	
	//Add Asset Model
	protected Button createAssetModelButton(final String class_name) {
		Button addAssetModelButton = new Button("New Asset Model");
		addAssetModelButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));

		addAssetModelButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = -2670628804330974137L;

			@SuppressWarnings("deprecation")
			@Override
			public void buttonClick(ClickEvent event) {

			    final Window w = new Window("New Asset Model");
                w.setModal(true);
                w.setClosable(true);
                w.setResizable(false);
                getUI().addWindow(w);

                w.setContent(new VerticalLayout() {
                    /**
					 * 
					 */
					private static final long serialVersionUID = 9194637353620932539L;

					{
                        addComponent(new HorizontalLayout() {
                            
							private static final long serialVersionUID1 = 1L;

							{
                                setSizeUndefined();
                                setMargin(true);
                                FormLayout gridView = new FormLayout();
                                asset_type_name.setWidth(270, Unit.PIXELS);
                                asset_type_name.setImmediate(true);
                                Collection<Validator> collVal = asset_type_name.getValidators();
                                if (collVal.size() == 0 ) {

	                        		asset_type_name.addValidator(
	                                		 new StringLengthValidator("Must be 1 to 255 characters long",
	                                				 Util.MIN_NAME_LENGTH, Util.MAX_NAME_LENGTH, false));
	                        		asset_type_name.setMaxLength(Util.MAX_NAME_LENGTH);
                                
                                }                                
                                List<String> owners = managerRepositoryService.getOwners();
                        		for (String own : owners) {
                        			owner_field.addItem(own);
								}
                        		owner_field.setWidth(270, Unit.PIXELS);
                        		owner_field.addListener(new Property.ValueChangeListener() {
									
									private static final long serialVersionUID = 1L;

									@Override
									public void valueChange(ValueChangeEvent event) {
										owner_selected = owner_field.getValue().toString();
											
									}
								});
									

                        		gridView.addComponent(asset_type_name);
                        		gridView.addComponent(owner_field);

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
                            			owner_selected = "";
                            			owner_field.setValue("");
                            			asset_type_name.setValue("");
										w.close();
                                    }
                                });
                                cancel.setClickShortcut(KeyCode.ESCAPE, null);
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

                                    	String name = asset_type_name.getValue();
                                    	String rit =  managerRepositoryService.insertAssetType(class_name , name, owner_selected);
                                    	if (!rit.equals("OK"))
                                    	{
                                        		Notification.show("Error",
                                    					rit,
                                    						Notification.Type.ERROR_MESSAGE);
                                    	}
                                    	else
                                    	{
                                			owner_selected = "";
                                			asset_type_name.setValue("");
                                    		w.close();
                                			ModelSession model = UtilNavigation.getModel();
                            				model.setInizialized(true);
                            				Navigator nav = UtilNavigation.getNavigator();
                            				nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());
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
		return addAssetModelButton;
	}
	
	
	protected Button OwnersButton() {
		Button addAssetModelButton = new Button();
		addAssetModelButton.setStyleName(Reindeer.BUTTON_SMALL);
		addAssetModelButton.addStyleName("msee_button");
		addAssetModelButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/Person.png")));
		addAssetModelButton.setDescription("Owners Management");
		
		addAssetModelButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = -2670628804330974137L;

			@SuppressWarnings("deprecation")
			@Override
			public void buttonClick(ClickEvent event) {

			    final Window w = new Window("Owners");
                w.setModal(true);
                w.setClosable(true);
                w.setResizable(false);
                getUI().addWindow(w);

                w.setContent(new VerticalLayout() {
                    /**
					 * 
					 */
					private static final long serialVersionUID = 9194637353620932539L;

					{
                        addComponent(new HorizontalLayout() {
                            
							private static final long serialVersionUID1 = 1L;

							{
                                setSizeUndefined();
                                setMargin(true);
                                
                                VerticalLayout vlContainer = new VerticalLayout();
                                
                                
                                lbOwners.setWidth(100, Unit.PIXELS);
                                input_owner.setWidth(413, Unit.PIXELS);
                                input_owner.setMaxLength(Util.MAX_NAME_LENGTH);
                                input_owner.setImmediate(true);
                                
                                Collection<Validator> collVal = input_owner.getValidators();
                                if (collVal.size() == 0 ) {
                                input_owner.addValidator(
                                		 new StringLengthValidator("Must be 1 to 255 characters long",
                                				 Util.MIN_NAME_LENGTH, Util.MAX_NAME_LENGTH, false));
                                }
                                input_owner.setMaxLength(Util.MAX_NAME_LENGTH);
                                
                                HorizontalLayout spaceMoon = new HorizontalLayout();
                        		spaceMoon.setHeight("10px");
                                
                        		initList();


                                HorizontalLayout control = ownerGrid.createControls();
                                
                                control.setSizeFull();
                                control.setWidth("453px");
                                vlContainer.addComponent(ownerGrid);
                                vlContainer.addComponent(control);
                                vlContainer.setComponentAlignment(control, Alignment.MIDDLE_CENTER);
                                vlContainer.addComponent(spaceMoon);
                                Button btCreateOwners = createOwners();
                                HorizontalLayout HorButt= new HorizontalLayout();
                                HorButt.setWidth("40px");
                                HorButt.addComponent(btCreateOwners);
                                HorizontalLayout gvAdd = new HorizontalLayout();
                                gvAdd.addComponent(input_owner);
                                HorButt.setComponentAlignment(btCreateOwners, Alignment.MIDDLE_CENTER);
                                gvAdd.addComponent(HorButt);
                                vlContainer.addComponent(gvAdd);
                                
                                addComponent(vlContainer);
                                
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

                                Button cancel = new Button("Close");
                                cancel.addClickListener(new ClickListener() {
                                    /**
									 * 
									 */
									private static final long serialVersionUID = 1L;

									@Override
                                    public void buttonClick(ClickEvent event) {
                            			input_owner.setValue("");
										w.close();
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
		return addAssetModelButton;
	}

	private void initList(){
	
		List<String> Owners = null;
    
	 	try {
		 		Owners = managerRepositoryService.getOwners();
		 	} catch (Exception e) {
		 		e.printStackTrace();
		 	}


		
		String ownersT = "Owner";
		String delete = "";
		
		createContainers(ownersT, delete, Owners); 
		
		 ownerGrid.setContainerDataSource(ic_owner);
		 ownerGrid.setColumnWidth(ownersT,400);
		 ownerGrid.setColumnWidth(delete,27);
		 ownerGrid.setColumnAlignment(ownersT,Align.LEFT);
		 ownerGrid.setColumnAlignment(delete,Align.CENTER);
		 ownerGrid.setColumnHeader(delete,"");
		 //ownerGrid.setSelectable(true);
		 //ownerGrid.setImmediate(true);
		 //ownerGrid.setSortEnabled(true);
		 //ownerGrid.setSizeFull();
		 

	}
	
   Button deleteOwnerDetailButton(final String name_owner) {
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
			        "Do you want to delete a owners?", 
			        new de.steinwedel.messagebox.MessageBoxListener() {
			                                        
			                @Override
			                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
								if (buttonId.equals(ButtonId.YES)) {
									try {
										@SuppressWarnings("unused")
										String rit = managerRepositoryService.deleteOwner(name_owner);
										if (!rit.equals("OK")) {
											
                                    		Notification.show("Error",
                                					rit,
                                						Notification.Type.ERROR_MESSAGE);

											
										} 
										else {
											initList();
										}

										
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
   
   
	protected Button createOwners() {
		Button addAssetModelButton = new Button();
		addAssetModelButton.setStyleName(Reindeer.BUTTON_SMALL);
		addAssetModelButton.addStyleName("msee_button");
		addAssetModelButton.setIcon(new FileResource(new File(basepath +"/WEB-INF/Images/add16.png")));

		addAssetModelButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = -2670628804330974137L;

			@SuppressWarnings("deprecation")
			@Override
			public void buttonClick(ClickEvent event) {
				
				String name = input_owner.getValue();
				if (!name.equals("")) {
	            	String rit =  managerRepositoryService.insertOwner( name);
	            	if (!rit.equals("OK"))
	            	{
	                		Notification.show("Error",
	            					rit,
	            						Notification.Type.ERROR_MESSAGE);
	            	}
	            	else
	            	{
	            		input_owner.setValue("");
	        			initList();
	        			
	            	}
	            	
				}
				else
				{
            		Notification.show("Error",
        					"Owner must be entered",
        						Notification.Type.ERROR_MESSAGE);
				}
			}
            });

			
		
		return addAssetModelButton;
	}
   	
	private void createContainers (String ownersT, String delete, List<String> owners  ) {
		
		ic_owner.removeAllItems();
		
		ic_owner.addContainerProperty(ownersT, String.class, null);
		ic_owner.addContainerProperty(delete, Button.class, null);
			
		 int i = 1;
		 for(String object: owners){
			 
			 //Gestione delle Colonne
				Object id = ic_owner.addItem();
			 	ic_owner.getContainerProperty(id, ownersT).setValue(object);

				if (object != null)
				{
					ic_owner.getContainerProperty(id, ownersT).setValue(object);
				}
				else
				{
					ic_owner.getContainerProperty(id, ownersT).setValue("");
				}
					
				ic_owner.getContainerProperty(id, delete).setValue(deleteOwnerDetailButton(object));
					
			 i++;
			 
		 }
		 		
		
	}
	
	
}








