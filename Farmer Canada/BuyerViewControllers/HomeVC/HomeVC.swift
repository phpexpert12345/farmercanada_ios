//
//  HomeVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 06/01/21.
//

import UIKit

class HomeVC: BaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var lblBecomeASeller: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imageViewEdit: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var imageViewCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewSubscribe: UIView!
    @IBOutlet weak var imageViewSubscribe: UIImageView!
    @IBOutlet weak var lblSubscribe: UILabel!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblPickup: UILabel!
    @IBOutlet weak var switchOrderType: UISwitch!
    @IBOutlet weak var segmentStore: UISegmentedControl!
    @IBOutlet weak var collectionViewFarm: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer = Timer()
    var selectedCategory = Int()
    var locationString = String()
    var selectedOrderType = Int()
    var selectedCategoryType = Int()
    var arrayCategoryList = Array<Dictionary<String, String>>()
    
    let CATEGORY = 1
    let SUBSCRIBE = 2
    let DELIVERY = 1
    let PICKUP = 2
    let FARM_CELL = "FarmCell"
    let SLIDER_CELL = "SliderCell"
    let CATEGORY_CELL = "CategoryCell"
    let SELECTED_CATEGORY_BG = "selected_bg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = self.collectionViewFarm.collectionViewLayout.collectionViewContentSize.height
        self.collectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.setTextField(color: Colors.colorWithHexString(Colors.WHITE_SMOKE))
        self.setupKeyboardButton()
        if self.locationString.isEmpty {
            self.lblLocation.text = "Please Select Location"
        }else {
            self.lblLocation.text = self.locationString
        }
        UtilityMethods.changeImageColor(self.imageViewEdit, .lightGray)
        self.lblBecomeASeller.attributedText = self.setupAttributeFor(self.lblBecomeASeller.text!, "Seller", Colors.colorWithHexString(Colors.BUTTON_COLOR))
        self.setupCategorySelection(self.CATEGORY)
        
        self.arrayCategoryList = [["name" : "Vegitables", "image" : "item1"],
                                  ["name" : "Grocery", "image" : "item2"],
                                  ["name" : "Meat and fish", "image" : "item3"],
                                  ["name" : "Wine", "image" : "item4"]]
        
        self.switchOrderType.isOn = false
        self.selectedOrderType = self.DELIVERY
        self.lblPickup.textColor = .darkGray
        self.lblDelivery.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
        
        self.segmentStore.tintColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.segmentStore.backgroundColor = .white
        self.segmentStore.layer.cornerRadius = 3
        let segAttributes: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: "SFUIText-Regular", size: 15.0)!]
        self.segmentStore.setTitleTextAttributes(segAttributes as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], for: UIControl.State.selected)
        
        self.collectionViewCategory.delegate = self
        self.collectionViewCategory.dataSource = self
        self.collectionViewCategory.contentInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        self.collectionViewCategory.register(UINib.init(nibName: "CategoryCVC", bundle: nil), forCellWithReuseIdentifier: self.CATEGORY_CELL)
        
        self.collectionViewSlider.delegate = self
        self.collectionViewSlider.dataSource = self
        self.collectionViewSlider.register(UINib.init(nibName: "SliderCVC", bundle: nil), forCellWithReuseIdentifier: self.SLIDER_CELL)
        
        self.collectionViewFarm.delegate = self
        self.collectionViewFarm.dataSource = self
        self.collectionViewFarm.contentInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        self.collectionViewFarm.frame = CGRect.init(x: 15, y: self.collectionViewFarm.frame.origin.y, width: self.screenWidth, height: 100)
        self.collectionViewFarm.register(UINib.init(nibName: "FarmCVC", bundle: nil), forCellWithReuseIdentifier: self.FARM_CELL)
        
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.numberOfPages = self.arrayCategoryList.count
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.currentPageIndicatorTintColor = Colors.colorWithHexString(Colors.APP_COLOR)
        
        self.startTimer()
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextCell() {
        let cellSize = CGSize.init(width: self.collectionViewSlider.bounds.width, height: self.collectionViewSlider.bounds.height)
        let contentOffset = collectionViewSlider.contentOffset;
        self.collectionViewSlider.scrollRectToVisible(CGRect.init(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
    }
    
    func setupKeyboardButton() -> Void {
//        self.searchBar.delegate = self
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"down_arrow"), for: .normal)
        menuBtn.addTarget(self, action: #selector(removeSearchKeyboard(_:)), for: UIControl.Event.touchUpInside)
        let cancelButton = UIBarButtonItem(customView: menuBtn)
        toolbar.setItems([cancelButton], animated: false)
        self.searchBar.inputAccessoryView = toolbar
    }
    
    @objc func removeSearchKeyboard(_ sender : Any){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    func setupAttributeFor(_ mainString : String, _ subString: String, _ color : UIColor) -> NSMutableAttributedString {
        let range = (mainString as NSString).range(of: subString)
        let attribute = NSMutableAttributedString.init(string: mainString)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        attribute.addAttribute(NSAttributedString.Key.underlineColor, value: color , range: range)
        attribute.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue , range: range)
         return attribute
    }
    
    func setupCategorySelection(_ categoryType : Int) -> Void {
        self.selectedCategoryType = categoryType
        if categoryType == self.CATEGORY {
            self.viewCategory.layer.cornerRadius = 5.0
            self.viewSubscribe.layer.cornerRadius = 5.0
            self.viewCategory.backgroundColor = .white
            self.viewSubscribe.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
            self.imageViewCategory.image = UIImage.init(named: self.SELECTED_CATEGORY_BG)
            self.imageViewSubscribe.image = UIImage.init(named: "")
            self.lblCategory.textColor = .white
            self.lblSubscribe.textColor = .black
        }else if categoryType == self.SUBSCRIBE {
            self.viewCategory.layer.cornerRadius = 5.0
            self.viewSubscribe.layer.cornerRadius = 5.0
            self.viewSubscribe.backgroundColor = .white
            self.viewCategory.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
            self.imageViewSubscribe.image = UIImage.init(named: self.SELECTED_CATEGORY_BG)
            self.imageViewCategory.image = UIImage.init(named: "")
            self.lblSubscribe.textColor = .white
            self.lblCategory.textColor = .black
        }
    }
    
//    MARK:- UICollectionView Cell Delegate And datesource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewCategory {
            return self.arrayCategoryList.count
        }else if collectionView == self.collectionViewSlider {
            return self.arrayCategoryList.count
        }else {
            return 11
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCategory {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CATEGORY_CELL, for: indexPath) as! CategoryCVC
            let dictionary = self.arrayCategoryList[indexPath.row]
            cell.lblCategoryName.text = dictionary["name"]
            cell.imageViewCategory.image = UIImage.init(named: dictionary["image"]!)
            cell.imageViewBg.frame = CGRect.init(x: 0, y: 0, width: cell.viewBg.bounds.width, height: cell.viewBg.bounds.height)
            if indexPath.row == self.selectedCategory {
                cell.viewBg.backgroundColor = .white
                cell.imageViewBg.image = UIImage.init(named: "rectangle")
            }else {
                cell.imageViewBg.image = UIImage.init(named: "")
                cell.viewBg.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
            }
            return cell
        }else if collectionView == self.collectionViewSlider {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.SLIDER_CELL, for: indexPath) as! SliderCVC
            cell.imageViewSlider.image = UIImage.init(named: "slider")
            cell.imageViewSlider.layer.cornerRadius = 5.0
            cell.imageViewSlider.layer.masksToBounds = true
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.FARM_CELL, for: indexPath) as! FarmCVC
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewCategory {
            return CGSize.init(width: 100.0, height: 105.0)
        }else if collectionView == self.collectionViewSlider {
            return CGSize.init(width: self.collectionViewSlider.bounds.width, height: self.collectionViewSlider.bounds.height)
        }else {
            return CGSize.init(width: (self.collectionViewFarm.bounds.width-45)/2, height: 210.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionViewCategory {
            return 10
        }else if collectionView == self.collectionViewFarm {
            return 15
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewCategory {
            self.selectedCategory = indexPath.row
            self.collectionViewCategory.reloadData()
        }else if collectionView == self.collectionViewFarm {
            let farmVC = FarmVC.init(nibName: "FarmVC", bundle: nil)
//            let navigationController = UINavigationController(rootViewController: farmVC)
//            self.present(navigationController, animated: true, completion: nil)
            self.navigationController?.pushViewController(farmVC, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionViewSlider.frame.size.width
        let currentPage = Int(self.collectionViewSlider.contentOffset.x / pageWidth)
        self.pageControl.currentPage = currentPage
    }
    
//    MARK:- Button Action
    @IBAction func btnSwitchOrderTypeTapped(_ sender: UISwitch) {
        if sender.isOn {
            self.selectedOrderType = self.PICKUP
            self.lblDelivery.textColor = .darkGray
            self.lblPickup.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
        }else {
            self.selectedOrderType = self.DELIVERY
            self.lblPickup.textColor = .darkGray
            self.lblDelivery.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
        }
    }
    
    @IBAction func btnBecomeASellerTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCategorySelectionTapped(_ sender: UIButton) {
        self.setupCategorySelection(sender.tag)
    }
    
    @IBAction func segmentStoreTapped(_ sender: UISegmentedControl) {
        if self.segmentStore.selectedSegmentIndex == 0 {
            
        }else {
            
        }
    }
}

extension UISearchBar {
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }
}
