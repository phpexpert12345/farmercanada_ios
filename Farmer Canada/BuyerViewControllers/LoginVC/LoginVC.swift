//
//  LoginVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/01/21.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import JVFloatLabeledTextField


class LoginVC: BaseVC {

    @IBOutlet weak var lblLoginTitle: UILabel!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldPassword: JVFloatLabeledTextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSeller: UIButton!
    @IBOutlet weak var btnBuyer: UIButton!
    
//    let SELLER_TYPE = 1
//    let BUYER_TYPE = 2
    
    var loginType = Int()
    var locationString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnLogin)
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.loginType = AppData.SELLER_TYPE
        self.lblLoginTitle.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
        self.btnLogin.setTitleColor(.white, for: .normal)
        self.btnRegister.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.btnForgotPassword.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.btnLogin.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.txtFieldEmail.floatingLabel.backgroundColor = .white
        self.txtFieldPassword.floatingLabel.backgroundColor = .white
        self.btnLogin.layer.cornerRadius = 5.0
        self.btnBack.backgroundColor = .white
        self.btnBack.layer.cornerRadius = self.btnBack.bounds.height/2
    }
    
//    MARK:- Button Action
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        let forgotVC = ForgotVC.init(nibName: "ForgotVC", bundle: nil)
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        if self.loginType == AppData.BUYER_TYPE {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "RAMAnimatedTabBarController") as! RAMAnimatedTabBarController
            tabBarController.locationString = self.locationString
            self.navigationController?.pushViewController(tabBarController, animated: true)
            let mainViewController = UINavigationController.init(rootViewController: tabBarController)
            if #available(iOS 13.0, *) {
                let window = self.view.window
                window?.rootViewController = mainViewController
                SceneDelegate.shared?.window = window
            }else {
                self.appDelegate.window?.rootViewController = mainViewController
                self.appDelegate.window?.makeKeyAndVisible()
            }
//            if self.checkValidation() {
//                self.webApiSignInExistingUser()
//            }
        }else {
            let setupSellerVC = SetupSellerVC.init(nibName: "SetupSellerVC", bundle: nil)
            self.navigationController?.pushViewController(setupSellerVC, animated: true)
            
//            let productVC = ProductListVC.init(nibName: "ProductListVC", bundle: nil)
//            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
    
    @IBAction func btnGoogleLoginTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnFacebookTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        let signupVC = SignupVC.init(nibName: "SignupVC", bundle: nil)
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelectSignupTypeTapped(_ sender: UIButton) {
        if sender.tag == AppData.SELLER_TYPE {
            self.loginType = sender.tag
            self.btnSeller.setImage(UIImage.init(named: ConstantStrings.SELECTED_RADIO_BUTTON), for: .normal)
            self.btnBuyer.setImage(UIImage.init(named: ConstantStrings.UNSELECTED_RADIO_BUTTON), for: .normal)
        }else {
            self.loginType = sender.tag
            self.btnBuyer.setImage(UIImage.init(named: ConstantStrings.SELECTED_RADIO_BUTTON), for: .normal)
            self.btnSeller.setImage(UIImage.init(named: ConstantStrings.UNSELECTED_RADIO_BUTTON), for: .normal)
        }
    }
    
    func checkValidation() -> Bool {
        self.view.endEditing(true)
        if self.txtFieldEmail.text!.isEmpty {
            self.txtFieldEmail.becomeFirstResponder()
            self.showToastWithMessage(ConstantStrings.EMAIL_IS_REQUIRED_FIELD)
            return false
        }
        if self.txtFieldPassword.text!.isEmpty {
            self.txtFieldPassword.becomeFirstResponder()
            self.showToastWithMessage(ConstantStrings.PASSWORD_IS_REQUIRED_FIELD)
            return false
        }
        return true
    }
    
//    MARK:- Web Api Code start
    func webApiSignInExistingUser() -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = WebApi.BASE_URL + WebApiName.loginApi.rawValue
        print(url)
        let updatedUrl = url.replacingOccurrences(of: " ", with: "%20")
        let parameter = ["mobile": "9876540982", "password" : "password"]
        
        WebApi.webApiForPostRequestWithoutToken(updatedUrl, parameter) { (json : JSON) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if json.isEmpty {
                self.showAlertWithMessage(ConstantStrings.ALERT, ConstantStrings.COULD_NOT_CONNECT_TO_SERVER)
            }else{
                if json["error"] == true {
                    self.showAlertWithMessage(ConstantStrings.ALERT, ConstantStrings.COULD_NOT_CONNECT_TO_SERVER)
                }else {
                    print(json)
                    self.showAlertWithMessage(ConstantStrings.ALERT, "You have been Logged in successfully.")
                }
            }
        }
    }
}
