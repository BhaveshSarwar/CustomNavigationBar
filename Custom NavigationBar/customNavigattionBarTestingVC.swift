//
//  customNavigattionBarTestingVC.swift
//  InspeeroLib
//
//  Created by ANkat on 2/26/18.
//  Copyright © 2018 inspeero. All rights reserved.
//

import UIKit

class customNavigattionBarTestingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        
//      let navigationBar =  CustomNavigationBar.addCustomNavigationBarOnView(viewToAdd: self.view,
//                                                                            navigationaBarTitle: "Title",
//                                                                            isCustomBackButton: false,
//                                                                            rightBarButtons: NSArray(),
//                                                                            customHeight: 100)
//        navigationBar.dropShadow()
        


        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.customNavigationBar()?.setNavigationBarItems(title: "View Controller : \(self.navigationController?.viewControllers.count)",
                                                            isCustomBackButton: false,
                                                            rightBarButtonsCustomView: NSArray())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
