//
//  CustomNavigationBar.swift
//  CustomNavigationBar
//
//  Created by Bhavesh Sarwar on 20/01/18.
//  Copyright © 2018 Bhavesh Sarwar. All rights reserved.
//
struct ViewTags {
    static let customNavigationBar = 1011
    static let defaultBackButton = 1012
    static let defaultBlankButton = 1013
}
import UIKit
//protocol CustomNavigationBarDelegates {
//    func backButtonAction(sender:UIButton)
//}

@IBDesignable class CustomNavigationBar: UIView {

//    var delegate:CustomNavigationBarDelegates?
    
    //Components
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var leftButtonsStackView: UIStackView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rightButtonsStackView: UIStackView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
     //Constraints
    @IBOutlet weak var verticalCenterOfContents: NSLayoutConstraint!
    
    //Backbutton
    @IBOutlet weak var backButtonLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var backButtonWidth: NSLayoutConstraint!
    
    //Title
    @IBOutlet weak var titleLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var countLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabelTrailingSpace: NSLayoutConstraint!
    
    //Right bar buttons
    @IBOutlet weak var rightButtonsStackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var rightBarButtonsTrailingSpace: NSLayoutConstraint!
    
    let countLabelHeightConstant = 30.0
    let titleLabelTrailingSpaceConstant = 7.0
    let customShadowOpacity : Float = 0.56
    var defaultBackButtonImage = UIImage(named: "back")
    
    func configure(title:String , backButtonCustomView:UIButton? ,
         rightButtonsCustomViews:NSArray,
         barHeight:Int, count:Int? = nil ) {
        countLabelHeight.constant = CGFloat(countLabelHeightConstant)
        
//        backButtonLeadingSpace.constant = -(UIScreen.main.bounds.width * 0.0376)
        titleLeadingSpace.constant = (UIScreen.main.bounds.width * 0.0136)
        countLabel.layer.cornerRadius = countLabelHeight.constant/2
        countLabel.clipsToBounds = true

        if(count == nil){
            countLabel.isHidden = true
            titleLabelTrailingSpace.constant = 0
            countLabelHeight.constant = 0
        }else{
            if(count == 0){
                countLabel.isHidden = true
                titleLabelTrailingSpace.constant = 0
                countLabelHeight.constant = 0
            }else{
            countLabel.text = "\(count!)"
            }
        }
        
        
        let statusBarheight = UIApplication.shared.statusBarFrame.size.height
        self.frame = CGRect(x: 0, y: Int(statusBarheight), width: Int(UIScreen.main.bounds.size.width), height: barHeight)
        self.rightButtonsStackviewWidth.constant = 0
        self.title.text = title
        if backButtonCustomView != nil{
            backButtonCustomView?.isUserInteractionEnabled = true
            self.leftButtonsStackView.addArrangedSubview(backButtonCustomView!)
        }

        for button in rightButtonsCustomViews {
            let customView = (button as! UIView)
            rightButtonsStackviewWidth.constant = rightButtonsStackviewWidth.constant + customView.frame.size.width
            rightButtonsStackView.addArrangedSubview(customView)
            
        }
    }
    
     func dropShadow() {
        self.layer.shadowColor   = UIColor.gray.cgColor
        self.layer.shadowOffset  = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius  = 2.8
        self.layer.shadowOpacity = customShadowOpacity
        self.layer.masksToBounds = false
    }
    
    func hideShadowAndShowLineView()  {
        self.layer.shadowOpacity = 0
        self.separatorView.isHidden = false
    }
    
    func showShadowAndHideLineView()  {
         self.layer.shadowOpacity = customShadowOpacity
        self.separatorView.isHidden = true
    }
    
    class  func addCustomNavigationBarOnView(viewToAdd : UIView ,
                                             navigationaBarTitle : String ,
                                             backButton : UIButton? = nil,
                                             isCustomBackButton:Bool = false,
                                             rightBarButtons : NSArray,
                                             customHeight:Int)->CustomNavigationBar{
        let navigationBar = (Bundle.main.loadNibNamed("CustomNavigationBar", owner: self, options: nil)! as NSArray).firstObject as! CustomNavigationBar
        
        var customBackButton = backButton
        //Set default Backbutton
        if isCustomBackButton == false{
            if let navigationController = viewToAdd.viewController()?.navigationController {
                if navigationController.viewControllers.count > 1{
                    customBackButton = navigationBar.setDefaultBackButton( customHeight: Int(Double(customHeight) * 0.7))
                    customBackButton?.tag = ViewTags.defaultBackButton
                }
            }
        }
        
        navigationBar.configure(title: navigationaBarTitle ,
                                backButtonCustomView: customBackButton,
                                rightButtonsCustomViews: rightBarButtons,
                                barHeight: customHeight)
        navigationBar.tag = ViewTags.customNavigationBar
        navigationBar.dropShadow()
        viewToAdd.addSubview(navigationBar)
        return navigationBar

    }
    

    
    //MARK:- on window
    class func enableGlobalCustomNavigationBar(forWindow window:UIWindow , customHeight:Int){
        
        
        let navigationBar =  CustomNavigationBar.addCustomNavigationBarOnView(viewToAdd: window,
                                                                              navigationaBarTitle: "Title",
                                                                              isCustomBackButton: false,
                                                                              rightBarButtons: NSArray(),
                                                                              customHeight: customHeight)
        navigationBar.dropShadow()
    }
    
    override func layoutSubviews() {
        window?.bringSubview(toFront: self);
        
        //Remove back button from view if not more than one view controller is available
        if let navigationController = window?.rootViewController as? UINavigationController{
            if navigationController.viewControllers.count <= 1{
                if self.getDefaultBackButton() != nil{
                    self.getDefaultBackButton()?.removeFromSuperview()
//                    self.leftButtonsStackView.removeArrangedSubview(self.getDefaultBackButton()!)
                    
                }
            }
        }
    }
    
    func setNavigationBarItems(title:String,
                               isCustomBackButton:Bool,
                               rightBarButtonsCustomView:NSArray,
                               backButton:UIButton? = nil){
        
        
        
        var customBackButton = backButton
        //Set default Backbutton
        if isCustomBackButton == false{
            if let navigationController = window?.rootViewController as? UINavigationController{
                if navigationController.viewControllers.count > 1{
                    customBackButton = self.setDefaultBackButton( customHeight: Int(Double(self.frame.size.height) * 0.7))
                    customBackButton?.tag = ViewTags.defaultBackButton
                }
            }
        }

        if isCustomBackButton == false{
            if self.getDefaultBackButton() == nil{
                if customBackButton != nil{
                    customBackButton?.isUserInteractionEnabled = true
                    self.leftButtonsStackView.addArrangedSubview(customBackButton!)
                }
            }
        }else{
            //Remove all previous buttons
            removeAllLeftBarButtons()
            customBackButton?.isUserInteractionEnabled = true
            self.leftButtonsStackView.addArrangedSubview(customBackButton!)
        }
        self.rightButtonsStackviewWidth.constant = 0
        self.title.text = title
        
        removeAllRightBarButtons()
        for button in rightBarButtonsCustomView {
            let customView = (button as! UIView)
            rightButtonsStackviewWidth.constant = rightButtonsStackviewWidth.constant + customView.frame.size.width
            rightButtonsStackView.addArrangedSubview(customView)
        }
 
    }
    
    
    func removeAllLeftBarButtons(){
        //Remove all previous buttons
        for button in self.leftButtonsStackView.arrangedSubviews as! [UIButton]{
            button.removeFromSuperview()
        }
    }
    func removeAllRightBarButtons(){
        for button in self.rightButtonsStackView.arrangedSubviews as! [UIButton]{
            button.removeFromSuperview()
        }
    }
    
    
    
    
    //MARK:- DeFault buttons
    func setDefaultBackButton (customHeight:Int)->UIButton{
        let btnLeftMenu: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: customHeight, height: customHeight))
        let backButtonImage = (self.defaultBackButtonImage?.resizeImageWith(newSize: CGSize(width: customHeight, height: customHeight)))!
        btnLeftMenu.setImage(backButtonImage, for: .normal)
        btnLeftMenu.clipsToBounds = false
        btnLeftMenu.adjustsImageWhenHighlighted = false
        btnLeftMenu.addTarget(self, action: #selector(backButtonAction(sender:)), for: UIControlEvents.touchUpInside)
        btnLeftMenu.imageView?.contentMode = .scaleAspectFit
        btnLeftMenu.imageView?.clipsToBounds = false
        btnLeftMenu.accessibilityLabel = "back"
        btnLeftMenu.accessibilityValue = "back"
        return btnLeftMenu

    }

    //MARK:- Default Button Actions
    func backButtonAction(sender:UIButton){
        if self.viewController() != nil{
            self.viewController()?.navigationController?.popViewController(animated: true)
        }else if  let navigationController = window?.rootViewController as? UINavigationController{
            navigationController.popViewController(animated: true)
        }else{
            print("Navigation controller doesn't found to pop the view controller")
        }
        
    }
    
    //MARK:- Helper functions
    func getDefaultBackButton()->UIButton?{
       return self.leftButtonsStackView.arrangedSubviews.filter({ (backButton) -> Bool in
            backButton.tag == ViewTags.defaultBackButton
       }).first as? UIButton
    }
    
}

//MARK:- Extensions

public extension UIView {
    
    ///----------------------
    /// MARK: viewControllers
    ///----------------------
    
    /**
     Returns the UIViewController object that manages the receiver.
     */
    public func viewController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    func addSubview(view:UIView){
        print("Subview added")
    }
}
public extension UIImage{
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        let customcolor = UIColor.white
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        customcolor.setFill()
        UIRectFill(rect)
        
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
extension UIViewController{
    func customNavigationBar()->CustomNavigationBar?{
        if let navigationBar = self.view.viewWithTag(ViewTags.customNavigationBar) as? CustomNavigationBar{
            return navigationBar
        }
        return nil
    }
}
extension UIWindow{
    func customNavigationBar()->CustomNavigationBar?{
        if let navigationBar = self.viewWithTag(ViewTags.customNavigationBar) as? CustomNavigationBar{
            return navigationBar
        }
        return nil
    }
}
