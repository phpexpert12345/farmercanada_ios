//
//  VerificationEmailVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 27/01/21.
//

import UIKit
import JVFloatLabeledTextField

class VerificationEmailVC: BaseVC {
    
    @IBOutlet weak var viewStep: UIView!
//    @IBOutlet weak var btnUploadDoc1: UIButton!
//    @IBOutlet weak var btnUploadDoc2: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var textFieldPhoneNo: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldEmailAddress: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldWebsiteLink: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldSocialMedia: JVFloatLabeledTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Setup Seller Account"
        self.setupBackBarButton()
        self.viewStep.backgroundColor = Colors.colorWithHexString(Colors.SELLER_APP_COLOR)
        self.viewStep.addBottomRoundedEdge(desiredCurve: 1.5)
        self.setupNavBarColor(.white, Colors.colorWithHexString(Colors.SELLER_APP_COLOR))
        self.btnNext.layer.cornerRadius = 5.0
        self.textFieldPhoneNo.floatingLabel.backgroundColor = .white
        self.textFieldEmailAddress.floatingLabel.backgroundColor = .white
        self.textFieldWebsiteLink.floatingLabel.backgroundColor = .white
        self.textFieldSocialMedia.floatingLabel.backgroundColor = .white
//        self.btnUploadDoc1.layer.cornerRadius = 5.0
//        self.btnUploadDoc2.layer.cornerRadius = 5.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            let statusBar1 =  UIView()
            statusBar1.frame = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame)!
            statusBar1.backgroundColor = Colors.colorWithHexString(Colors.SELLER_APP_COLOR)
            UIApplication.shared.keyWindow?.addSubview(statusBar1)
        } else {
            let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar1.backgroundColor = Colors.colorWithHexString(Colors.SELLER_APP_COLOR)
        }
        self.setupNavBarColor(.white, Colors.colorWithHexString(Colors.SELLER_APP_COLOR))
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
    
//    MARK:- Button Action
    @IBAction func btnUploadDocumentTapped(_ sender: UIButton) {
        let verificationVC = DocumentVerificationVC.init(nibName: "DocumentVerificationVC", bundle: nil)
        self.navigationController?.pushViewController(verificationVC, animated: false)
    }
    
    @IBAction func btnSetupServiceTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnUploadDoc1Tapped(_ sender: UIButton) {
    }
    
    @IBAction func btnUploadDoc2Tapped(_ sender: UIButton) {
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        let verificationVC = DocumentVerificationVC.init(nibName: "DocumentVerificationVC", bundle: nil)
        self.navigationController?.pushViewController(verificationVC, animated: false)
    }
}
