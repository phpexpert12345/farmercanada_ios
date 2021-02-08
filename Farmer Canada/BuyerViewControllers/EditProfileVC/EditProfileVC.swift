//
//  EditProfileVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit
import CNPPopupController
import JVFloatLabeledTextField

class EditProfileVC: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CNPPopupControllerDelegate, SuccessPopupActionDelegate {
    func btnOkAction(_ sender: UIButton) {
        self.popupController?.dismiss(animated: true)
    }
    
    
    @IBOutlet weak var txtFieldName: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldPhoneNumber: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imageViewCamera: UIImageView!
    
    var popupController:CNPPopupController?
    let imagePickerProfile = UIImagePickerController()
    let imagePickerCover = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Change Password"
        self.setupBackBarButton()
        self.txtFieldName.floatingLabel.backgroundColor = .white
        self.txtFieldPhoneNumber.floatingLabel.backgroundColor = .white
        self.txtFieldEmail.floatingLabel.backgroundColor = .white
        self.btnSave.layer.cornerRadius = 5.0
        self.imageViewProfile.layer.cornerRadius = self.imageViewProfile.bounds.height/2
        UtilityMethods.addBorder(self.imageViewProfile, .lightGray, self.imageViewProfile.bounds.height/2)
        self.btnBack.backgroundColor = .white
        self.btnBack.layer.cornerRadius = self.btnBack.bounds.height/2
        UtilityMethods.changeImageColor(self.imageViewCamera, .lightGray)
        self.imagePickerProfile.delegate = self
        self.imagePickerCover.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnSave)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
            if picker == self.imagePickerProfile {
                self.imageViewProfile.image = chosenImage
            }else {
                self.imageViewCover.image = chosenImage
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    var popupView = SuccessPopView()
    func setupPopupView() -> Void {
        self.popupView = SuccessPopView.init(frame: CGRect.init(x: 15, y: 0, width: self.screenWidth-30, height: 250))
        self.popupView.viewContainer.layer.cornerRadius = 10.0
        self.popupView.delegate = self
        self.popupView.btnOK.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)

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
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        self.setupPopupView()
    }
    
    @IBAction func btnChangeCoverTapped(_ sender: UIButton) {
        self.setupImageViewSelection(self.imagePickerCover)
    }
    
    @IBAction func btnChangeProfileTapped(_ sender: UIButton) {
        self.setupImageViewSelection(self.imagePickerProfile)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
