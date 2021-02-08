//
//  SetupServiceVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 27/01/21.
//

import UIKit
import MapKit
import CoreLocation
import MBProgressHUD
import JVFloatLabeledTextField

class SetupServiceVC: BaseVC, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var viewStep: UIView!
    @IBOutlet weak var imageViewPickup: UIImageView!
    @IBOutlet weak var lblPickup: UILabel!
    @IBOutlet weak var imageViewDelivery: UIImageView!
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textFieldSelectDistance: JVFloatLabeledTextField!
    @IBOutlet weak var lblSelectedDistance: UILabel!
    @IBOutlet weak var imageViewAbout1: UIImageView!
    @IBOutlet weak var imageViewAbout2: UIImageView!
    @IBOutlet weak var viewAmount: UIView!
    @IBOutlet weak var textFieldDeliveryCharge: JVFloatLabeledTextField!
    @IBOutlet weak var imageViewStartingTime: UIImageView!
    @IBOutlet weak var imageViewEndTime: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var textFieldMinDeliveryCharge: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldMinPickupCharge: JVFloatLabeledTextField!
    
    let ZOOM_VALUE = 0.03
    var dropdownDistance = DropDown()
    var selectedPin:MKPlacemark? = nil
    let locationManager = CLLocationManager()
    
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
        
        self.lblPickup.textColor = .black
        self.lblDelivery.textColor = .lightGray
        self.imageViewPickup.image = UIImage.init(named: "selected")
        self.imageViewDelivery.image = UIImage.init(named: "unselected")
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.isUserInteractionEnabled = false
        self.mapView.layer.cornerRadius = 5.0
        
        self.textFieldSelectDistance.delegate = self
        self.textFieldSelectDistance.floatingLabel.backgroundColor = .white
        self.textFieldDeliveryCharge.floatingLabel.backgroundColor = .white
        self.textFieldMinDeliveryCharge.floatingLabel.backgroundColor = .white
        self.textFieldMinPickupCharge.floatingLabel.backgroundColor = .white
        self.setupDistanceDropdown()
        UtilityMethods.changeImageColor(self.imageViewAbout1, .lightGray)
        UtilityMethods.changeImageColor(self.imageViewAbout2, .lightGray)
        UtilityMethods.changeImageColor(self.imageViewEndTime, .darkGray)
        UtilityMethods.changeImageColor(self.imageViewStartingTime, .darkGray)
        self.viewAmount.layer.cornerRadius = 5.0
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.dropdownDistance.hide()
        if textField == self.textFieldSelectDistance {
            self.dropdownDistance.show()
            return false
        }
        return true
    }
    
    func setupDistanceDropdown() -> Void {
        self.dropdownDistance.anchorView = self.textFieldSelectDistance
        self.dropdownDistance.direction = .any
        self.dropdownDistance.dataSource = ["5Km", "10Km", "15Km", "20Km", "25Km", "30Km"]
        self.dropdownDistance.bottomOffset = CGPoint(x: 0, y:((self.dropdownDistance.anchorView?.plainView.bounds.height)! + 10))
        self.dropdownDistance.topOffset = CGPoint(x: 0, y:-((self.dropdownDistance.anchorView?.plainView.bounds.height)! + 10))
        self.dropdownDistance.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)", self)
            self.textFieldSelectDistance.text = item
            self.lblSelectedDistance.text = "You have selected \(self.textFieldSelectDistance.text!) Delivery Location"
            
        }
        self.dropdownDistance.width = self.textFieldSelectDistance.bounds.width
        self.dropdownDistance.cellHeight = 40
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.selectedPin = MKPlacemark(coordinate: center, addressDictionary:nil)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: self.ZOOM_VALUE, longitudeDelta: self.ZOOM_VALUE))
        self.mapView.setRegion(region, animated: true)
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
//    MARK:- Button Action
    @IBAction func btnVerificationTapped(_ sender: UIButton) {
        let verificationVC = VerificationEmailVC.init(nibName: "VerificationEmailVC", bundle: nil)
        self.navigationController?.pushViewController(verificationVC, animated: false)
    }
    
    @IBAction func btnSetupSellerTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnPickupTapped(_ sender: UIButton) {
        self.lblPickup.textColor = .black
        self.lblDelivery.textColor = .lightGray
        self.imageViewPickup.image = UIImage.init(named: "selected")
        self.imageViewDelivery.image = UIImage.init(named: "unselected")
    }
    
    @IBAction func btnDeliveryTapped(_ sender: UIButton) {
        self.lblPickup.textColor = .lightGray
        self.lblDelivery.textColor = .black
        self.imageViewPickup.image = UIImage.init(named: "unselected")
        self.imageViewDelivery.image = UIImage.init(named: "selected")
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        let verificationVC = VerificationEmailVC.init(nibName: "VerificationEmailVC", bundle: nil)
        self.navigationController?.pushViewController(verificationVC, animated: false)
    }
}
