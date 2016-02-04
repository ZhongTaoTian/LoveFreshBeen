//
//  LFBSegmentedControl.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class LFBSegmentedControl: UISegmentedControl {
    
    var segmentedClick:((index: Int) -> Void)?
    
    override init(items: [AnyObject]?) {
        super.init(items: items)
        tintColor = LFBNavigationYellowColor
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Selected)
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithCustom(100, g: 100, b: 100)], forState: UIControlState.Normal)
        addTarget(self, action: "segmentedControlDidValuechange:", forControlEvents: UIControlEvents.ValueChanged)
        selectedSegmentIndex = 0
    }
    
    convenience init(items: [AnyObject]?, didSelectedIndex: (index: Int) -> ()) {
        self.init(items: items)
        
        segmentedClick = didSelectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func segmentedControlDidValuechange(sender: UISegmentedControl) {
        if segmentedClick != nil {
            segmentedClick!(index: sender.selectedSegmentIndex)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
