//
//  OTPVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/01/21.
//

import UIKit

class OTPVC: BaseVC {

    @IBOutlet weak var txtFieldFirst: UITextField!
    @IBOutlet weak var txtFieldSecond: UITextField!
    @IBOutlet weak var txtFieldThird: UITextField!
    @IBOutlet weak var txtFieldFourth: UITextField!
    @IBOutlet weak var btnSubmitOTP: UIButton!
    @IBOutlet weak var lblNotYet: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var viewResend: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Enter OTP"
        self.setupBackBarButton()
        self.btnSubmitOTP.setTitleColor(.white, for: .normal)
        self.btnResend.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.btnSubmitOTP.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.btnSubmitOTP.layer.cornerRadius = 5.0
        self.viewResend.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
        self.lblNotYet.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
        txtFieldFirst.delegate = self
        txtFieldSecond.delegate = self
        txtFieldThird.delegate = self
        txtFieldFourth.delegate = self

        txtFieldFirst.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtFieldSecond.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtFieldThird.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtFieldFourth.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        let text = textField.text
        if (text?.utf16.count)! >= 1{
            switch textField{
            case txtFieldFirst:
                txtFieldSecond.becomeFirstResponder()
            case txtFieldSecond:
                txtFieldThird.becomeFirstResponder()
            case txtFieldThird:
                txtFieldFourth.becomeFirstResponder()
            case txtFieldFourth:
                txtFieldFourth.resignFirstResponder()
            default:
                break
            }
        }else{

        }
    }
    
//    MARK:- Button Actio
    @IBAction func btnResendTapped(_ sender: UIButton) {
        
    }
    
}

extension OTPVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

