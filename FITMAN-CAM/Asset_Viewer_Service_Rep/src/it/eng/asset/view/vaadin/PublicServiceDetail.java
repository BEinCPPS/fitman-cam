package it.eng.asset.view.vaadin;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetExtended;
import it.eng.asset.bean.PropertyUSDL;
import it.eng.asset.bean.PublicService;
import it.eng.asset.resources.ConstantsView;
import it.eng.asset.service.AssetService;
import it.eng.asset.service.IAssetService;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.asset.utils.RestConfigUtils;
import it.eng.asset.utils.UtilNavigation;
import it.eng.msee.ontorepo.Util;
import it.eng.vam.rest.RestClientNimbus;
import it.eng.vam.rest.RestClientNimbusImpl;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
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

public class PublicServiceDetail extends VerticalLayout implements View {

	private PagedTable classGrid = new PagedTable("");
	// private HorizontalLayout tabControl = new HorizontalLayout();
	private static final long serialVersionUID = 1085005971972994377L;
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private Table compactView;
	private GridLayout detail;
	private HorizontalLayout detailButton;
	private GridLayout pannelDt;
	private TextArea descriptionDt;
	final Window wAsset = new Window();
	private Button addAsset = new Button("Add Asset");
	private Button saveButton = new Button("Save");
	private Boolean publish_online = true;
	final List<TextField> list_item = new ArrayList<TextField>();
	private List<String> checkedService = new ArrayList<String>();

	final VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
	private static final IAssetService assetService = AssetService.getAssetService();
	List<Asset> assetList = new ArrayList<Asset>();
	PublicService publicS = new PublicService();
	String basepath = VaadinService.getCurrent().getBaseDirectory().getAbsolutePath();
	String serviceName = "";

	String descriptionPublicService = "";
	String ownerSelected = "";
	String selectedTemplate = "";

	@Override
	public void enter(ViewChangeEvent event) {

		ModelSession model = UtilNavigation.getModel();

		if (AssetComposingUI.getModel().getInizialized() == null)
			return;

		addComponent(BreadCrumb.getAssetBreadCrumb(ConstantsView.Views.publicServiceView.name(), model.getService_name()));

		serviceName = model.getService_name();
		initLayout();

	}

	private void initLayout() {

		try {
			this.publicS = managerRepositoryService.getPublicService(serviceName);
			if (null != publicS.getName() && !publicS.getName().isEmpty()) {
				this.assetList = assetService.retrieveAssetsByServiceId(publicS.getIdService().longValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
			MessageBox.showPlain(Icon.ERROR, "Error", "Could not load Assets", de.steinwedel.messagebox.ButtonId.OK);
			return;
		}

		// if (!publicS.getNameAsset().equals("")) {
		// this.obj_asset =
		// managerRepositoryService.getAssetFromName(publicS.getNameAsset());
		// } else {
		// this.obj_asset.setName("");
		// }

		setMargin(true);
		detail = new GridLayout(4, 6);
		detail.setHeight("230px");
		detail.setWidth("800px");
		initFormDetails();

		HorizontalLayout space = new HorizontalLayout();
		space.setHeight("10px");

		HorizontalLayout space1 = new HorizontalLayout();
		space1.setHeight("10px");

		compactView = new Table();
		compactView = initList();
		compactView.setSizeFull();
		// compactView.setHeight("60px");
		// compactView.setWidth("730px");

		VerticalLayout spaceVert = new VerticalLayout();
		spaceVert.setWidth("130px");

		detailButton = new HorizontalLayout();
		addAsset = addAssetToPublicServiceButton(publicS.getName());
		detailButton.addComponent(addAsset, 0);
		detailButton.setComponentAlignment(addAsset, Alignment.BOTTOM_LEFT);

		HorizontalLayout sp2 = new HorizontalLayout();
		sp2.setHeight("7px");
		sp2.setWidth("622px");
		HorizontalLayout rigth = new HorizontalLayout();
		rigth.addComponent(sp2, 0);

		saveButton = savePublicServiceButton(publicS.getName());
		rigth.addComponent(saveButton, 1);
		rigth.setComponentAlignment(saveButton, Alignment.BOTTOM_RIGHT);
		detailButton.addComponent(rigth);
		pannelDt = new GridLayout(2, 5);
		pannelDt.addComponent(spaceVert, 0, 0);
		pannelDt.addComponent(detail, 1, 0);
		pannelDt.addComponent(space, 1, 1);
		pannelDt.addComponent(compactView, 1, 2);
		pannelDt.addComponent(space1, 1, 3);
		pannelDt.addComponent(detailButton, 1, 4);
		//
		// pannelDt.setComponentAlignment(detail, Alignment.TOP_LEFT);
		// pannelDt.setComponentAlignment(compactView, Alignment.MIDDLE_CENTER);

		addComponent(pannelDt);

	}

	@SuppressWarnings("deprecation")
	private void initFormDetails() {

		// Label nameLabelDt;
		// nameLabelDt = new Label(publicS.getName());
		// nameLabelDt.addStyleName(Reindeer.LABEL_H2);
		// detail.addComponent(nameLabelDt, 0, 0, 2, 0);

		Label descrCV;
		descrCV = new Label("<b>Description: &nbsp;&nbsp;</b>", Label.CONTENT_XHTML);
		descriptionDt = new TextArea();
		descriptionDt.setValue(publicS.getServiceDescription());
		descriptionDt.setWordwrap(true);
		descriptionDt.setWidth("700px");
		descriptionDt.setRows(2);
		descriptionDt.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);
		descriptionDt.setImmediate(true);
		Collection<Validator> collVal = descriptionDt.getValidators();
		if (collVal.size() == 0) {

			descriptionDt.addValidator(new StringLengthValidator("Must be " + Util.MIN_NAME_LENGTH + " to " + UtilNavigation.MAX_DESCRIPTION_SERVICE + " characters long", Util.MIN_NAME_LENGTH, UtilNavigation.MAX_DESCRIPTION_SERVICE, false));
			descriptionDt.setMaxLength(UtilNavigation.MAX_DESCRIPTION_SERVICE);

		}

		detail.addComponent(descrCV, 0, 1);
		detail.addComponent(descriptionDt, 1, 1, 3, 1);

		Label dateCreationCv = new Label("<b>Created:</b>", Label.CONTENT_XHTML);
		String data = "";
		if (publicS.getCreated() != null) {
			try {
				data = sdf.format(sdf.parse(publicS.getCreated()));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Label dateCreationValCv = new Label();
		dateCreationValCv.setValue(data);
		dateCreationValCv.addStyleName(Reindeer.LABEL_SMALL);
		detail.addComponent(dateCreationCv, 0, 2);
		detail.addComponent(dateCreationValCv, 1, 2);
		detail.setComponentAlignment(dateCreationCv, Alignment.MIDDLE_LEFT);
		detail.setComponentAlignment(dateCreationValCv, Alignment.MIDDLE_CENTER);

		Label datePubblicationCv = new Label("<b>Published:</b>", Label.CONTENT_XHTML);
		String publ = "";
		if (publicS.getPublishedDate() != null) {
			try {
				publ = sdf.format(sdf.parse(publicS.getPublishedDate()));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Label datePubblicationValCv = new Label();
		datePubblicationValCv.setValue(publ);
		datePubblicationValCv.addStyleName(Reindeer.LABEL_SMALL);

		HorizontalLayout btn = new HorizontalLayout();

		// FINE LISTENER
		// Button del_local_service = deleteServiceButton(localName);
		Button publish = publishService(publicS.getName());

		HorizontalLayout spa = new HorizontalLayout();
		spa.setWidth("5px");
		spa.setHeight("3px");
		btn.addComponent(publish, 0);
		btn.addComponent(spa, 1);
		// btn.addComponent(del_local_service, 2);
		detail.addComponent(datePubblicationCv, 0, 3);
		detail.addComponent(datePubblicationValCv, 1, 3);
		detail.addComponent(btn, 2, 3);
		detail.setComponentAlignment(datePubblicationCv, Alignment.MIDDLE_LEFT);
		detail.setComponentAlignment(datePubblicationValCv, Alignment.MIDDLE_CENTER);
		detail.setComponentAlignment(btn, Alignment.MIDDLE_LEFT);

		Label owner = new Label("<b>Owner:</b>", Label.CONTENT_XHTML);
		// org.addStyleName(Reindeer.LABEL_SMALL);
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
		if (publicS.getOwner() != null) {

			selectOR.setValue(publicS.getOwner());

		}
		detail.addComponent(owner, 0, 4);
		detail.addComponent(selectOR, 1, 4);

		HorizontalLayout spacedet = new HorizontalLayout();
		spacedet.setWidth("60px");
		detail.addComponent(spacedet, 0, 5);

	}

	@SuppressWarnings({ "unchecked" })
	private PagedTable initList() {

		String view = "";
		String classT = "Class";
		String asset = "Asset";
		String model = "Model";
		String owner = "Owner";
		String created = "Created";
		// String desc = "Service Description";

		Label actionDel = new Label(".");
		// actionDel.addStyleName(Reindeer.);

		IndexedContainer ic_asset = new IndexedContainer();
		PagedTable Pagedtable = new PagedTable();

		ic_asset.addContainerProperty(asset, String.class, null);
		ic_asset.addContainerProperty(owner, String.class, null);
		ic_asset.addContainerProperty(classT, String.class, null);
		ic_asset.addContainerProperty(model, String.class, null);
		ic_asset.addContainerProperty(created, String.class, null);
		ic_asset.addContainerProperty(actionDel, Button.class, null);
		ic_asset.addContainerProperty(view, Button.class, null);

		for (Asset obj_asset : this.assetList) {
			Object id = ic_asset.addItem();
			ic_asset.getContainerProperty(id, asset).setValue(obj_asset.getName());
			if (obj_asset.getOwner() != null) {
				ic_asset.getContainerProperty(id, owner).setValue(obj_asset.getOwner());
			} else {
				ic_asset.getContainerProperty(id, owner).setValue("");

			}

			ic_asset.getContainerProperty(id, owner).setValue(obj_asset.getOwner());
			if (obj_asset.getAssetClass() != null) {
				ic_asset.getContainerProperty(id, classT).setValue(obj_asset.getAssetClass());
			} else {
				ic_asset.getContainerProperty(id, classT).setValue("");

			}

			ic_asset.getContainerProperty(id, model).setValue(obj_asset.getModel());
			if (obj_asset.getCreated() != null) {
				ic_asset.getContainerProperty(id, created).setValue(sdf.format(obj_asset.getCreated()));
			} else {
				ic_asset.getContainerProperty(id, created).setValue("");
			}
			if (!obj_asset.getName().equals("")) {
				ic_asset.getContainerProperty(id, view).setValue(viewServiceDetailButton(obj_asset.getName(), obj_asset.getAssetClass()));
				ic_asset.getContainerProperty(id, actionDel).setValue(deleteGridAssetButton(obj_asset.getName()));
			}
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
		viewButton.setIcon(new FileResource(new File(basepath + "/WEB-INF/Images/view.gif")));

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

	protected Button deleteGridAssetButton(final String asset_name) {
		Button deleteButton = new Button();
		deleteButton.setStyleName(Reindeer.BUTTON_SMALL);
		deleteButton.addStyleName("msee_button");
		deleteButton.setIcon(new FileResource(new File(basepath + "/WEB-INF/Images/delete16.png")));

		deleteButton.addClickListener(new ClickListener() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			@Override
			public void buttonClick(ClickEvent event) {

				MessageBox.showPlain(Icon.QUESTION, "Remove Asset", "Do you really want to remove the " + asset_name + " asset?", new de.steinwedel.messagebox.MessageBoxListener() {

					@Override
					public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
						if (buttonId.equals(ButtonId.YES)) {
							try {// TODO
								AssetExtended ae = new AssetExtended();
								ae.setAssetName(asset_name);
								assetService.deleteServiceAsset(publicS.getIdService(), ae);
								// managerRepositoryService
								// .updateassetLocalService(asset_name);

								ModelSession model = UtilNavigation.getModel();
								model.setInizialized(true);
								Navigator nav = UtilNavigation.getNavigator();
								nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());

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

	protected Button addAssetToPublicServiceButton(final String serviceName) {
		Button addAttributeBt = new Button("Add Asset");
		addAttributeBt.setIcon(new FileResource(new File(basepath + "/WEB-INF/Images/add16.png")));
		// addAttributeBt.setWidth("150px");

		addAttributeBt.addClickListener(new ClickListener() {

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
								initClassGridtable(serviceName);
								fl.setSpacing(true);
								fl.addComponent(classGrid);
								// tabControl.addComponent(classGrid
								// .createControls());
								fl.addComponent(classGrid.createControls());
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

								HorizontalLayout buttons = new HorizontalLayout();
								buttons.setWidth("27%");
								Button cancel = new Button("Close");
								cancel.setIcon(new FileResource(new File(ConstantsView.CROSS_ICON)));
								cancel.addClickListener(new ClickListener() {
									@Override
									public void buttonClick(ClickEvent event) {
										wAsset.close();
										checkedService.clear();
									}
								});
								cancel.setClickShortcut(KeyCode.ESCAPE, null);

								Button ok = new Button("Save");
								ok.addStyleName("wide");
								ok.addStyleName("default");
								ok.setIcon(new FileResource(new File(ConstantsView.TICK_ICON)));
								ok.addClickListener(new ClickListener() {
									@Override
									public void buttonClick(ClickEvent event) {
										String summary_service = "";
										try {
											// assetService.addServiceAssets(publicS.getIdService(),
											// checkedService);
											// int ret =
											// managerRepositoryService.insertServiceAssetsXlocal(item,
											// name_local_service); //TODO
											assetService.addServiceAssets(publicS.getIdService(), checkedService);
										} catch (Exception e) {
											e.printStackTrace();
											MessageBox.showPlain(Icon.ERROR, "Error", "Fail to insert the List of Services: " + summary_service, ButtonId.CLOSE);

										}
										// for (String item : checkedService) {
										// summary_service += item +",";
										// }
										checkedService = null;
										wAsset.close();
										ModelSession model = UtilNavigation.getModel();
										model.setInizialized(true);
										Navigator nav = UtilNavigation.getNavigator();
										nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());

									}
								});
								ok.setClickShortcut(KeyCode.ENTER, null);

								buttons.addComponent(cancel);
								buttons.setExpandRatio(cancel, 1);
								buttons.setComponentAlignment(cancel, Alignment.MIDDLE_RIGHT);

								buttons.addComponent(ok);
								buttons.setExpandRatio(ok, 1);
								buttons.setComponentAlignment(ok, Alignment.MIDDLE_RIGHT);

								addComponent(buttons);
								setComponentAlignment(buttons, Alignment.MIDDLE_RIGHT);
							}
						});

					}
				});

			}

		});
		return addAttributeBt;
	}

	@SuppressWarnings("unchecked")
	private void initClassGridtable(String name_service_select) {

		IndexedContainer ic_asset = new IndexedContainer();

		classGrid.addStyleName("reindeer");
		classGrid.setPageLength(10);

		String classT = "Class";
		String name = "Asset";
		String model = "Model";
		String owner = "Owner";
		String created = "Created";
		String selected = "'";

		ic_asset.addContainerProperty(name, String.class, null);
		ic_asset.addContainerProperty(classT, String.class, null);
		ic_asset.addContainerProperty(model, String.class, null);
		ic_asset.addContainerProperty(owner, String.class, null);
		ic_asset.addContainerProperty(created, String.class, null);
		ic_asset.addContainerProperty(selected, CheckBox.class, null);

		List<Asset> lAss = new ArrayList<Asset>();
		lAss = managerRepositoryService.getAsset2Select();

		List<Asset> availableAssets = new ArrayList<Asset>();
		for (Asset object : lAss) {
			boolean isContained = false;
			for (Asset assetItem : assetList) {
				if (object.getName().equals(assetItem.getName())) {
					isContained = true;
					break;
				}
			}
			if (!isContained) {
				availableAssets.add(object);
			}
		}

		for (Asset object : availableAssets) {

			Object id = ic_asset.addItem();

			ic_asset.getContainerProperty(id, name).setValue(object.getName());

			if (object.getAssetClass() != null) {
				ic_asset.getContainerProperty(id, classT).setValue(object.getAssetClass());
			} else {
				ic_asset.getContainerProperty(id, classT).setValue("");
			}

			if (object.getModel() != null) {
				ic_asset.getContainerProperty(id, model).setValue(object.getModel());
			} else {
				ic_asset.getContainerProperty(id, model).setValue("");
			}
			ic_asset.getContainerProperty(id, owner).setValue(object.getOwner());

			if (object.getCreated() != null)
				ic_asset.getContainerProperty(id, created).setValue(sdf.format(object.getCreated()));
			else
				ic_asset.getContainerProperty(id, created).setValue("");

			ic_asset.getContainerProperty(id, selected).setValue(chkServiceDetail(object.getName()));

		}
		classGrid.setContainerDataSource(ic_asset);

		classGrid.setColumnWidth(name, 186);
		classGrid.setColumnWidth(classT, 50);
		classGrid.setColumnWidth(model, 126);
		classGrid.setColumnWidth(owner, 50);
		classGrid.setColumnWidth(created, 70);
		classGrid.setColumnWidth(selected, 27);

		classGrid.setColumnAlignment(name, Align.LEFT);
		classGrid.setColumnAlignment(classT, Align.LEFT);
		classGrid.setColumnAlignment(model, Align.LEFT);
		classGrid.setColumnAlignment(owner, Align.LEFT);
		classGrid.setColumnAlignment(created, Align.CENTER);
		classGrid.setColumnAlignment(selected, Align.CENTER);

		classGrid.setColumnHeader(selected, "");

		classGrid.setSelectable(true);
		classGrid.setImmediate(true);
		classGrid.setSortEnabled(true);

	}

	protected CheckBox chkServiceDetail(final String assetName) {
		final CheckBox chk_row = new CheckBox();
		chk_row.setValue(false);
		chk_row.setImmediate(true);
		chk_row.addValueChangeListener(new ValueChangeListener() {

			private static final long serialVersionUID = 6945720283954181823L;

			@Override
			public void valueChange(ValueChangeEvent event) {
				boolean hasNameService = false;
				for (String item : checkedService) {
					if (item.equalsIgnoreCase(assetName)) {
						hasNameService = true;
						break;
					}
				}
				if (!hasNameService && chk_row.getValue()) {
					checkedService.add(assetName);
				} else if (!chk_row.getValue()) {
					checkedService.remove(assetName);
				}
			}
		});
		return chk_row;
	}

	private Button publishService(final String name_service) {

		Button publish = new Button("Publish");
		publish.setIcon(new FileResource(new File(ConstantsView.PUBLISH_ICON)));
		publish.addStyleName("wide");
		publish.addStyleName("default");

		publish.addClickListener(new ClickListener() {

			private static final long serialVersionUID = 1L;

			@SuppressWarnings({ "serial", "deprecation" })
			@Override
			public void buttonClick(ClickEvent event) {
				final Window w = new Window("Publish Aaas: " + name_service);

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
								cancel.setIcon(new FileResource(new File(ConstantsView.CROSS_ICON)));
								cancel.addStyleName("wide");
								cancel.addStyleName("default");
								cancel.setWidth("76px");
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
								ok.setIcon(new FileResource(new File(ConstantsView.NEXT_ICON)));
								ok.setWidth("76px");
								ok.addStyleName("wide");
								ok.addStyleName("default");
								ok.addClickListener(new ClickListener() {
									@Override
									public void buttonClick(ClickEvent event) {

										if (selectedTemplate.equals("")) {

											MessageBox.showPlain(Icon.WARN, "Alert", "Template is required.", ButtonId.CLOSE);

										} else {
											// w.close();
											final Window w1 = new Window("Local Service: " + name_service);
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

																TextField propTempl = new TextField(obj_prop.getName());
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
															
															Button prev = new Button("Prev");
															prev.setIcon(new FileResource(new File(ConstantsView.PREV_ICON)));
															prev.setWidth("76px");
															prev.addClickListener(new ClickListener() {
																@Override
																public void buttonClick(ClickEvent event) {
																	w1.close();
																}
															});
															prev.setClickShortcut(KeyCode.ESCAPE, null);
															addComponent(prev);
															setExpandRatio(prev, 1);
															setComponentAlignment(prev, Alignment.TOP_LEFT);
															

															Button cancel_step1 = new Button("Cancel");
															cancel_step1.setIcon(new FileResource(new File(ConstantsView.CROSS_ICON)));
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

															Button ok = new Button("Publish");
															ok.setIcon(new FileResource(new File(ConstantsView.TICK_ICON)));
															ok.addStyleName("wide");
															ok.addStyleName("default");
															ok.addClickListener(new ClickListener() {
																@Override
																public void buttonClick(ClickEvent event) {

																	try {

																		if (publish_online) {
																			RestClientNimbus rest_client = new RestClientNimbusImpl();
																			Map<String, String> map_prop = new HashMap<String, String>();
																			for (TextField field : list_item) {
																				map_prop.put(field.getCaption(), field.getValue());
																			}
																			boolean ret = rest_client.instantiateTemplates(selectedTemplate, map_prop);
																			if (ret) {
																				try {
																					managerRepositoryService.publishPublicService(name_service); // TODO
																																					// remove
																																					// comment
																																					// for
																																					// deploy
																																					// afantini
																					CmServiceApiClient cmClient = CmServiceApiClient.getInstance();
																					ServiceResourceExtended service = new ServiceResourceExtended();
																					service.setServiceName(name_service);
																					service.setServiceUrl(RestConfigUtils.getAssetRestBaseUrl() + "/" + name_service); 
																					service.setServiceRegDate(new Date());
																					long loggedInUserId = AssetComposingUI.getModel().getLoggedInUser() != null? AssetComposingUI.getModel().getLoggedInUser().getUserId():0L;
																					service.setLocalUserLastEditorId(1L); //TODO use lr user, fk problem
																					service.setStoreId(1L);
																					
																					if (loggedInUserId != 0 && !cmClient.createService(service)) {
																						MessageBox.showPlain(Icon.ERROR, "Publish", "Publish Service failure", de.steinwedel.messagebox.ButtonId.OK);
																						throw new RuntimeException();
																					}

																				} catch (Exception e) {
																					e.printStackTrace();
																				}
																				w.close();
																				w1.close();
																				ModelSession model = UtilNavigation.getModel();
																				model.setInizialized(true);
																				Navigator nav = UtilNavigation.getNavigator();
																				nav.navigateTo("/" + ConstantsView.Views.publicServiceView.name());
																			} else {

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

		return publish;

	}

	protected Button savePublicServiceButton(final String name_public_service) {
		Button addAttributeBt = new Button("Save");
		// addAttributeBt.setWidth("150px");
		addAttributeBt.setIcon(new FileResource(new File(ConstantsView.TICK_ICON)));

		addAttributeBt.addClickListener(new ClickListener() {

			private static final long serialVersionUID = 1L;

			@SuppressWarnings({})
			@Override
			public void buttonClick(ClickEvent event) {
				String descriptionService = descriptionDt.getValue();
				int rit = managerRepositoryService.updatePublicService(name_public_service, descriptionService, ownerSelected);
				if (rit != 1) {
					MessageBox.showPlain(Icon.ERROR, "Update", "Object cannot be updated.", de.steinwedel.messagebox.ButtonId.OK);
				} else {

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

		if (!publish_online) {

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
