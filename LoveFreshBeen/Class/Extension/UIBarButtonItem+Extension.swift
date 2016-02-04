//
//  UIBarButtonItem+Extension.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

enum ItemButtonType: Int {
    case Left = 0
    case Right = 1
}

extension UIBarButtonItem {

    class func barButton(title: String, titleColor: UIColor, image: UIImage, hightLightImage: UIImage?, target: AnyObject?, action: Selector, type: ItemButtonType) -> UIBarButtonItem {
        var btn:UIButton = UIButton()
        if type == ItemButtonType.Left {
            btn = ItemLeftButton(type: .Custom)
        } else {
            btn = ItemRightButton(type: .Custom)
        }
        btn.setTitle(title, forState: .Normal)
        btn.setImage(image, forState: .Normal)
        btn.setTitleColor(titleColor, forState: .Normal)
        btn.setImage(hightLightImage, forState: .Highlighted)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        btn.frame = CGRectMake(0, 0, 60, 44)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        
        return UIBarButtonItem(customView: btn)
    }
    
    class func barButton(image: UIImage, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = ItemLeftImageButton(type: .Custom)
        btn.setImage(image, forState: UIControlState.Normal)
        btn.imageView?.contentMode = UIViewContentMode.Center
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.frame = CGRectMake(0, 0, 44, 44)
        return UIBarButtonItem(customView: btn)
    }
    
    class func barButton(title: String, titleColor: UIColor, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton(frame: CGRectMake(0, 0, 60, 44))
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(titleColor, forState: .Normal)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        if title.characters.count == 2 {
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
        }
        return UIBarButtonItem(customView: btn)
    }

}