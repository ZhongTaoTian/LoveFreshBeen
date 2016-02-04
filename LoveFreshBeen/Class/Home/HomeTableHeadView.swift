//
//  HomeTableHeadView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class HomeTableHeadView: UIView {
    
    private var pageScrollView: PageScrollView?
    private var hotView: HotView?
    weak var delegate: HomeTableHeadViewDelegate?
    var tableHeadViewHeight: CGFloat = 0 {
        willSet {
            NSNotificationCenter.defaultCenter().postNotificationName(HomeTableHeadViewHeightDidChange, object: newValue)
            frame = CGRectMake(0, -newValue, ScreenWidth, newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildPageScrollView()
        
        buildHotView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 模型的set方法
    var headData: HeadResources? {
        didSet {
            pageScrollView?.headData = headData
            hotView!.headData = headData?.data
        }
    }
    // MARK: 初始化子控件
    func buildPageScrollView() {
        weak var tmpSelf = self
        pageScrollView = PageScrollView(frame: CGRectZero, placeholder: UIImage(named: "v2_placeholder_full_size")!, focusImageViewClick: { (index) -> Void in
            if tmpSelf!.delegate != nil && ((tmpSelf!.delegate?.respondsToSelector("tableHeadView:focusImageViewClick:")) != nil) {
                tmpSelf!.delegate!.tableHeadView!(tmpSelf!, focusImageViewClick: index)
            }
        })

        addSubview(pageScrollView!)
    }
    
    func buildHotView() {
        weak var tmpSelf = self
        hotView = HotView(frame: CGRectZero, iconClick: { (index) -> Void in
            if tmpSelf!.delegate != nil && ((tmpSelf!.delegate?.respondsToSelector("tableHeadView:iconClick:")) != nil) {
                tmpSelf!.delegate!.tableHeadView!(tmpSelf!, iconClick: index)
            }
        })
        hotView?.backgroundColor = UIColor.whiteColor()
        addSubview(hotView!)
    }
    
    //MARK: 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageScrollView?.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth * 0.31)
        
        hotView?.frame.origin = CGPointMake(0, CGRectGetMaxY((pageScrollView?.frame)!))
        
        tableHeadViewHeight = CGRectGetMaxY(hotView!.frame)
    }
}

// - MARK: Delegate
@objc protocol HomeTableHeadViewDelegate: NSObjectProtocol {
    optional func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int)
    optional func tableHeadView(headView: HomeTableHeadView, iconClick index: Int)
}
