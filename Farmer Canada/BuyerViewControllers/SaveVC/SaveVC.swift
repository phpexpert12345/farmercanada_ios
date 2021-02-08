//
//  SaveVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 08/01/21.
//

import UIKit

class SaveVC: BaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let FARM_CELL = "FarmCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.tabBarController?.navigationItem.title = "Saved Farms"
        self.setupNotificationTabBarButton()
        self.setupCollectionViewDelegateAndDatasource()
    }
    
    func setupCollectionViewDelegateAndDatasource() -> Void {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        self.collectionView.frame = CGRect.init(x: 15, y: self.collectionView.frame.origin.y, width: self.screenWidth, height: 100)
        self.collectionView.register(UINib.init(nibName: "FarmCVC", bundle: nil), forCellWithReuseIdentifier: self.FARM_CELL)
    }
    
    //    MARK:- UICollectionView Cell Delegate And datesource
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 11
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.FARM_CELL, for: indexPath) as! FarmCVC
            UtilityMethods.changeButtonIconColor("saved", Colors.colorWithHexString(Colors.BUTTON_COLOR), cell.btnSaveFarm)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize.init(width: (self.collectionView.bounds.width-45)/2, height: 210.0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        }
}
