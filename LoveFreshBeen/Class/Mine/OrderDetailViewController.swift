//
//  OrderDetailViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class OrderDetailViewController: BaseViewController {
    
    private var scrollView: UIScrollView?
    private let orderDetailView = OrderDetailView()
    private let orderUserDetailView = OrderUserDetailView()
    private let orderGoodsListView = OrderGoodsListView()
    private let evaluateView = UIView()
    private let evaluateLabel = UILabel()
    
    private lazy var starImageViews: [UIImageView] = {
        var starImageViews: [UIImageView] = []
        for i in 0...4 {
            let starImageView = UIImageView(image: UIImage(named: "v2_star_no"))
            starImageViews.append(starImageView)
        }
        return starImageViews
        }()
    
    var order: Order? {
        didSet {
            orderDetailView.order = order
            orderUserDetailView.order = order
            orderGoodsListView.order = order
            if -1 != order?.star {
                for i in 0..<order!.star {
                    let imageView = starImageViews[i]
                    imageView.image = UIImage(named: "v2_star_on")
                }
            }
            
            evaluateLabel.text = order?.comment
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildScrollView()
        
        buildOrderDetailView()
        
        buildOrderUserDetailView()
        
        buildOrderGoodsListView()
        
        bulidEvaluateView()
    }
    
    private func buildScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.alwaysBounceVertical = true
        scrollView?.backgroundColor = LFBGlobalBackgroundColor
        scrollView?.contentSize = CGSizeMake(ScreenWidth, 1000)
        view.addSubview(scrollView!)
    }
    
    private func buildOrderDetailView() {
        orderDetailView.frame = CGRectMake(0, 10, ScreenWidth, 185)
        
        scrollView?.addSubview(orderDetailView)
    }
    
    private func buildOrderUserDetailView() {
        orderUserDetailView.frame = CGRectMake(0, CGRectGetMaxY(orderDetailView.frame) + 10, ScreenWidth, 110)
        
        scrollView?.addSubview(orderUserDetailView)
    }
    
    private func buildOrderGoodsListView() {
        orderGoodsListView.frame = CGRectMake(0, CGRectGetMaxY(orderUserDetailView.frame) + 10, ScreenWidth, 350)
        orderGoodsListView.delegate = self
        scrollView?.addSubview(orderGoodsListView)
    }
    
    private func bulidEvaluateView() {
        evaluateView.frame = CGRectMake(0, CGRectGetMaxY(orderGoodsListView.frame) + 10, ScreenWidth, 80)
        evaluateView.backgroundColor = UIColor.whiteColor()
        scrollView?.addSubview(evaluateView)
        
        let myEvaluateLabel = UILabel()
        myEvaluateLabel.text = "我的评价"
        myEvaluateLabel.textColor = LFBTextBlackColor
        myEvaluateLabel.font = UIFont.systemFontOfSize(14)
        myEvaluateLabel.frame = CGRectMake(10, 5, ScreenWidth, 25)
        evaluateView.addSubview(myEvaluateLabel)
        
        for i in 0...4 {
            let starImageView = starImageViews[i]
            starImageView.frame = CGRectMake(10 + CGFloat(i) * 30, CGRectGetMaxY(myEvaluateLabel.frame) + 5, 25, 25)
            evaluateView.addSubview(starImageView)
        }
        
        evaluateLabel.font = UIFont.systemFontOfSize(14)
        evaluateLabel.frame = CGRectMake(10, CGRectGetMaxY(starImageViews[0].frame) + 10, ScreenWidth - 20, 25)
        evaluateLabel.textColor = LFBTextBlackColor
        evaluateView.addSubview(evaluateLabel)
    }
    
}


extension OrderDetailViewController: OrderGoodsListViewDelegate {
    
    func orderGoodsListViewHeightDidChange(height: CGFloat) {
        orderGoodsListView.frame = CGRectMake(0, CGRectGetMaxY(orderUserDetailView.frame) + 10, ScreenWidth, height)
        evaluateView.frame = CGRectMake(0, CGRectGetMaxY(orderGoodsListView.frame) + 10, ScreenWidth, 100)
        scrollView?.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(evaluateView.frame) + 10 + 50 + NavigationH)
    }
    
}





