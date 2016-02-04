//
//  ShopCartCommentsView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class ShopCartCommentsView: UIView {

    var textField = UITextField()
    private let signCommentsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubview(lineView(CGRectMake(10, 0, ScreenWidth - 10, 0.5)))
        
        signCommentsLabel.text = "收货备注"
        signCommentsLabel.textColor = UIColor.blackColor()
        signCommentsLabel.font = UIFont.systemFontOfSize(15)
        signCommentsLabel.sizeToFit()
        signCommentsLabel.frame = CGRectMake(15, 0, signCommentsLabel.width, ShopCartRowHeight)
        addSubview(signCommentsLabel)
        
        textField.placeholder = "可输入100字以内特殊要求内容"
        textField.frame = CGRectMake(CGRectGetMaxX(signCommentsLabel.frame) + 10, 10, ScreenWidth - CGRectGetMaxX(signCommentsLabel.frame) - 10 - 20, ShopCartRowHeight - 20)
        textField.font = UIFont.systemFontOfSize(15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        addSubview(textField)
        
        addSubview(lineView(CGRectMake(0, ShopCartRowHeight - 0.5, ScreenWidth, 0.5)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func lineView(frame: CGRect) -> UIView {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        return lineView
    }
}
