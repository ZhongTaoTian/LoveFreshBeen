//
//  UIDevice + Extension.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

extension UIDevice {
        
    class func currentDeviceScreenMeasurement() -> CGFloat {
        var deviceScree: CGFloat = 3.5
        
        if ((568 == ScreenHeight && 320 == ScreenWidth) || (1136 == ScreenHeight && 640 == ScreenWidth)) {
            deviceScree = 4.0;
        } else if ((667 == ScreenHeight && 375 == ScreenWidth) || (1334 == ScreenHeight && 750 == ScreenWidth)) {
            deviceScree = 4.7;
        } else if ((736 == ScreenHeight && 414 == ScreenWidth) || (2208 == ScreenHeight && 1242 == ScreenWidth)) {
            deviceScree = 5.5;
        }
        
        return deviceScree
    }
}