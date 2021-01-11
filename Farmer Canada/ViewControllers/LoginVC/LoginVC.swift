//
//  LoginVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/01/21.
//

import UIKit
import JVFloatLabeledTextField

class LoginVC: BaseVC {

    @IBOutlet weak var lblLoginTitle: UILabel!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldPassword: JVFloatLabeledTextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
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
//        let homeVC = HomeVC.init(nibName: "HomeVC", bundle: nil)
//        homeVC.locationString = self.locationString
//        self.navigationController?.pushViewController(homeVC, animated: true)
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
}
