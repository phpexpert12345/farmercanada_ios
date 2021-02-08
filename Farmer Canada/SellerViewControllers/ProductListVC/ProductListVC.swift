//
//  ProductListVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/02/21.
//

import UIKit

class ProductListVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Product List"
        self.setupBackBarButton()
        self.setupFilterButton()
        self.setupTableViewDelegateAndDatasource()
        
        UtilityMethods.addBorder(self.btnAddButton, Colors.colorWithHexString(Colors.SELLER_APP_COLOR), 15.0)
        self.btnAddButton.setTitleColor(Colors.colorWithHexString(Colors.SELLER_APP_COLOR), for: .normal)
    }
    
    func setupTableViewDelegateAndDatasource() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 30
        self.tableView.separatorStyle = .none
    }
    
//    Setup Back Bar Button
    func setupFilterButton() -> Void {
        let rightBarButton = UIBarButtonItem.init(image: UIImage.init(named: "filter")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(buttonFilterAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
//    Back Bar Button Action
    @objc func buttonFilterAction(_ sender : UIButton) -> Void {
        
    }
    
//    MARK:- UITableView Delegate And Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ProductTVC", owner: self, options: nil)?.first as! ProductTVC
        cell.selectionStyle = .none
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UtilityMethods.addShadow(cell.viewContainer)
        }
        return cell
    }
    
    @IBAction func btnAddProduct(_ sender: UIButton) {
        let addProductVC = AddProductVC.init(nibName: "AddProductVC", bundle: nil)
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
}
