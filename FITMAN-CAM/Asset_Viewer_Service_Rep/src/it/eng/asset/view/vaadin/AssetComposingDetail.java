package it.eng.asset.view.vaadin;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.LocalService;
import it.eng.asset.bean.PropertyUSDL;
import it.eng.asset.bean.PublicService;
import it.eng.asset.resources.ConstantsView;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.asset.utils.RestConfigUtils;
import it.eng.asset.utils.UtilNavigation;
import it.eng.msee.ontorepo.Util;
import it.eng.vam.rest.RestClientNimbus;
import it.eng.vam.rest.RestClientNimbusImpl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import msee.sp3.cm.api.resources.ServiceResourceExtended;
import msee.sp3.cm.rest.client.CmServiceApiClient;

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
import com.vaadin.server.Resource;
import com.vaadin.server.VaadinService;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.CheckBox;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.FormLayout;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Image;
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

public class AssetComposingDetail extends VerticalLayout implements View {

	private static final long serialVersionUID = 8147854381932107783L;
	private PagedTable listComposingAssets = new PagedTable();
	private GridLayout details;
	private GridLayout pannel;
	private TextArea descriptionDt;
	private ComboBox select_local_service = new ComboBox("Local Service; ");
	String basepath = VaadinService.getCurrent().getBaseDirectory().getAbsolutePath();
	private VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
	private String selectedTemplate = "";
	private List<String> checkedService = new ArrayList<String>();
	private String ownerSelected = "";
	private String nameService = "";
	private Boolean publish_online = true;
	final List<TextField> list_item = new ArrayList<TextField>();
	
	public void enter(ViewChangeEvent event) {
		
		ModelSession model = UtilNavigation.getModel();

		if (AssetComposingUI.getModel().getInizialized() == null)
				return;
		
		addComponent(BreadCrumb.getBreadCrumb(ConstantsView.Views.publicServiceView.name()));
		nameService = model.getService_name();

		try {

			initLayout();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void initLayout() throws Exception {

		setMargin(true);
		// details.setHeight(45, Unit.PERCENTAGE);

		details = new GridLayout(4, 7);
		// detail.setSizeFull();
		details.setHeight("230px");
		// detail.setMargin(true);
		details.setWidth("800px");

		initFormDetails();

		HorizontalLayout space = new HorizontalLayout();
		space.setHeight("10px");

		HorizontalLayout space1 = new HorizontalLayout();
		space1.setHeight("10px");

		// chiamata per riempire tabella
		listComposingAssets = initList();
		listComposingAssets.setSizeFull();
		listComposingAssets.setHeight("150px");
		listComposingAssets.setWidth("860px");

		VerticalLayout spaceVert = new VerticalLayout();
		spaceVert.setWidth("80px");

		pannel = new GridLayout(2, 7);
		pannel.addComponent(spaceVert, 0, 0);
		pannel.addComponent(details, 1, 0);
		pannel.setComponentAlignment(details, Alignment.TOP_LEFT);
		pannel.addComponent(space, 1, 1);
		pannel.addComponent(listComposingAssets, 1, 2);
		pannel.addComponent(space1, 1, 3);
		pannel.setComponentAlignment(listComposingAssets, Alignment.MIDDLE_CENTER);

		Button addBtn = addLocalServiceDetailButton(nameService);

		HorizontalLayout hBtn = new HorizontalLayout();
		hBtn.addComponent(addBtn, 0);
		Button SaveButton = SaveLocalServiceButton(nameService );
        HorizontalLayout sp2 = new HorizontalLayout();
        sp2.setHeight("7px");
        sp2.setWidth("558px");
        HorizontalLayout rigth = new HorizontalLayout();
        rigth.addComponent(sp2,0);
        rigth.addComponent(SaveButton,1);
		rigth.setComponentAlignment(SaveButton, Alignment.BOTTOM_RIGHT);
		hBtn.addComponent(rigth,1);

		

		HorizontalLayout space2 = new HorizontalLayout();
		space2.setHeight("10px");

		pannel.addComponent(space2, 1, 5);
		pannel.addComponent(hBtn, 1, 6);
		pannel.setComponentAlignment(hBtn, Alignment.BOTTOM_RIGHT);

		addComponent(pannel);

	}

	@SuppressWarnings("deprecation")
	private void initFormDetails() throws Exception {


		Label nameLabelDt;
		nameLabelDt = new Label("Public Service: " + nameService);
		nameLabelDt.addStyleName(Reindeer.LABEL_H2);
		details.addComponent(nameLabelDt, 0, 0, 3, 0);

		VerticalLayout spaceVert = new VerticalLayout();
		spaceVert.setWidth("120px");

		PublicService current = new PublicService();
		current = managerRepositoryService.getPublicService(nameService);

		Label descrCV;
		descrCV = new Label("<b>Description: </b>", Label.CONTENT_XHTML);
		descriptionDt = new TextArea();
		descriptionDt.setValue(current.getServiceDescription());
		descriptionDt.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);
		descriptionDt.setImmediate(true);
        Collection<Validator> collVal = descriptionDt.getValidators();
        if (collVal.size() == 0 ) {

        	descriptionDt.addValidator(
            		 new StringLengthValidator("Must be "+ Util.MIN_NAME_LENGTH +" to "+ UtilNavigation.MAX_DESCRIPTION_SERVICE +" characters long",
            				 Util.MIN_NAME_LENGTH, UtilNavigation.MAX_DESCRIPTION_SERVICE, false));
        	descriptionDt.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);
        
        }

		descriptionDt.setWordwrap(true);
		descriptionDt.setWidth("700px");
		descriptionDt.setRows(2);
		details.addComponent(descrCV, 0, 1);
		details.addComponent(descriptionDt, 1, 1, 3, 1);

		Label dateCreationCv = new Label("<b>Created</b>", Label.CONTENT_XHTML);
		String data = "";
		if (current.getCreated() != null) {
		data = current.getCreated();
		}
		Label dateCreationValCv = new Label();
		dateCreationValCv.setValue(data);
		dateCreationValCv.addStyleName(Reindeer.LABEL_SMALL);
		details.addComponent(dateCreationCv, 0, 2);
		details.addComponent(dateCreationValCv, 1, 2);
		details.setComponentAlignment(dateCreationCv, Alignment.MIDDLE_LEFT);
		details.setComponentAlignment(dateCreationValCv, Alignment.MIDDLE_CENTER);

		Label datePubblicationCv = new Label("<b>Published:</b>", Label.CONTENT_XHTML);
		// datePubblicationCv.addStyleName(Reindeer.LABEL_SMALL);
		String publ ="";
		if (current.getPublishedDate() != null) {
			publ = current.getPublishedDate();
		}
		Label datePubblicationValCv = new Label();
		datePubblicationValCv.setValue(publ);
		datePubblicationValCv.addStyleName(Reindeer.LABEL_SMALL);

		HorizontalLayout spazio = new HorizontalLayout();
		spazio.setWidth("5px");
		spazio.setHeight("3px");

		Button publish = publishPublicService(current.getName());
		
		publish.setWidth("90px");

		HorizontalLayout hPublBtn = new HorizontalLayout();
		hPublBtn.addComponent(publish, 0);
		hPublBtn.addComponent(spazio, 1);

		details.addComponent(datePubblicationCv, 0, 3);
		details.addComponent(datePubblicationValCv, 1, 3);
		details.addComponent(hPublBtn, 2, 3);
		details.setComponentAlignment(datePubblicationCv, Alignment.MIDDLE_LEFT);
		details.setComponentAlignment(datePubblicationValCv, Alignment.MIDDLE_CENTER);
		details.setComponentAlignment(hPublBtn, Alignment.MIDDLE_LEFT);

		Label owner = new Label("<b>Owner</b>", Label.CONTENT_XHTML);
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


		
		
		if(current.getOwner() != null) {

			selectOR.setValue(current.getOwner());
			
		}
		details.addComponent(owner, 0, 4);
		details.addComponent(selectOR, 1, 4);

		HorizontalLayout spacedet = new HorizontalLayout();
		spacedet.setWidth("60px");
		details.addComponent(spacedet, 0, 5);

	}

	@SuppressWarnings("unchecked")
	private PagedTable initList() throws Exception {

		String view = "";
		String service = "Service";
		String classT = "Class";
		String name = "Asset";
		String model = "Model";
		String owner = "Owner";
		String created = "Created";

		Label actionDel = new Label(".");

		PagedTable grid = new PagedTable();
		IndexedContainer icLocalService = new IndexedContainer();

		icLocalService.addContainerProperty(service, String.class, null);
		icLocalService.addContainerProperty(name, String.class, null);
		icLocalService.addContainerProperty(classT, String.class, null);
		icLocalService.addContainerProperty(model, String.class, null);
		icLocalService.addContainerProperty(owner, String.class, null);
		icLocalService.addContainerProperty(created, String.class, null);
		icLocalService.addContainerProperty(actionDel, Button.class, null);
		icLocalService.addContainerProperty(view, Button.class, null);

		List<LocalService> list_service = managerRepositoryService.getLocalServiceDetail(nameService);

		for (LocalService localService : list_service) {

			Object id = icLocalService.addItem();

			Asset as = managerRepositoryService.getAssetFromName(localService.getNameAsset());
			String Class = "";
			String Model = "";
			String Owner = "";
			if (as != null) {
				Class = as.getAssetClass();
				Model = as.getModel();
				Owner = as.getOwner();
				
			}
			icLocalService.getContainerProperty(id, service).setValue(localService.getName());
			icLocalService.getContainerProperty(id, name).setValue(localService.getNameAsset());
			icLocalService.getContainerProperty(id, classT).setValue(Class);
			icLocalService.getContainerProperty(id, model).setValue(Model);
			icLocalService.getContainerProperty(id, owner).setValue(Owner);
			icLocalService.getContainerProperty(id, created).setValue(localService.getCreated());
			icLocalService.getContainerProperty(id, view).setValue(viewAssetDetailButton(localService.getName()));
			icLocalService.getContainerProperty(id, actionDel).setValue(deleteServiceDetailButton(localService.getName()));
			
		} 
		
		grid.setContainerDataSource(icLocalService);
		grid.setColumnWidth(service, 210);
		grid.setColumnWidth(name, 190);
		grid.setColumnWidth(classT, 50);
		grid.setColumnWidth(model, 110);
		grid.setColumnWidth(owner, 50);
		grid.setColumnWidth(created, 70);
		grid.setColumnWidth(actionDel, 20);
		grid.setColumnWidth(view, 20);

		grid.setColumnAlignment(service, Align.LEFT);
		grid.setColumnAlignment(name, Align.LEFT);
		grid.setColumnAlignment(classT, Align.LEFT);
		grid.setColumnAlignment(model, Align.LEFT);
		grid.setColumnAlignment(owner, Align.LEFT);
		grid.setColumnAlignment(created, Align.CENTER);
		grid.setColumnAlignment(actionDel, Align.CENTER);
		grid.setColumnAlignment(view, Align.CENTER);
		
		grid.setColumnHeader(actionDel, "");
		grid.setColumnHeader(view, "");

		grid.setSelectable(true);
		grid.setImmediate(true);
		grid.setSortEnabled(true);
		return grid;
	}

	protected Button deleteServiceButton(final String name_service) {
		Button deleteButton = new Button("Delete");
		deleteButton.addClickListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, "Delete", "Do you want to delete this service?", new de.steinwedel.messagebox.MessageBoxListener() {

					@Override
					public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
						if (buttonId.equals(ButtonId.YES)) {
							// Deleted
							// name_service
						}
					}

				}, de.steinwedel.messagebox.ButtonId.NO, de.steinwedel.messagebox.ButtonId.YES);

			}
		});
		return deleteButton;
	}

	protected Button deleteServiceDetailButton(final String name_local_service) {
		Button deleteButton = new Button();
		deleteButton.setStyleName(Reindeer.BUTTON_SMALL);
		deleteButton.addStyleName("msee_button");
		deleteButton.setIcon(new FileResource(new File(basepath + "/WEB-INF/Images/delete16.png")));

		deleteButton.addClickListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, "Delete", "Do you want to delete the local service's association ?", new de.steinwedel.messagebox.MessageBoxListener() {

					@Override
					public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
						if (buttonId.equals(ButtonId.YES)) {
							try {
								int rit = managerRepositoryService.deleteAssociationLocal2Public(nameService ,name_local_service);
								if (rit==1){
									ModelSession model = UtilNavigation.getModel();
									model.setInizialized(true);
									Navigator nav = UtilNavigation.getNavigator();			
									nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());
								} 
								else {
									MessageBox.showPlain(Icon.ERROR, "Delete", "The local service's association cannot be delete", de.steinwedel.messagebox.ButtonId.OK);
									
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					}

				}, de.steinwedel.messagebox.ButtonId.NO, de.steinwedel.messagebox.ButtonId.YES);

			}
		});
		return deleteButton;
	}

	protected Button viewAssetDetailButton(final String service_name) {
		Button detailButton = new Button();
		detailButton.setStyleName(Reindeer.BUTTON_SMALL);
		detailButton.addStyleName("msee_button");
		detailButton.setIcon(new FileResource(new File(basepath + "/WEB-INF/Images/view.gif")));

		detailButton.addClickListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {

				
				ModelSession model = UtilNavigation.getModel();
				model.setInizialized(true);
				model.setLocal_service_name(service_name);
				Navigator nav = UtilNavigation.getNavigator();
				nav.navigateTo("/" + ConstantsView.Views.localServiceView.name());
			}
		});
		return detailButton;
	}

	protected Button addLocalServiceDetailButton(final String name_local_service) {
		Button addAttributeBt = new Button("Add Local Service");
		addAttributeBt.setIcon(new FileResource(new File(basepath + "/WEB-INF/Images/add16.png")));
		addAttributeBt.setWidth("150px");

		addAttributeBt.addClickListener(new ClickListener() {
			/**
		 * 
		 */
			private static final long serialVersionUID = 1L;

			@SuppressWarnings({ "serial" })
			@Override
			public void buttonClick(ClickEvent event) {
				final Window wLocal = new Window("Add Local Service");

				wLocal.setModal(true);
				wLocal.setClosable(true);
				wLocal.setResizable(false);
				getUI().addWindow(wLocal);

				wLocal.setContent(new VerticalLayout() {
					{
						addComponent(new HorizontalLayout() {
							{

								final Table PagedtableService = initLocalService(name_local_service);
								setMargin(true);
								FormLayout gridView = new FormLayout();

								HorizontalLayout spaceComp = new HorizontalLayout();
								spaceComp.setHeight("5px");
								gridView.addComponent(spaceComp);
								addComponent(PagedtableService);
								addComponent(gridView);

							}

							private Table initLocalService(String local_service_name) {

								final IndexedContainer ic_service = new IndexedContainer();
								final Table PagedtableService = new Table();

								String type = "'";
								String name = "Name";
								String owner = "Owned by";
								String desc = "Description ";
								String dateOfCreation = "Created";
								String published = "Published ";
								String selected = "";

								ic_service.addContainerProperty(type, Image.class, null);
								ic_service.addContainerProperty(name, String.class, null);
								ic_service.addContainerProperty(desc, String.class, null);
								ic_service.addContainerProperty(owner, String.class, null);
								ic_service.addContainerProperty(dateOfCreation, String.class, null);
								ic_service.addContainerProperty(published, String.class, null);
								ic_service.addContainerProperty(selected, com.vaadin.ui.CheckBox.class, null);

								Resource publicIco = new FileResource(new File(basepath + "/WEB-INF/Images/public.png"));
								Resource localIco = new FileResource(new File(basepath + "/WEB-INF/Images/local.png"));

								Image pub1 = new Image("", publicIco);
								Image loc1 = new Image("", localIco);

								List<LocalService> lService = new ArrayList<LocalService>();

								try {
									// lService =
									// managerRepositoryService.getAllService();
									lService = StaticDataServices();
								} catch (Exception e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								for (LocalService service : lService) {

									Object id = ic_service.addItem();
									ic_service.getContainerProperty(id, type).setValue(loc1);
									ic_service.getContainerProperty(id, name).setValue(service.getName());
									ic_service.getContainerProperty(id, owner).setValue(service.getOwner());
									ic_service.getContainerProperty(id, desc).setValue(service.getServiceDescription());

									ic_service.getContainerProperty(id, selected).setValue(chkServiceDetail(service.getName()));

								}

								PagedtableService.setContainerDataSource(ic_service);

								PagedtableService.setSelectable(true);
								PagedtableService.setImmediate(true);
								PagedtableService.setSortEnabled(true);

								PagedtableService.setColumnWidth(type, 22);
								PagedtableService.setColumnWidth(name, 220);
								PagedtableService.setColumnWidth(desc, 320);
								PagedtableService.setColumnWidth(owner, 80);
								PagedtableService.setColumnWidth(dateOfCreation, 70);
								PagedtableService.setColumnWidth(published, 70);

								PagedtableService.setColumnAlignment(name, Align.LEFT);
								PagedtableService.setColumnAlignment(owner, Align.LEFT);
								PagedtableService.setColumnAlignment(desc, Align.LEFT);
								PagedtableService.setColumnAlignment(dateOfCreation, Align.CENTER);
								PagedtableService.setColumnAlignment(published, Align.CENTER);
								PagedtableService.setColumnAlignment(type, Align.CENTER);

								PagedtableService.setColumnHeader(published, "");
								PagedtableService.setColumnHeader(type, "");
								
								
								return PagedtableService;

							}

							private List<LocalService> StaticDataServices() throws Exception {

								List<LocalService> lService = new ArrayList<LocalService>();
								
								lService = managerRepositoryService.getLocalServicePublished();

								return lService;
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
										checkedService.clear();
										wLocal.close();
									}
								});
								cancel.setClickShortcut(KeyCode.ESCAPE, null);
								addComponent(cancel);
								setExpandRatio(cancel, 1);
								setComponentAlignment(cancel, Alignment.TOP_RIGHT);

								Button ok = new Button("Save");
								ok.addStyleName("wide");
								ok.addStyleName("default");
								ok.addClickListener(new ClickListener() {
									@Override
									public void buttonClick(ClickEvent event) {
										String summary_service = "";
										for (String item : checkedService) {
											summary_service += item +",";
											try {
												int ret = managerRepositoryService.insertServiceAssetsXlocal(item, name_local_service);
											} catch (Exception e) {
												e.printStackTrace();
												MessageBox.showPlain(Icon.ERROR, "Error", "Fail to insert the List of Services: "+ summary_service, ButtonId.CLOSE);
																
											}
										}
										checkedService = null;
										wLocal.close();
										ModelSession model = UtilNavigation.getModel();
										model.setInizialized(true);
										Navigator nav = UtilNavigation.getNavigator();
										nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());

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
		return addAttributeBt;
	}

	protected CheckBox chkServiceDetail(final String name_service) {
		final CheckBox chk_row = new CheckBox();
		chk_row.setValue(false);
		chk_row.setImmediate(true);
		chk_row.addValueChangeListener(new ValueChangeListener() {

			private static final long serialVersionUID = 6945720283954181823L;

			@Override
			public void valueChange(ValueChangeEvent event) {
				boolean hasNameService = false;
				for (String item : checkedService) {
					if (item.equalsIgnoreCase(name_service)) {
						hasNameService = true;
						break;
					}
				}
				if (!hasNameService && chk_row.getValue()) {
					checkedService.add(name_service);
				} else if (!chk_row.getValue()) {
					checkedService.remove(name_service);
				}
			}
		});
		return chk_row;
	}
	
	private Button publishPublicService(final String name_service) {

		
		Button publish = new Button("Publish");
		publish = new Button("Publish");

		publish.addClickListener(new ClickListener() {
			
			private static final long serialVersionUID = 1L;

			@SuppressWarnings({ "serial", "deprecation" })
			@Override
			public void buttonClick(ClickEvent event) {
				final Window w = new Window("Public Service: "+ name_service);

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
											final Window w1 = new Window("Publish Service");
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
								                                    		
								                                    		Boolean ret = rest_client.instantiateTemplates(selectedTemplate,map_prop);
								                                    		if (ret) {

								                                    			try {
																					managerRepositoryService.publishPublicService(name_service);
																					
																					// afantini
																					CmServiceApiClient cmClient = CmServiceApiClient.getInstance();
								                                    				ServiceResourceExtended service = new ServiceResourceExtended();
								                                    				service.setServiceName(name_service);
								                                    				service.setServiceUrl(RestConfigUtils.getAssetRestBaseUrl()+"/"+name_service); //TODO valorizare campi correttamente
								                                    				if(!cmClient.createService(service)){
								                                    					MessageBox.showPlain(Icon.ERROR, "Publish", "Publish Service failure", de.steinwedel.messagebox.ButtonId.OK);
								                                    					throw new RuntimeException();
								                                    				}
								                                    				// fine afantini
																				} catch (Exception e) {
																					e.printStackTrace();
																				}							                                    	
										                                        
																				w.close();
										                                        w1.close();
										                                        ModelSession model = UtilNavigation.getModel();
																				model.setInizialized(true);
																				Navigator nav = UtilNavigation.getNavigator();			
																				nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());
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
				int rit = managerRepositoryService.updatePublicService(name_local_service, descriptionService, ownerSelected);
				if (rit != 1) {
					MessageBox.showPlain(Icon.ERROR, "Update", "Object cannot be updated.", de.steinwedel.messagebox.ButtonId.OK);					
				} 
				else
				{

					ModelSession model = UtilNavigation.getModel();
					model.setInizialized(true);
					Navigator nav = UtilNavigation.getNavigator();
					nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());

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
