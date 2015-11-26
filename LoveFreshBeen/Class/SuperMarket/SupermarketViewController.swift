//
//  SupermarketViewController.swift
//  LoveFreshBee
//
//  Created by sfbest on 15/11/17.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class SupermarketViewController: BaseViewController {
    
    var supermarketData: Supermarket?
    
    //MARK: Lazy Property
    private var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        bulidCategoryTableView()
                
        loadSupermarketData()
    }
    
    
    // MARK:- Creat UI
    private func buildNavigationItem() {
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton("扫一扫", titleColor: UIColor.blackColor(),
            image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
            target: self, action: "leftItemClick", type: ItemButtonType.Left)
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("搜 索", titleColor: UIColor.blackColor(),
            image: UIImage(named: "icon_search")!,hightLightImage: nil,
            target: self, action: "rightItemClick", type: ItemButtonType.Right)
    }
    
    private func bulidCategoryTableView() {
        categoryTableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth * 0.25, ScreenHeight), style: .Plain)
        categoryTableView.backgroundColor = LFBGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavigationH, right: 0)
        view.addSubview(categoryTableView)
    }
    
    private func loadSupermarketData() {
        weak var tmpSelf = self
        Supermarket.loadSupermarketData { (data, error) -> Void in
            if error == nil {
                tmpSelf!.supermarketData = data
                tmpSelf!.categoryTableView.reloadData()
            }
        }
    }
    
    // MARK:- Action
    // MARK: 扫一扫和搜索Action
    func leftItemClick() {
        print("左")
    }
    
    func rightItemClick() {
        print("右")
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SupermarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CategoryCell.cellWithTableView(tableView)
        cell.categorie = supermarketData!.data!.categories![indexPath.row]

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 45
    }
}