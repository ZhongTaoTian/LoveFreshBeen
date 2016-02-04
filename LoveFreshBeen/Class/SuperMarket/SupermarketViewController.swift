//
//  SupermarketViewController.swift
//  LoveFreshBee
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class SupermarketViewController: SelectedAdressViewController {
    
    private var supermarketData: Supermarket?
    private var categoryTableView: LFBTableView!
    private var productsVC: ProductsViewController!
    
    // flag
    private var categoryTableViewIsLoadFinish = false
    private var productTableViewIsLoadFinish  = false
  
    // MARK : Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()

        showProgressHUD()
                
        bulidCategoryTableView()
        
        bulidProductsViewController()
        
        loadSupermarketData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if productsVC.productsTableView != nil {
            productsVC.productsTableView?.reloadData()
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarBuyProductNumberDidChange", name: LFBShopCarBuyProductNumberDidChangeNotification, object: nil)   
    }
    
    func shopCarBuyProductNumberDidChange() {
        if productsVC.productsTableView != nil {
            productsVC.productsTableView!.reloadData()
        }
    }
    
    // MARK:- Creat UI
    private func bulidCategoryTableView() {
        categoryTableView = LFBTableView(frame: CGRectMake(0, 0, ScreenWidth * 0.25, ScreenHeight), style: .Plain)
        categoryTableView.backgroundColor = LFBGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavigationH, right: 0)
        categoryTableView.hidden = true;
        view.addSubview(categoryTableView)
    }
    
    private func bulidProductsViewController() {
        productsVC = ProductsViewController()
        productsVC.delegate = self
        productsVC.view.hidden = true
        addChildViewController(productsVC)
        view.addSubview(productsVC.view)
        
        weak var tmpSelf = self
        productsVC.refreshUpPull = {
            let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.2 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                Supermarket.loadSupermarketData { (data, error) -> Void in
                    if error == nil {
                        tmpSelf!.supermarketData = data
                        tmpSelf!.productsVC.supermarketData = data
                        tmpSelf?.productsVC.productsTableView?.mj_header.endRefreshing()
                        tmpSelf!.categoryTableView.reloadData()
                        tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
                    }
                }
            })
        }
    }
    
    private func loadSupermarketData() {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            weak var tmpSelf = self
            Supermarket.loadSupermarketData { (data, error) -> Void in
                if error == nil {
                    tmpSelf!.supermarketData = data
                    tmpSelf!.categoryTableView.reloadData()
                    tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Bottom)
                    tmpSelf!.productsVC.supermarketData = data
                    tmpSelf!.categoryTableViewIsLoadFinish = true
                    tmpSelf!.productTableViewIsLoadFinish = true
                    if tmpSelf!.categoryTableViewIsLoadFinish && tmpSelf!.productTableViewIsLoadFinish {
                        tmpSelf!.categoryTableView.hidden = false
                        tmpSelf!.productsVC.productsTableView!.hidden = false
                        tmpSelf!.productsVC.view.hidden = false
                        tmpSelf!.categoryTableView.hidden = false
                        ProgressHUDManager.dismiss()
                        tmpSelf!.view.backgroundColor = LFBGlobalBackgroundColor
                    }
                }
            }
        }
    }
    
    // MARK: - Private Method
    private func showProgressHUD() {
        ProgressHUDManager.setBackgroundColor(UIColor.colorWithCustom(230, g: 230, b: 230))
        view.backgroundColor = UIColor.whiteColor()
        if !ProgressHUDManager.isVisible() {
            ProgressHUDManager.showWithStatus("正在加载中")
        }
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if productsVC != nil {
            productsVC.categortsSelectedIndexPath = indexPath
        }
    }
    
}

// MARK: - SupermarketViewController
extension SupermarketViewController: ProductsViewControllerDelegate {
    
    func didEndDisplayingHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section + 1, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
    
    func willDisplayHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
}