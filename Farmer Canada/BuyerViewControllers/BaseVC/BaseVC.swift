//
//  BaseVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 01/01/21.
//

import UIKit
import Toast_Swift

class BaseVC: UIViewController {

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    Setup Back Bar Button
    func setupBackBarButton() -> Void {
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(buttonBackBarAction(_:)))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
//    Back Bar Button Action
    @objc func buttonBackBarAction(_ sender : UIButton) -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
//    Notification Tab Bar button
    func setupNotificationTabBarButton() -> Void {
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: "notification"), style: .done, target: self, action: #selector(buttonNotificationTabBarAction(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = leftBarButton
    }
    
//    Notification Tab Bar button Action
    @objc func buttonNotificationTabBarAction(_ sender : UIButton) -> Void {
        let notificationVC = NotificationVC.init(nibName: "NotificationVC", bundle: nil)
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
//    Notification Nav Bar button
    func setupNotificationNavBarButton() -> Void {
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: "notification"), style: .done, target: self, action: #selector(buttonNotificationNavBarAction(_:)))
        self.navigationItem.rightBarButtonItem = leftBarButton
    }
    
//    Notification Nav Bar button Action
    @objc func buttonNotificationNavBarAction(_ sender : UIButton) -> Void {
        let notificationVC = NotificationVC.init(nibName: "NotificationVC", bundle: nil)
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func createGradientColorWith(_ color1 : UIColor, _ color2 : UIColor, _ view : UIView) -> Void {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 5.0
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func showAlertWithMessage(_ title : String, _ message : String) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction.init(title: ConstantStrings.OK_STRING, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
//    Show View toast
    func showToastWithMessage(_ message : String) -> Void {
        ToastManager.shared.style.backgroundColor = .white
        ToastManager.shared.style.messageColor = .black
        let windows = UIApplication.shared.windows
        windows.last?.hideAllToasts()
        windows.last?.makeToast(message, duration: 5.0, position: .bottom)
    }
}

extension UIView {
    func addBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
}
