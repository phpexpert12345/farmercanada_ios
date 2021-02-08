//
//  SupportVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit

class SupportVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewContainer: UIView!
    
    var arrayTitle = ["What issue are you facing?", "I want to track my order", "I want to manage my order", "I want help with returns and refund", "I want help with other issues"]
    var arrayDescription = ["", "Check order status & call delivery agent", "cancel, change delivery date & address", "manage & track returns", "Offer, payments, flipkart plus & all other issues"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "24x7 Customer Support"
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
        self.viewContainer.layer.cornerRadius = 5.0
        self.setupTableViewDelegateAndDatasource()
    }
    
    func setupTableViewDelegateAndDatasource() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 30
        self.tableView.separatorStyle = .none
    }
    
//    MARK:- UITableView Delegate And Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SupportTVC", owner: self, options: nil)?.first as! SupportTVC
        cell.selectionStyle = .none
        cell.lblTitle.text = self.arrayTitle[indexPath.row]
        cell.lblDescription.text = self.arrayDescription[indexPath.row]
        if indexPath.row == 0 {
            cell.imageViewForwardArrow.isHidden = true
            cell.viewBottomLine.isHidden = true
            cell.lblTitle.font = UIFont.init(name: "SFUIText-Regular", size: 17.0)!
        }else {
            cell.viewBottomLine.isHidden = false
            cell.imageViewForwardArrow.isHidden = false
            cell.lblTitle.font = UIFont.init(name: "SFUIText-Regular", size: 15.0)!
        }
        return cell
    }

}
