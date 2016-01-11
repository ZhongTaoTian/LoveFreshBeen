//
//  ShopCartCommentsView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 16/1/9.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//

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
