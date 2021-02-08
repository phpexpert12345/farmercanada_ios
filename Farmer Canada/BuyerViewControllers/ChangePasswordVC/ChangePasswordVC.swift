//
//  ChangePasswordVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit
import CNPPopupController
import JVFloatLabeledTextField

class ChangePasswordVC: BaseVC, CNPPopupControllerDelegate, SuccessPopupActionDelegate {
    
    func btnOkAction(_ sender: UIButton) {
        self.popupController?.dismiss(animated: true)
    }
    
    @IBOutlet weak var txtFieldOldPassword: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldNewPassword: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldConfirmPassword: JVFloatLabeledTextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var viewTop: UIView!
    
    var popupController:CNPPopupController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Change Password"
        self.setupBackBarButton()
        self.setupNavBarColor(.white, Colors.colorWithHexString(Colors.APP_COLOR))
        self.txtFieldOldPassword.floatingLabel.backgroundColor = .white
        self.txtFieldNewPassword.floatingLabel.backgroundColor = .white
        self.txtFieldConfirmPassword.floatingLabel.backgroundColor = .white
        self.btnSave.layer.cornerRadius = 5.0
        self.viewTop.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnSave)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            let statusBar1 =  UIView()
            statusBar1.frame = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame)!
            statusBar1.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
            UIApplication.shared.keyWindow?.addSubview(statusBar1)
        } else {
            let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar1.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
        }
        self.setupNavBarColor(.white, Colors.colorWithHexString(Colors.APP_COLOR))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 13.0, *) {
            let statusBar1 =  UIView()
            statusBar1.frame = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame)!
            statusBar1.backgroundColor = UIColor.white
            UIApplication.shared.keyWindow?.addSubview(statusBar1)
        } else {
            let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar1.backgroundColor = UIColor.white
        }
        self.setupNavBarColor(.black, .white)
    }
    
    func setupNavBarColor(_ textColor : UIColor, _ navBarColor : UIColor) -> Void {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = navBarColor
            appearance.titleTextAttributes = [.foregroundColor: textColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: textColor, .font: UIFont.init(name: "SFUIText-Regular", size: 17.0)!]
            appearance.shadowColor = .clear
            self.navigationController?.navigationBar.tintColor = textColor
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationController?.navigationBar.tintColor = navBarColor
            self.navigationController?.navigationBar.barTintColor = navBarColor
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: textColor, .font: UIFont.init(name: "SFUIText-Regular", size: 17.0)!]
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: textColor]
        }
    }
    
    var popupView = SuccessPopView()
    func setupPopupView() -> Void {
        self.popupView = SuccessPopView.init(frame: CGRect.init(x: 15, y: 0, width: self.screenWidth-30, height: 250))
        self.popupView.viewContainer.layer.cornerRadius = 10.0
        self.popupView.delegate = self
        self.popupView.btnOK.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.popupView.lblTitle.text = "Your Password changed"
        self.popupView.lblMessage.text = "Your Password has been changed successfully."

        let popupController = CNPPopupController(contents:[self.popupView])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = CNPPopupStyle.centered
        // LFL added settings for custom color and blur
        popupController.theme.backgroundColor = .clear
        popupController.theme.maskType = .dimmed
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
    
//    MARK:- Button Action
    @IBAction func btnSubmitProfileTapped(_ sender: UIButton) {
//        let navigationVC = NotificationVC.init(nibName: "NotificationVC", bundle: nil)
//        self.navigationController?.pushViewController(navigationVC, animated: true)
        self.setupPopupView()
    }
}
