//
//  ForgotVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 05/01/21.
//

import UIKit
import JVFloatLabeledTextField

class ForgotVC: BaseVC {

    @IBOutlet weak var txtFieldPhoneNumber: JVFloatLabeledTextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Forgot Password"
        self.setupBackBarButton()
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
    }
}
