//
//  BaseVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 01/01/21.
//

import UIKit

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
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: "back_arrow")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(buttonBackBarAction(_:)))
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
    }
    
//    Notification Nav Bar button
    func setupNotificationNavBarButton() -> Void {
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: "notification"), style: .done, target: self, action: #selector(buttonNotificationNavBarAction(_:)))
        self.navigationItem.rightBarButtonItem = leftBarButton
    }
    
//    Notification Nav Bar button Action
    @objc func buttonNotificationNavBarAction(_ sender : UIButton) -> Void {
    }
    
    func createGradientColorWith(_ color1 : UIColor, _ color2 : UIColor, _ view : UIView) -> Void {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 5.0
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}
