//
//  String + Extension.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

extension String {
    
    /// 清除字符串小数点末尾的0
    func cleanDecimalPointZear() -> String {

        let newStr = self as NSString
        var s = NSString()
        
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substringWithRange(NSMakeRange(offset, 1))
            if s.isEqualToString("0") || s.isEqualToString(".") {
                offset--
            } else {
                break
            }
        }
        
        return newStr.substringToIndex(offset + 1)
    }
}