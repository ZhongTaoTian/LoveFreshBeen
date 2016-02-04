//
//  MineViewController.swift
//  LoveFreshBee
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class MineViewController: BaseViewController {
    
    private var headView: MineHeadView!
    private var tableView: LFBTableView!
    private var headViewHeight: CGFloat = 150
    private var tableHeadView: MineTabeHeadView!
    private var couponNum: Int = 0
    private let shareActionSheet: LFBActionSheet = LFBActionSheet()
    
    // MARK: Flag
    var iderVCSendIderSuccess = false
    
    // MARK: Lazy Property
    private lazy var mines: [MineCellModel] = {
        let mines = MineCellModel.loadMineCellModels()
        return mines
        }()
    
    // MARK:- view life circle
    override func loadView() {
        super.loadView()
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
    }
    
    override func viewWillAppear(animated: Bool) {

        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        
        weak var tmpSelf = self
        Mine.loadMineData { (data, error) -> Void in
            if error == nil {
                if data?.data?.availble_coupon_num > 0 {
                    tmpSelf!.couponNum = data!.data!.availble_coupon_num
                    tmpSelf!.tableHeadView.setCouponNumer(data!.data!.availble_coupon_num)
                } else {
                    tmpSelf!.tableHeadView.setCouponNumer(0)
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if iderVCSendIderSuccess {
            ProgressHUDManager.showSuccessWithStatus("已经收到你的意见了,我们会刚正面的,放心吧~~")
            iderVCSendIderSuccess = false
        }
    }
    

    // MARK:- Private Method
    // MARK: Build UI
    private func buildUI() {
        
        weak var tmpSelf = self
        headView =  MineHeadView(frame: CGRectMake(0, 0, ScreenWidth, headViewHeight), settingButtonClick: { () -> Void in
            let settingVc = SettingViewController()
            tmpSelf!.navigationController?.pushViewController(settingVc, animated: true)
        })
        view.addSubview(headView)
        
        buildTableView()
    }
    
    private func buildTableView() {
        tableView = LFBTableView(frame: CGRectMake(0, headViewHeight, ScreenWidth, ScreenHeight - headViewHeight), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 46
        view.addSubview(tableView)
        
        weak var tmpSelf = self
        tableHeadView = MineTabeHeadView(frame: CGRectMake(0, 0, ScreenWidth, 70))
        // 点击headView回调
        tableHeadView.mineHeadViewClick = { (type) -> () in
            switch type {
            case .Order:
                let orderVc = OrderViewController()
                tmpSelf!.navigationController?.pushViewController(orderVc, animated: true)
                break
            case .Coupon:
                let couponVC = CouponViewController()
                tmpSelf!.navigationController!.pushViewController(couponVC, animated: true)
                break
            case .Message:
                let message = MessageViewController()
                tmpSelf!.navigationController?.pushViewController(message, animated: true)
                break
            }
        }
        
        tableView.tableHeaderView = tableHeadView
    }
}

/// MARK:- UITableViewDataSource UITableViewDelegate
extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MineCell.cellFor(tableView)
        
        if 0 == indexPath.section {
            cell.mineModel = mines[indexPath.row]
        } else if 1 == indexPath.section {
            cell.mineModel = mines[2]
        } else {
            if indexPath.row == 0 {
                cell.mineModel = mines[3]
            } else {
                cell.mineModel = mines[4]
            }
        }
        
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
        if 0 == section {
            return 2
        } else if (1 == section) {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let adressVC = MyAdressViewController()
                navigationController?.pushViewController(adressVC, animated: true)
            } else {
                let myShopVC = MyShopViewController()
                navigationController?.pushViewController(myShopVC, animated: true)
            }
        } else if 1 == indexPath.section {
            shareActionSheet.showActionSheetViewShowInView(view) { (shareType) -> () in
                ShareManager.shareToShareType(shareType, vc: self)
            }
        } else if 2 == indexPath.section {
            if 0 == indexPath.row {
                let helpVc = HelpViewController()
                navigationController?.pushViewController(helpVc, animated: true)
            } else if 1 == indexPath.row {
                let ideaVC = IdeaViewController()
                ideaVC.mineVC = self
                navigationController!.pushViewController(ideaVC, animated: true)
            }
        }
    }
}