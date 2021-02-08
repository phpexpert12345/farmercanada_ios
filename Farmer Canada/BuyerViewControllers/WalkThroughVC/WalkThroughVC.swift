//
//  WalkThroughVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 01/01/21.
//

import UIKit

class WalkThroughVC: BaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnGetStart: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    let CELL_ID = "SplashCell"
    
    var timer = Timer()
    var isMovedFromProfilePage = Bool()
    var arrayWalkThroughSreen = Array<Dictionary<String, String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnGetStart)
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.startTimer()
        
        self.arrayWalkThroughSreen = [
                                      ["logo" : "logo1", "title" : "Lorem ipsum dolor", "detail" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit", "bg" : "bg1", "count" : "1/4"],
                                      ["logo" : "logo2", "title" : "Lorem ipsum dolor", "detail" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit", "bg" : "bg2", "count" : "2/4"],
                                      ["logo" : "logo3", "title" : "Lorem ipsum dolor", "detail" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit", "bg" : "bg3", "count" : "3/4"],
                                      ["logo" : "logo4", "title" : "Lorem ipsum dolor", "detail" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit", "bg" : "bg4", "count" : "4/4"]]
        self.btnGetStart.isHidden = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "WalkThroughCVC", bundle: nil), forCellWithReuseIdentifier: self.CELL_ID)
        self.btnGetStart.layer.cornerRadius = 5.0
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.numberOfPages = self.arrayWalkThroughSreen.count
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.currentPageIndicatorTintColor = Colors.colorWithHexString(Colors.APP_COLOR)
        if self.isMovedFromProfilePage {
            self.pageControl.isHidden = false
            self.btnSkip.isHidden = true
            self.setupBackBarButton()
            self.navigationItem.title = "Earn Money"
        }else {
            self.pageControl.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.isMovedFromProfilePage {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
        if !self.isMovedFromProfilePage {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextCell() {
        let cellSize = CGSize.init(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        //scroll to next cell
        self.collectionView.scrollRectToVisible(CGRect.init(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        let currentPage = contentOffset.x / self.view.bounds.width
        if Double(currentPage) == Double(self.arrayWalkThroughSreen.count - 1) {
            self.timer.invalidate()
        }
    }
    
//    UICollectionView Delegate and datasource Method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayWalkThroughSreen.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CELL_ID, for: indexPath) as! WalkThroughCVC
        let dictionary = self.arrayWalkThroughSreen[indexPath.row]
        cell.imageViewBg.image = UIImage.init(named: dictionary["bg"]!)
        cell.imageViewLogo.image = UIImage.init(named: dictionary["logo"]!)
        cell.lblTitle.text = dictionary["title"]!
        cell.lblDetail.text = dictionary["detail"]!
        cell.lblCount.text = dictionary["count"]!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = UIScreen.main.bounds.size.width
//        let height = UIScreen.main.bounds.size.height
        let width = self.collectionView.bounds.width
        let height = self.collectionView.bounds.height
        print(width, " - ", height)
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionView.frame.size.width
        let currentPage = Int(self.collectionView.contentOffset.x / pageWidth)
        if Int(currentPage) == (self.arrayWalkThroughSreen.count - 1) {
            if !self.isMovedFromProfilePage {
                self.collectionView.bounces = true
                self.btnGetStart.isHidden = false
                self.btnSkip.isHidden = true
            }
        }else {
            if !self.isMovedFromProfilePage {
                self.collectionView.bounces = true
                self.btnGetStart.isHidden = true
                self.btnSkip.isHidden = false
            }
        }
        if (Int(currentPage) == (self.arrayWalkThroughSreen.count - 1)) && (self.collectionView.contentOffset.x > (self.view.bounds.width * 2) + 20) {
//            self.timer.invalidate()
            
        }
        self.pageControl.currentPage = currentPage
    }
    
//    MARK:- Button Action
    @IBAction func btnSkipTapped(_ sender: UIButton) {
        self.timer.invalidate()
        self.startTimer()
        self.scrollToNextCell()
    }
    
    @IBAction func btnGetStartedTapped(_ sender: UIButton) {
        let mapVC = MapVC.init(nibName: "MapVC", bundle: nil)
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}
