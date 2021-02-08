//
//  OngoingOrderVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 26/01/21.
//

import UIKit

class OngoingOrderVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.setupTableViewDelegateAndDatasource()
    }
    
    func setupTableViewDelegateAndDatasource() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 40
        self.tableView.separatorStyle = .none
    }
    
//    MARK:- UITableView Delegate And Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("OngoingOrderTVC", owner: self, options: nil)?.first as! OngoingOrderTVC
        cell.selectionStyle = .none
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UtilityMethods.addShadow(cell.viewContainer)
        }
        return cell
    }
}
