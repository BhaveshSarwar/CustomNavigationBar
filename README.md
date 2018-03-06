# CustomNavigationBar
Navigation bar with customize height 

This can help to customise the height of navigation bar
Navigation bar provides default back button and title


There are two types to use custom navigation bar
1. Global navigation bar
      Global navigation bar is configured from the appdelegate. it will work same throughout the app 
    you dont need to add navigation bar in every view controller. once it has been configured it will be steady throughout the app

  To use this You have to follow steps
    - Enable navigation bar from the AppDelegate
   
   #AppDelegate.swift

        CustomNavigationBar.enableGlobalCustomNavigationBar(forWindow: self.window!, customHeight: 80)
        
 #ViewController.swift
    - Update contents of navigation bar in each viewcontroller so navigation bar will be steady but the contents can be reconfigured
      there will not be any kind of redraw and animation in Navigation bar
        
        //WITHOUT CUSTOMISE BACK BUTTON (it will use default back button)
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.customNavigationBar()?.setNavigationBarItems(title: "Title",
                                                            isCustomBackButton: false,
                                                            rightBarButtonsCustomView: NSArray())
                                                            
                                                  
        //User can provide custom back button with
        //CUSTOM BACK BUTTON
        window.customNavigationBar()?.setNavigationBarItems(title: "Title",
                                                    isCustomBackButton: true,
                                                    rightBarButtonsCustomView: NSArray(),
                                                    backButton:customBackbutton)
  2. Local Navigation bar
        This navigation bar needs to be configured in each view controller. in this type of navigation bar will be tightly coupled to the viewController's view
    so this can also have push effect or any transition effect which are given to the view controller. This will also have same type with custom back button or without custom back button
    
            //WITHOUT CUSTOMISE BACK BUTTON (it will use default back button)

            let navigationBar =  CustomNavigationBar.addCustomNavigationBarOnView(viewToAdd: self.view,
            navigationaBarTitle: "Title",
            isCustomBackButton: false,
            rightBarButtons: NSArray(),
            customHeight: navigationBarHeight)
            
            //User can provide custom back button with
            //CUSTOM BACK BUTTON
            //Initializing custom navigation bar
            let navigationBar =  CustomNavigationBar.addCustomNavigationBarOnView(viewToAdd: self.view,
                                                                                navigationaBarTitle: "Title",
                                                                                backButton: btnLeftMenu,
                                                                                isCustomBackButton: true,
                                                                                rightBarButtons: NSArray(),
                                                                                customHeight: navigationBarHeight)
                                                                                
        EXTRA FEATURES
         - Navigation bar having custom shadow
         
             navigationBar.dropShadow()
