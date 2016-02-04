//
//  ProgressHUDManager.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit


class ProgressHUDManager {
    
    class func setBackgroundColor(color: UIColor) {
        SVProgressHUD.setBackgroundColor(color)
    }
    
    class func setForegroundColor(color: UIColor) {
        SVProgressHUD.setForegroundColor(color)
    }
    
    class func setSuccessImage(image: UIImage) {
        SVProgressHUD.setSuccessImage(image)
    }
    
    class func setErrorImage(image: UIImage) {
        SVProgressHUD.setErrorImage(image)
    }
    
    class func setFont(font: UIFont) {
        SVProgressHUD.setFont(UIFont.systemFontOfSize(16))
    }

    class func showImage(image: UIImage, status: String) {
        SVProgressHUD.showImage(image, status: status)
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func showWithStatus(status: String) {
        SVProgressHUD.showWithStatus(status)
    }
    
    class func isVisible() -> Bool {
       return SVProgressHUD.isVisible()
    }
    
    class func showSuccessWithStatus(string: String) {
        SVProgressHUD.showSuccessWithStatus(string)
    }
}
