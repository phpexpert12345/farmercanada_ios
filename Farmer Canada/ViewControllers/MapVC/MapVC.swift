//
//  MapVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 03/01/21.
//

import UIKit
import MapKit
import MBProgressHUD
import CoreLocation

class MapVC: BaseVC, CLLocationManagerDelegate, UITextFieldDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textFieldPostcode: UITextField!
    @IBOutlet weak var heightTextField: NSLayoutConstraint!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnCofirmLocation: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var viewConfirmAddress: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var btnAllowAssess: UIButton!
    @IBOutlet weak var btnManuallyEntry: UIButton!
    @IBOutlet weak var viewLocationRequired: UIView!
    @IBOutlet weak var viewEdit: UIView!
    
    let ZOOM_VALUE = 0.03
    var selectedLocationString = String()
    var selectedPin:MKPlacemark? = nil
    let locationManager = CLLocationManager()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnAllowAssess)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnManuallyEntry)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnCofirmLocation)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.viewSearch)
    }
    
    func setupViewDidLoadMethod() -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.textFieldPostcode.delegate = self
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.setupKeyboardButton()
        self.viewSearch.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
        self.textFieldPostcode.withImage(direction: .Left, image: UIImage.init(named: "search")!, colorSeparator: .clear, colorBorder: .clear)
        self.btnAllowAssess.layer.cornerRadius = 5.0
        self.btnManuallyEntry.layer.cornerRadius = 5.0
        self.btnCofirmLocation.layer.cornerRadius = 5.0
        self.viewEdit.layer.cornerRadius = self.btnEdit.bounds.height/2
//        self.btnEdit.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
//        self.btnEdit.alpha = 0.2
//        UtilityMethods.changeButtonIconColor("edit", Colors.colorWithHexString(Colors.BUTTON_COLOR), self.btnEdit)
        self.btnCofirmLocation.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.btnManuallyEntry.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.btnAllowAssess.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.viewConfirmAddress.layer.cornerRadius = 10.0
        self.viewLocationRequired.layer.cornerRadius = 10.0
        self.hideSearchBar()
        self.hideConfirmLocationView()
    }
    
    func hideConfirmLocationView() -> Void {
        self.viewConfirmAddress.isHidden = true
    }
    
    func showConfirmLocationView() -> Void {
        self.viewConfirmAddress.isHidden = false
    }
    
    func hideSearchBar() -> Void {
        self.textFieldPostcode.resignFirstResponder()
        self.heightTextField.constant = 0.5
        self.textFieldPostcode.isHidden = true
        self.viewSearch.isHidden = true
        self.btnSearch.isUserInteractionEnabled = false
        self.btnSearch.isHidden = true
    }
    
    func showSearchBar() -> Void {
        self.heightTextField.constant = 45
        self.textFieldPostcode.isHidden = false
        self.viewSearch.isHidden = false
        self.btnSearch.isUserInteractionEnabled = true
        self.btnSearch.isHidden = false
    }
    
    func setupKeyboardButton() -> Void {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"down_arrow"), for: .normal)
        menuBtn.addTarget(self, action: #selector(removeSearchKeyboard(_:)), for: UIControl.Event.touchUpInside)
        let cancelButton = UIBarButtonItem(customView: menuBtn)
        toolbar.setItems([cancelButton], animated: false)
        self.textFieldPostcode.inputAccessoryView = toolbar
    }
    
    @objc func removeSearchKeyboard(_ sender : Any) {
        self.textFieldPostcode.resignFirstResponder()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        return pinView
    }
    
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.selectedPin = MKPlacemark(coordinate: center, addressDictionary:nil)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: self.ZOOM_VALUE, longitudeDelta: self.ZOOM_VALUE))
        self.mapView.setRegion(region, animated: true)
        self.setupDefaultAddress(manager, didUpdateLocations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func setupDefaultAddress(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> Void {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation :CLLocation = locations[0] as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemarkArray = placemarks! as [CLPlacemark]
            if placemarkArray.count>0{
                let placemark = placemarks![0]
                
                let streetName = (placemark.subLocality != nil) ? (placemark.subLocality!) : ""
                let city = (placemark.locality != nil) ? (placemark.locality!) : ""
                let state = (placemark.administrativeArea != nil) ? (placemark.administrativeArea!) : ""
                let country = (placemark.country != nil) ? (placemark.country!) : ""
                let postcode = (placemark.postalCode != nil) ? (placemark.postalCode!) : ""
                let flatName = (placemark.name != nil) ? (placemark.name!) : ""
                let fullAddress = "\(flatName) \(streetName) \(city) \(state) \(country) - \(postcode)"
                let annotation = MKPointAnnotation()
                annotation.coordinate = locValue
                annotation.title = fullAddress
                self.selectedLocationString = "\(flatName), \(streetName), \(city), \(state), \(country), - \(postcode)"
//                self.selectedPostcode = postcode
//                self.defaultAddress = AddressModel.init(flatName: flatName, streetName: streetName, city: city, state: state, country: country, pincode: postcode, fullAddress: self.selectedAddress, latitude: "\(locValue.latitude)", longitude: "\(locValue.longitude)")
                MBProgressHUD.hide(for: self.view, animated: true)
                self.mapView.addAnnotation(annotation)
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
//    MARK:- Button Action
    @IBAction func btnConfirmLocationTapped(_ sender: UIButton) {
        let loginVC = LoginVC.init(nibName: "LoginVC", bundle: nil)
        loginVC.locationString = self.selectedLocationString
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func btnEditTapped(_ sender: UIButton) {
        self.viewBottom.isHidden = false
        self.viewConfirmAddress.isHidden = true
        self.viewLocationRequired.isHidden = false
    }
    
    @IBAction func btnManuallyTapped(_ sender: UIButton) {
        self.showSearchBar()
        self.viewBottom.isHidden = true
        self.viewLocationRequired.isHidden = true
    }
    
    @IBAction func btnAllowAssessTapped(_ sender: UIButton) {
        self.lblAddress.text = self.selectedLocationString
        self.viewLocationRequired.isHidden = true
        self.viewBottom.isHidden = false
        self.viewConfirmAddress.isHidden = false
    }
    
    @IBAction func btnSearchTapped(_ sender: UIButton) {
        self.hideSearchBar()
        self.viewLocationRequired.isHidden = false
        self.viewBottom.isHidden = false
        self.viewConfirmAddress.isHidden = true
    }
}

extension UITextField {

enum Direction {
    case Left
    case Right
}

// add image to textfield
func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
    let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 45))
    mainView.layer.cornerRadius = 5

    let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 45))
    view.backgroundColor = .white
    view.clipsToBounds = true
    view.layer.cornerRadius = 5
    view.layer.borderWidth = CGFloat(0.5)
    view.layer.borderColor = colorBorder.cgColor
    mainView.addSubview(view)

    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 5.0, y: 15.0, width: 15.0, height: 15.0)
    view.addSubview(imageView)

    let seperatorView = UIView()
    seperatorView.backgroundColor = colorSeparator
    mainView.addSubview(seperatorView)

    if(Direction.Left == direction){ // image left
        seperatorView.frame = CGRect(x: 45, y: 0, width: 0.5, height: 45)
        self.leftViewMode = .always
        self.leftView = mainView
    } else { // image right
        seperatorView.frame = CGRect(x: 0, y: 0, width: 0.5, height: 45)
        self.rightViewMode = .always
        self.rightView = mainView
    }

    self.layer.borderColor = colorBorder.cgColor
    self.layer.borderWidth = CGFloat(0.5)
    self.layer.cornerRadius = 5
}

}
