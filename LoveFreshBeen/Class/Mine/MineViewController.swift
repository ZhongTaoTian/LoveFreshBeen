//
//  MineViewController.swift
//  LoveFreshBee
//
//  Created by sfbest on 15/11/17.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    private var headView: MineHeadView!
    private var tableView: UITableView!
    private var headViewHeight: CGFloat = 150
    private var tableHeadView: MineTabeHeadView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.hidden = true
        
        buildUI()
    }
// MARK:- Private Method
    // MARK: Build UI
    private func buildUI() {
        headView =  MineHeadView(frame: CGRectMake(0, 0, ScreenWidth, headViewHeight))
        view.addSubview(headView)
        
        buildTableView()
    }
    
    private func buildTableView() {
        tableView = UITableView(frame: CGRectMake(0, headViewHeight, ScreenWidth, ScreenHeight - headViewHeight), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 46
        tableView.separatorStyle = .None
        view.addSubview(tableView)
        
        tableHeadView = MineTabeHeadView(frame: CGRectMake(0, 0, ScreenWidth, 70))
        tableView.tableHeaderView = tableHeadView
    }
}

extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MineCell.cellFor(tableView)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    

}