//
//  MyAdressViewController.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/29.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class MyAdressViewController: BaseViewController {
    
    var adressTableView: LFBTableView?
    var adresses: [Adress]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildAdressTableView()
        
        loadAdressData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func buildNavigationItem() {
        navigationItem.title = "我的收获地址"
    }
    
    private func buildAdressTableView() {
        adressTableView = LFBTableView(frame: view.bounds, style: UITableViewStyle.Plain)
        adressTableView?.backgroundColor = UIColor.clearColor()
        adressTableView?.rowHeight = 80
        adressTableView?.delegate = self
        adressTableView?.dataSource = self
        view.addSubview(adressTableView!)
        
    }
    
    private func loadAdressData() {
        weak var tmpSelf = self
        AdressData.loadMyAdressData { (data, error) -> Void in
            if error == nil {
                if data?.data?.count > 0 {
                    tmpSelf!.adresses = data!.data
                    tmpSelf!.adressTableView?.reloadData()
                } else {
                    tmpSelf!.showNullAdress()
                }
            }
        }
        
    }
    
    private func showNullAdress() {
    
    }
}

extension MyAdressViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adresses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}



