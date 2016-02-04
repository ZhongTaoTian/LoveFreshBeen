//
//  CouponViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class CouponViewController: BaseViewController {
    
    private var bindingCouponView: BindingCouponView?
    private var couponTableView: LFBTableView?
    
    private var useCoupons: [Coupon] = [Coupon]()
    private var unUseCoupons: [Coupon] = [Coupon]()
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        setNavigationItem()
        
        buildBindingCouponView()
        
        bulidCouponTableView()
        
        loadCouponData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: bulidUI
    private func setNavigationItem() {
        navigationItem.title = "优惠劵"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("使用规则", titleColor: UIColor.colorWithCustom(100, g: 100, b: 100), target: self, action: "rightItemClick")
    }
    
    func buildBindingCouponView() {
        bindingCouponView = BindingCouponView(frame: CGRectMake(0, 0, ScreenWidth, 50), bindingButtonClickBack: { (couponTextFiled) -> () in
            if couponTextFiled.text != nil && !(couponTextFiled.text!.isEmpty) {
                ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入正确的优惠劵")
            } else {
                let alert = UIAlertView(title: nil, message: "请输入优惠码!", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        })
        view.addSubview(bindingCouponView!)
    }
    
    private func bulidCouponTableView() {
        couponTableView = LFBTableView(frame: CGRectMake(0, CGRectGetMaxY(bindingCouponView!.frame), ScreenWidth, ScreenHeight - bindingCouponView!.height - NavigationH), style: UITableViewStyle.Plain)
        couponTableView!.delegate = self
        couponTableView?.dataSource = self
        view.addSubview(couponTableView!)
    }
    // MARK: Method
    private func loadCouponData() {
        weak var tmpSelf = self
        CouponData.loadCouponData { (data, error) -> Void in
            if error != nil {
                return
            }
            
            if data?.data?.count > 0 {
                for obj in data!.data! {
                    switch obj.status {
                    case 0: tmpSelf!.useCoupons.append(obj)
                        break
                    default: tmpSelf!.unUseCoupons.append(obj)
                        break
                    }
                }
            }
            
            tmpSelf!.couponTableView?.reloadData()
        }
    }
    
    // MARK: Action
    func rightItemClick() {
        let couponRuleVC = CoupinRuleViewController()
        couponRuleVC.loadURLStr = CouponUserRuleURLString
        couponRuleVC.navTitle = "使用规则"
        navigationController?.pushViewController(couponRuleVC, animated: true)
    }
}

// - MARK: UITableViewDelegate, UITableViewDataSource
extension CouponViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == section {
                return useCoupons.count
            } else {
                return unUseCoupons.count
            }
        }
        
        if useCoupons.count > 0 {
            return useCoupons.count
        }
        
        if unUseCoupons.count > 0 {
            return unUseCoupons.count
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            return 2
        } else if useCoupons.count > 0 || unUseCoupons.count > 0 {
            return 1
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CouponCell.cellWithTableView(tableView)
        var coupon: Coupon?
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == indexPath.section {
                coupon = useCoupons[indexPath.row]
            } else {
                coupon = unUseCoupons[indexPath.row]
            }
        } else if useCoupons.count > 0 {
            coupon = useCoupons[indexPath.row]
        } else if unUseCoupons.count > 0 {
            coupon = unUseCoupons[indexPath.row]
        }
        
        cell.coupon = coupon!
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if unUseCoupons.count > 0 && useCoupons.count > 0 && 0 == section {
            return 10
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if unUseCoupons.count > 0 && useCoupons.count > 0 {
            if 0 == section {
                let footView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 10))
                footView.backgroundColor = UIColor.clearColor()
                let lineView = UIView(frame: CGRectMake(CouponViewControllerMargin, 4.5, ScreenWidth - 2 * CouponViewControllerMargin, 1))
                lineView.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
                footView.addSubview(lineView)
                return footView
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}