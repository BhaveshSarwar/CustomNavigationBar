# CustomNavigationBar
Navigation bar with customize height 

This can help to customise the height of navigation bar
Navigation bar provides default back button and title


There are two types to use custom navigation bar
1. Global navigatio bar
      Global navigation bar is configured from the appdelegate. it will work same throughout the app 
    you dont need to add navigation bar in every view controller. once it has been configured it will be steady throughout the app

  To use this You have to follow steps
    - Enable navigation bar from the AppDelegate
    
        CustomNavigationBar.enableGlobalCustomNavigationBar(forWindow: self.window!, customHeight: 80)  
     
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
  
