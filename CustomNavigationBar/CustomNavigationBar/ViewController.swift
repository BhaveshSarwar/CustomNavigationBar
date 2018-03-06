//
//  ViewController.swift
//  CustomNavigationBar
//
//  Created by ANkat on 3/6/18.
//  Copyright © 2018 Inspeero Technology. All rights reserved.
//

import UIKit

let navigationBarHeight = 60

class ViewController: UIViewController {

    enum CustomNavBarType {
        case withCustomBackButton
        case withoutCustomBackButton
        case withrightBarButtons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true //IMP step to hide defaultnavbar
        
        /*
         When you are refering controller level navigation bar below method will work
        */
//        setNavigationBar(withType: .withCustomBackButton)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        /*
         *  update all contents of global navigation bar by below method
         */
        updateNavigationBarcontents()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
 Custom Navigation bar with adding on particular view
 You can also go with the common option provided which can be enable through the appdelegate
 once you enable custom navigation bar from appdelegate you dont need to add by below procedure
*/
    func setNavigationBar(withType:CustomNavBarType){
        
        switch withType {
        case .withoutCustomBackButton:
            setNavigationBarWithoutCustomBackButton()
            break
        case .withCustomBackButton:
            setNavigationBarWithCustomBackButton()
            break
        default:
            break
        }
        

    }
    
    
    func updateNavigationBarcontents(){
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.customNavigationBar()?.setNavigationBarItems(title: "View Controller : \(self.navigationController?.viewControllers.count)",
            isCustomBackButton: false,
            rightBarButtonsCustomView: NSArray())
    }
    
    
    //MARK:- Navigation Bar Types
    
    //MARK: Without custom back button
    func setNavigationBarWithoutCustomBackButton(){
        //Initializing custom navigation bar
        let navigationBar =  CustomNavigationBar.addCustomNavigationBarOnView(viewToAdd: self.view,
                                                                              navigationaBarTitle: "Title",
                                                                              isCustomBackButton: false,
                                                                              rightBarButtons: NSArray(),
                                                                              customHeight: navigationBarHeight)
        
        navigationBar.dropShadow() // Custom dropshadow to navigation bar
    }
    
    //MARK:- With custom BackButton
    func setNavigationBarWithCustomBackButton(){
        
        //button height should be in prapotionate to the Navigation bar height
        let buttonHeight = Double(navigationBarHeight) * 0.7
        
        
        //Custom Back button
        let btnLeftMenu: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonHeight, height: buttonHeight))
        let backButtonImage = UIImage(named: "fancyBack")?.resizeImageWith(newSize: CGSize(width: buttonHeight,
                                                                                      height: buttonHeight))
        btnLeftMenu.setImage(backButtonImage, for: .normal)
        btnLeftMenu.clipsToBounds = false
        btnLeftMenu.adjustsImageWhenHighlighted = false
        btnLeftMenu.addTarget(self, action: #selector(backButtonAction(sender:)), for: UIControlEvents.touchUpInside)
        btnLeftMenu.imageView?.contentMode = .scaleAspectFit
        btnLeftMenu.imageView?.clipsToBounds = false
        btnLeftMenu.accessibilityLabel = "back"
        btnLeftMenu.accessibilityValue = "back"
        
        //Initializing custom navigation bar
        let navigationBar =  CustomNavigationBar.addCustomNavigationBarOnView(viewToAdd: self.view,
                                                                              navigationaBarTitle: "View Controller : \(navigationController?.viewControllers.count)",
            backButton: btnLeftMenu,
            isCustomBackButton: true,
            rightBarButtons: NSArray(),
            customHeight: navigationBarHeight)
        
        navigationBar.dropShadow() // Custom dropshadow to navigation bar
    }
    
    
    //MARK: Button Actions
    
    @objc func backButtonAction(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

