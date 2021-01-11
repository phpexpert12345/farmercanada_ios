//
//  SignupVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/01/21.
//

import UIKit
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
    
    let SELLER_TYPE = 1
    let BUYER_TYPE = 2
    
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
        if sender.tag == self.SELLER_TYPE {
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
        let otpVC = OTPVC.init(nibName: "OTPVC", bundle: nil)
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    
    @IBAction func btnTermsConditionsTapped(_ sender: UIButton) {
        
    }
    
}
