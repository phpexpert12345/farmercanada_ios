//
//  SignupVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/01/21.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import JVFloatLabeledTextField

class SignupVC: BaseVC {

    @IBOutlet weak var btnSeller: UIButton!
    @IBOutlet weak var btnBuyer: UIButton!
    @IBOutlet weak var txtFieldName: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldPhoneNumber: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldPassword: JVFloatLabeledTextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnTermsConditions: UIButton!
    
//    let SELLER_TYPE = 1
//    let BUYER_TYPE = 2
    
    var signupType = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnSignup)
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Signup"
        self.signupType = AppData.SELLER_TYPE
        self.setupBackBarButton()
        self.btnSignup.layer.cornerRadius = 5.0
        self.btnSignup.setTitleColor(.white, for: .normal)
        self.btnTermsConditions.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.btnSignup.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.txtFieldName.floatingLabel.backgroundColor = .white
        self.txtFieldEmail.floatingLabel.backgroundColor = .white
        self.txtFieldPhoneNumber.floatingLabel.backgroundColor = .white
        self.txtFieldPassword.floatingLabel.backgroundColor = .white
    }
    
//    MARK:- Button Action
    @IBAction func btnSelectSignupTypeTapped(_ sender: UIButton) {
        if sender.tag == AppData.SELLER_TYPE {
            self.signupType = sender.tag
            self.btnSeller.setImage(UIImage.init(named: ConstantStrings.SELECTED_RADIO_BUTTON), for: .normal)
            self.btnBuyer.setImage(UIImage.init(named: ConstantStrings.UNSELECTED_RADIO_BUTTON), for: .normal)
        }else {
            self.signupType = sender.tag
            self.btnBuyer.setImage(UIImage.init(named: ConstantStrings.SELECTED_RADIO_BUTTON), for: .normal)
            self.btnSeller.setImage(UIImage.init(named: ConstantStrings.UNSELECTED_RADIO_BUTTON), for: .normal)
        }
    }
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
//        let otpVC = OTPVC.init(nibName: "OTPVC", bundle: nil)
//        self.navigationController?.pushViewController(otpVC, animated: true)
        if self.checkValidation() {
            self.webApiSignUpNewUser()
        }
    }
    
    @IBAction func btnTermsConditionsTapped(_ sender: UIButton) {
        
    }
    
    func checkValidation() -> Bool {
        self.view.endEditing(true)
        if self.txtFieldName.text!.isEmpty {
            self.txtFieldName.becomeFirstResponder()
            self.showToastWithMessage(ConstantStrings.NAME_IS_REQUIRED_FIELD)
            return false
        }
        if self.txtFieldPhoneNumber.text!.isEmpty {
            self.txtFieldPhoneNumber.becomeFirstResponder()
            self.showToastWithMessage(ConstantStrings.PHONE_IS_REQUIRED_FIELD)
            return false
        }
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
    func webApiSignUpNewUser() -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = WebApi.BASE_URL + WebApiName.signUpApi.rawValue
        print(url)
        let updatedUrl = url.replacingOccurrences(of: " ", with: "%20")
        let parameter = ["email": self.txtFieldEmail.text!, "password" : self.txtFieldPassword.text!, "name" : self.txtFieldName.text!, "mobile" : self.txtFieldPhoneNumber.text!]
        
        WebApi.webApiForPostRequestWithoutToken(updatedUrl, parameter) { (json : JSON) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if json.isEmpty {
                self.showAlertWithMessage(ConstantStrings.ALERT, ConstantStrings.COULD_NOT_CONNECT_TO_SERVER)
            }else{
                if json["error"] == true {
                    self.showAlertWithMessage(ConstantStrings.ALERT, ConstantStrings.COULD_NOT_CONNECT_TO_SERVER)
                }else {
                    print(json)
                    self.showAlertWithMessage(ConstantStrings.ALERT, "You have been signed in successfully.")
                }
            }
        }
    }
}
