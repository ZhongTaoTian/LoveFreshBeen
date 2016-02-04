//
//  BindingCouponView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class BindingCouponView: UIView {

    var bindingButtonClickBack:((couponTextFiled: UITextField) -> ())?
    
    private lazy var couponTextFiled: UITextField = {
        let couponTextFiled = UITextField()

        couponTextFiled.keyboardType = UIKeyboardType.NumberPad
        couponTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        couponTextFiled.autocorrectionType = UITextAutocorrectionType.No
        couponTextFiled.font = UIFont.systemFontOfSize(14)
        let placeholder = NSAttributedString(string: "请输入优惠劵号码", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14), NSForegroundColorAttributeName : UIColor(red: 50 / 255.0, green: 50 / 255.0, blue: 50 / 255.0, alpha: 0.8)])
        
        couponTextFiled.attributedPlaceholder = placeholder
        
        return couponTextFiled
    }()

    private lazy var bindingButton: UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = LFBNavigationYellowColor
        btn.setTitle("绑定", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: "bindingButtonClick", forControlEvents: UIControlEvents.TouchUpInside)

        return btn
        }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.2
        
        return lineView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(couponTextFiled)
        addSubview(bindingButton)
        addSubview(lineView)
    }

    convenience init(frame: CGRect, bindingButtonClickBack:((couponTextFiled: UITextField) -> ())) {
        self.init(frame: frame)
        
        self.bindingButtonClickBack = bindingButtonClickBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let topBottomMargin: CGFloat = 10
        let bingdingButtonWidth: CGFloat = 60
        couponTextFiled.frame = CGRectMake(CouponViewControllerMargin, topBottomMargin, width - 2 * CouponViewControllerMargin - bingdingButtonWidth - 10, height - 2 * topBottomMargin)
        bindingButton.frame = CGRectMake(width - CouponViewControllerMargin - bingdingButtonWidth, topBottomMargin, bingdingButtonWidth, couponTextFiled.height)
        lineView.frame = CGRectMake(0, height - 0.5, width, 0.5)
    }
    
// MARK: Action 
    func bindingButtonClick() {
        if bindingButtonClickBack != nil {
            bindingButtonClickBack!(couponTextFiled: couponTextFiled)
        }
    }
}
