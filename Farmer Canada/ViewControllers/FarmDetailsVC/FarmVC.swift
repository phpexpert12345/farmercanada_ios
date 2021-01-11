//
//  FarmVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 10/01/21.
//

import UIKit

class FarmVC: BaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var lblFarmName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var viewDeliveryTime: UIView!
    @IBOutlet weak var lblDeliveryTime: UILabel!
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var viewClock: UIView!
    @IBOutlet weak var imageViewClock: UIImageView!
    @IBOutlet weak var lblOpenTime: UILabel!
    @IBOutlet weak var viewHost: UIView!
    @IBOutlet weak var imageViewHost: UIImageView!
    @IBOutlet weak var lblHostName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    
    var timer = Timer()
    
    let ITEM_CELL = "ItemCell"
    let SLIDER_CELL = "FarmSliderCell"
    var arrayProductList = ["mango", "pea", "onion", "mango", "pea", "onion"]
    
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
        self.tableViewheight.constant = self.tableView.contentSize.height
//        dispatch_async(dispatch_get_main_queue(), ^{
//                //This code will run in the main thread:
//                CGRect frame = self.tableView.frame;
//                frame.size.height = self.tableView.contentSize.height;
//                self.tableView.frame = frame;
//            });
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Farm Details"
        
        self.collectionViewSlider.frame = CGRect.init(x: 0, y: 0, width: self.screenWidth, height: self.collectionViewSlider.bounds.height)
        self.collectionViewSlider.delegate = self
        self.collectionViewSlider.dataSource = self
        self.collectionViewSlider.register(UINib.init(nibName: "FarmSliderCVC", bundle: nil), forCellWithReuseIdentifier: self.SLIDER_CELL)
        
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.numberOfPages = 2
        self.pageControl.pageIndicatorTintColor = .white
        self.pageControl.currentPageIndicatorTintColor = Colors.colorWithHexString(Colors.APP_COLOR)
        
        self.btnBack.backgroundColor = .white
        self.btnBack.layer.cornerRadius = self.btnBack.bounds.height/2
        self.btnChat.layer.cornerRadius = self.btnChat.bounds.height/2
        
        self.viewDeliveryTime.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
        self.viewReview.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
        self.viewDetails.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
        self.viewDetails.layer.cornerRadius = 5.0
        self.viewReview.layer.cornerRadius = 3.0
        self.viewDeliveryTime.layer.cornerRadius = 3.0
        self.viewHost.layer.cornerRadius = 5.0
        self.viewClock.layer.cornerRadius = 5.0
        
        self.lblFarmName.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
        self.btnChat.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        UtilityMethods.changeImageColor(self.imageViewClock, Colors.colorWithHexString(Colors.APP_COLOR))
        UtilityMethods.changeImageColor(self.imageViewHost, Colors.colorWithHexString(Colors.APP_COLOR))
        self.lblDeliveryTime.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
//        self.viewClock.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
//        self.viewClock.alpha = 0.2
//        self.viewHost.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
//        self.viewHost.alpha = 0.2
        self.startTimer()
        self.setupTableViewDelegateAndDatasource()
    }
    
    func setupTableViewDelegateAndDatasource() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 50
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextCell() {
        let cellSize = CGSize.init(width: self.collectionViewSlider.bounds.width, height: self.collectionViewSlider.bounds.height)
        let contentOffset = collectionViewSlider.contentOffset;
        self.collectionViewSlider.scrollRectToVisible(CGRect.init(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
    }
    
//    MARK:- UICollectionView Cell Delegate And datesource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if collectionView == self.collectionViewSlider {
            return 2
        }else {
            return self.arrayProductList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewSlider {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.SLIDER_CELL, for: indexPath) as! FarmSliderCVC
            cell.imageViewSlider.image = UIImage.init(named: "detail_image")
            cell.imageViewSlider.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.collectionViewSlider.bounds.height)
            UtilityMethods.roundCorners(view: cell.imageViewSlider, corners: [.bottomLeft, .bottomRight], radius: 10.0)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.ITEM_CELL, for: indexPath) as! ItemCVC
            if (collectionView.tag > 0) && (indexPath.row == 0) {
                cell.viewOutOfStock.isHidden = false
                cell.viewNotify.isHidden = false
                cell.viewAddToCart.isHidden = true
            }else {
                cell.viewAddToCart.isHidden = false
                cell.viewOutOfStock.isHidden = true
                cell.viewNotify.isHidden = true
            }
            cell.imageViewProduct.image = UIImage.init(named: self.arrayProductList[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewSlider {
            return CGSize.init(width: self.collectionViewSlider.bounds.width, height: self.collectionViewSlider.bounds.height)
        }else {
            return CGSize.init(width: 140.0, height: 190.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionViewSlider {
            return 0
        }else {
            return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionViewSlider.frame.size.width
        let currentPage = Int(self.collectionViewSlider.contentOffset.x / pageWidth)
        self.pageControl.currentPage = currentPage
    }
    
//    MARK:- Button Action
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChatTapped(_ sender: UIButton) {
        
    }
}

extension FarmVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ItemListTVC", owner: self, options: nil)?.first as! ItemListTVC
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.lblProductCategory.text = "Vegitables"
        }else {
            cell.lblProductCategory.text = "Fruits"
        }
        cell.collectionView.tag = indexPath.row
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.collectionView.register(UINib.init(nibName: "ItemCVC", bundle: nil), forCellWithReuseIdentifier: self.ITEM_CELL)
        return cell
    }
}
