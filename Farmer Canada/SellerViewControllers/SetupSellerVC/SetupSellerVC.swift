//
//  SetupSellerVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 27/01/21.
//

import UIKit
import JVFloatLabeledTextField

class SetupSellerVC: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var imageViewCamera: UIImageView!
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var textFieldStoreName: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldLocation: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldSelectState: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldSelectCity: JVFloatLabeledTextField!
    @IBOutlet weak var viewStartingTime: UIView!
    @IBOutlet weak var viewEndTiming: UIView!
    @IBOutlet weak var imageViewStartingTime: UIImageView!
    @IBOutlet weak var imageViewEndTime: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    
    let imagePickerProfile = UIImagePickerController()
    
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
        UtilityMethods.changeImageColor(self.imageViewCamera, .lightGray)
        self.imagePickerProfile.delegate = self
        self.imageViewUser.layer.cornerRadius = self.imageViewUser.bounds.height/2
        self.imageViewUser.layer.masksToBounds = true
        UtilityMethods.addShadow(self.imageViewUser, self.imageViewUser.bounds.height/2)
        self.textFieldStoreName.floatingLabel.backgroundColor = .white
        self.textFieldLocation.floatingLabel.backgroundColor = .white
        self.textFieldSelectState.floatingLabel.backgroundColor = .white
        self.textFieldSelectCity.floatingLabel.backgroundColor = .white
        UtilityMethods.changeImageColor(self.imageViewEndTime, .darkGray)
        UtilityMethods.changeImageColor(self.imageViewStartingTime, .darkGray)
        self.viewEndTiming.layer.cornerRadius = 5.0
        self.viewStartingTime.layer.cornerRadius = 5.0
        self.btnNext.layer.cornerRadius = 5.0
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
    
    func setupImageViewSelection(_ imagePicker : UIImagePickerController) {
        
        let alert = UIAlertController(title: nil, message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.handleCamera(imagePicker)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default , handler:{ (UIAlertAction)in
            self.handlePhotGallery(imagePicker)
        }))
        
        alert.addAction(UIAlertAction(title: ConstantStrings.CANCEL_STRING, style: .cancel, handler:{ (UIAlertAction)in}))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func handleCamera(_ imagePicker : UIImagePickerController) -> Void {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }else {
            showAlertWithMessage(ConstantStrings.ALERT, ConstantStrings.DEVICE_DOES_NOT_SUPPORT_CAMERA)
        }
    }
    
    func handlePhotGallery(_ imagePicker : UIImagePickerController) -> Void {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //    UIImage Picker Delegate Method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage {
            self.imageViewUser.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
//    MARK:- Button Action
    @IBAction func btnServiceDetailsTapped(_ sender: UIButton) {
        let serviceDetailsVC = SetupServiceVC.init(nibName: "SetupServiceVC", bundle: nil)
        self.navigationController?.pushViewController(serviceDetailsVC, animated: false)
    }
    
    @IBAction func btnUploadProfilePicTapped(_ sender: UIButton) {
        self.setupImageViewSelection(self.imagePickerProfile)
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        let serviceDetailsVC = SetupServiceVC.init(nibName: "SetupServiceVC", bundle: nil)
        self.navigationController?.pushViewController(serviceDetailsVC, animated: false)
    }
}
