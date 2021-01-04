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
    
    func setupViewDidLoadMethod() -> Void {
        self.lblLoginTitle.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
        self.btnLogin.setTitleColor(.white, for: .normal)
        self.btnRegister.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.btnForgotPassword.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.btnLogin.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.txtFieldEmail.floatingLabel.backgroundColor = .white
        self.txtFieldPassword.floatingLabel.backgroundColor = .white
        self.btnLogin.layer.cornerRadius = 5.0
    }
    
//    MARK:- Button Action
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        let forgotVC = ForgotVC.init(nibName: "ForgotVC", bundle: nil)
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnGoogleLoginTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnFacebookTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        let signupVC = SignupVC.init(nibName: "SignupVC", bundle: nil)
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
}
