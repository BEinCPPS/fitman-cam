package it.eng.asset.component;

import it.eng.asset.bean.AssetClass;
import it.eng.asset.resources.ConstantsView;
import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;
import it.eng.asset.utils.UtilNavigation;
import it.eng.asset.view.vaadin.ModelSession;

import java.util.ArrayList;
import java.util.List;

import com.vaadin.data.Item;
import com.vaadin.data.Property;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.event.Action;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.navigator.Navigator;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.FormLayout;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Notification;
import com.vaadin.ui.TextField;
import com.vaadin.ui.Tree;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;

import de.steinwedel.messagebox.ButtonId;
import de.steinwedel.messagebox.Icon;
import de.steinwedel.messagebox.MessageBox;

@SuppressWarnings("serial")
public class TreeMenu extends VerticalLayout implements
        Property.ValueChangeListener, Button.ClickListener, Action.Handler {

    // Actions for the context menu
    private static final Action ACTION_ADD = new Action("Add child");
    private static final Action MOVE = new Action("Move");
    private static final Action ACTION_DELETE = new Action("Delete");
    private static final Action[] ACTIONS = new Action[] { ACTION_ADD, MOVE,
            ACTION_DELETE };

    private VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();

    private final TextField name_class_insert = new TextField("Name: ");
    private String moveTo = "";
    private Tree tree;
    private String selectTarget;

    public String getSelectTarget() {
		return selectTarget;
	}

	public void setSelectTarget(String selectTarget) {
		this.selectTarget = selectTarget;
	}

	HorizontalLayout editBar;
    private TextField editor;

    public TreeMenu() {
        setSpacing(true);

        
        // Create the Tree,a dd to layout
        tree = new Tree();
        
        

        // Contents from a (prefilled example) hierarchical container:
        try {
			tree = assetTree();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		}
        tree.addListener(this);
        tree.addActionHandler(this);
        tree.setImmediate(true);
        for (Object id : tree.rootItemIds()) {
            tree.expandItemsRecursively(id);
        }

		ModelSession model = UtilNavigation.getModel();
		model.setInizialized(true);
		Navigator nav = UtilNavigation.getNavigator();
		String name_class = null;
    	if (model.getClass_name() != null) {
			name_class = model.getClass_name();
	    	tree.select(name_class);
    	}


        
        editBar = new HorizontalLayout();
        editBar.setEnabled(false);
        addComponent(tree);
        addComponent(editBar);
    }

    public void valueChange(ValueChangeEvent event) {
        if (event.getProperty().getValue() != null ) {

        	
        		this.setSelectTarget(event.getProperty().getValue().toString());
				ModelSession model = UtilNavigation.getModel();
				model.setInizialized(true);
				if (model.getActive_tree() == 1 ) {
					model.setActive_tree(0);
					return;
				}
				model.setActive_tree(1);
				model.setClass_name(event.getProperty().getValue().toString());
				Navigator nav = UtilNavigation.getNavigator();
				nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());
        		
        	
        } 
    }

    public void buttonClick(ClickEvent event) {
        // If the edited value contains something, set it to be the item's new
        // 'name' property
        if (!editor.getValue().equals("")) {
            Item item = tree.getItem(tree.getValue());
            //Property name = item.getItemProperty(ExampleUtil.hw_PROPERTY_NAME);
            //name.setValue(editor.getValue());
        }
    }

    /*
     * Returns the set of available actions
     */
    public Action[] getActions(Object target, Object sender) {
        return ACTIONS;
    }

    /*
     * Handle actions
     */
    public void handleAction(Action action, Object sender,final Object target) {

    	this.setSelectTarget(target.toString());
        selectTarget = target.toString();

    	if (action == ACTION_ADD) {
        	
        	name_class_insert.setValue("");
            tree.setChildrenAllowed(target, true);
            tree.expandItem(target);

		    final Window w = new Window("Add New Class");
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
                            
                    		name_class_insert.setWidth(270, Unit.PIXELS);
                    		
                    		gridView.addComponent(name_class_insert);

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
                                	name_class_insert.setValue("");
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
                                public void buttonClick(ClickEvent event) {

                                	String class_name = name_class_insert.getValue();
                                	String class_name_reference = target.toString();
                                	if (!class_name.equals(""))
                                	{
                                    	String rit =  managerRepositoryService.insertClass(class_name , class_name_reference);

                        				if (!rit.equals("OK"))
                                    	{
                        					
                                    			Notification.show("Error",
                                    					rit,
                                    						Notification.Type.ERROR_MESSAGE);
                                	                                    	}     
                                    	else
                                    	{
                            				tree.addItem(class_name);
                    						tree.setParent(class_name, class_name_reference);
                                    		w.close();
                                    		
                            				ModelSession model = UtilNavigation.getModel();
                            				model.setInizialized(true);
                            				Navigator nav = UtilNavigation.getNavigator();
                            				nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());

                                    		
                                    	}
                                    	
                                	}
                                	else
                                	{
										MessageBox.showPlain(Icon.WARN, "Alert", "The field must be inserted", ButtonId.CLOSE);
                                	}
                                }
                            });
                            ok.setClickShortcut(KeyCode.ENTER, null);
                            addComponent(ok);
                        }
                    });

                }
            });

            
           } else if (action == ACTION_DELETE) {
        	
        	final Object parent = tree.getParent(target);
        	
			MessageBox.showPlain(Icon.QUESTION, 
			        "Delete", 
			        "Do you want to delete this class?", 
			        new de.steinwedel.messagebox.MessageBoxListener() {
			                                        
			                @Override
			                public void buttonClicked(de.steinwedel.messagebox.ButtonId buttonId) {
								if (buttonId.equals(ButtonId.YES)) {
									if (selectTarget=="root") {
										MessageBox.showPlain(Icon.ERROR, "Error", "The root node can not be deleted.", ButtonId.CLOSE);
									}
									else {
										String rit =  managerRepositoryService.deleteClass(selectTarget);
										selectTarget = "";
										if (rit.equals("OK"))
										{
											selectTarget = "";
											tree.removeItem(target);
				                    		if (parent != null && tree.getChildren(parent) != null && tree.getChildren(parent).size() == 0) {
								                tree.setChildrenAllowed(parent, false);
								            }	
				                    		//Refresh delete for right panel.
				                    		ModelSession model = UtilNavigation.getModel();
				            				model.setInizialized(true);
				            				model.setClass_name("");
				            				Navigator nav = UtilNavigation.getNavigator();
	                        				nav.navigateTo("/" + ConstantsView.Views.assetRepositoryView.name());
				                    		
										}
										else {
										
											MessageBox.showPlain(Icon.ERROR, "Error", rit, ButtonId.CLOSE);
											
										}
									}

								} 
			                }
			        }, 
			        de.steinwedel.messagebox.ButtonId.YES, 
			        de.steinwedel.messagebox.ButtonId.NO);
            
        } else if (action == MOVE) {
        	 	final Window w1 = new Window("Move Class");

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
			                ComboBox combo_class = classComboBox();
			                combo_class.setWidth(270, Unit.PIXELS);
			                FormLayout gridView = new FormLayout();
			        		gridView.addComponent(combo_class);
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
			                    	moveTo = "";
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
			                    public void buttonClick(ClickEvent event) {
			                    	if (!moveTo.equals("")) {
				                    	String rit =  managerRepositoryService.MoveClass(target.toString() , moveTo);
				                    	if (!rit.equals("OK"))
				                    	{
											MessageBox.showPlain(Icon.ERROR, rit, "This class can not be moved.", ButtonId.CLOSE);
				                    	}
				                    	else {
				                    		
				                    		moveTo="";
				                    		w1.close();

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
    }
    
    
	private Tree assetTree() {

		Tree tree = new Tree();
		 List<AssetClass> lAss = new ArrayList<AssetClass>();
		 lAss = managerRepositoryService.getAllClasses();
		 int i = 1;
		 for(AssetClass object: lAss){
			 String name = object.getName();
			 if (i==1){
				 
				 this.setSelectTarget(object.getName());
				 tree.addItem(name);				 
				 String nameReference = object.getNameClassReference();
				 if (nameReference != null) {
						tree.setParent(name, nameReference);
				 }

			 }
			 else 
			 {
			 	 tree.addItem(name);				 
				 String nameReference = object.getNameClassReference();
				 if (nameReference != null) {
						tree.setParent(name, nameReference);
				 }

			}

//			 if (i==1){
//			 }
//			 else if (i==2)
//			 {
//				 this.setSelectTarget(object.getName());
//				 tree.addItem(name);				 
//				 String nameReference = object.getNameClassReference();
//				 if (nameReference != null) {
//						tree.setParent(name, nameReference);
//				 }
//
//			 } else {
//				 tree.addItem(name);				 
//				 String nameReference = object.getNameClassReference();
//				 if (nameReference != null) {
//						tree.setParent(name, nameReference);
//				 }
//
//			}
			 i = i +1;

				 
		 }
				
		return tree;
	}
    
	@SuppressWarnings("deprecation")
	private ComboBox classComboBox() {

		final ComboBox combo_class = new ComboBox("Parent: ");
    	combo_class.setInvalidAllowed(false);
		combo_class.setNullSelectionAllowed(false);
        combo_class.setImmediate(true);				            		 
        combo_class.addListener(new ValueChangeListener() {
			
			@Override
			public void valueChange(ValueChangeEvent event) {
			     if (combo_class.getValue() != null) {
			    	 moveTo = (String) combo_class.getValue();
                 }	
			}
		});

		List<AssetClass> lAss = new ArrayList<AssetClass>();
		 lAss = managerRepositoryService.getAllClasses();
		 int i= 1;
		 for(AssetClass object: lAss){
			 if (i==1){
			 }
			 else {
			 combo_class.addItem(object.getName());
			 }
			 i++;
		 }
		return combo_class;
	}
}
