//
//  MineTabeHeadView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

enum MineHeadViewButtonType: Int {
    case Order = 0
    case Coupon = 1
    case Message = 2
}

class MineTabeHeadView: UIView {
    
    var mineHeadViewClick:((type: MineHeadViewButtonType) -> ())?
    private let orderView = MineOrderView()
    private let couponView = MineCouponView()
    private let messageView = MineMessageView()
    private var couponNumber: UIButton?
    private let line1 = UIView()
    private let line2 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let subViewW = width / 3.0
        orderView.frame = CGRectMake(0, 0, subViewW, height)
        couponView.frame = CGRectMake(subViewW, 0, subViewW, height)
        messageView.frame = CGRectMake(subViewW * 2, 0, subViewW, height)
        couponNumber?.frame = CGRectMake(subViewW * 1.56, 12, 15, 15)
        line1.frame = CGRectMake(subViewW - 0.5, height * 0.2, 1, height * 0.6)
        line2.frame = CGRectMake(subViewW * 2 - 0.5, height * 0.2, 1, height * 0.6)
    }
    
    func click(tap: UIGestureRecognizer) {
        if mineHeadViewClick != nil {
            
            switch tap.view!.tag {
                
            case MineHeadViewButtonType.Order.rawValue:
                mineHeadViewClick!(type: MineHeadViewButtonType.Order)
                break
                
            case MineHeadViewButtonType.Coupon.rawValue:
                mineHeadViewClick!(type: MineHeadViewButtonType.Coupon)
                break
                
            case MineHeadViewButtonType.Message.rawValue:
                mineHeadViewClick!(type: MineHeadViewButtonType.Message)
                break
                
            default: break
            }
        }
        
    }
    
    private func buildUI() {
        orderView.tag = 0
        addSubview(orderView)
        
        couponView.tag = 1
        addSubview(couponView)
        
        messageView.tag = 2
        addSubview(messageView)
        
        for index in 0...2 {
            let tap = UITapGestureRecognizer(target: self, action: "click:")
            let subView = viewWithTag(index)
            subView?.addGestureRecognizer(tap)
        }
        
        line1.backgroundColor = UIColor.grayColor()
        line1.alpha = 0.3
        addSubview(line1)
        
        line2.backgroundColor = UIColor.grayColor()
        line2.alpha = 0.3
        addSubview(line2)
        
        couponNumber = UIButton(type: .Custom)
        couponNumber?.setBackgroundImage(UIImage(named: "redCycle"), forState: UIControlState.Normal)
        couponNumber?.setTitleColor(UIColor.redColor(), forState: .Normal)
        couponNumber?.userInteractionEnabled = false
        couponNumber?.titleLabel?.font = UIFont.systemFontOfSize(8)
        couponNumber?.hidden = true
        addSubview(couponNumber!)
    }
    
    func setCouponNumer(number: Int) {
        if number > 0 && number <= 9 {
            couponNumber?.hidden = false
            couponNumber?.setTitle("\(number)", forState: .Normal)
        } else if number > 9 && number < 100 {
            couponNumber?.setTitle("\(number)", forState: .Normal)
            couponNumber?.hidden = false
        } else {
            couponNumber?.hidden = true
        }
    }
}


class MineOrderView: UIView {
    
    var btn: MineUpImageDownText!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText(frame: CGRectZero, title: "我的订单", imageName: "v2_my_order_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRectMake(10, 10, width - 20, height - 20)
    }
}

class MineCouponView: UIView {
    
    var btn: UpImageDownTextButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText(frame: CGRectZero, title: "优惠劵", imageName: "v2_my_coupon_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRectMake(10, 10, width - 20, height - 20)
    }
    
}

class MineMessageView: UIView {
    var btn: UpImageDownTextButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText(frame: CGRectZero, title: "我的消息", imageName: "v2_my_message_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRectMake(10, 10, width - 20, height - 20)
    }
}

class MineUpImageDownText: UpImageDownTextButton {
    
    init(frame: CGRect, title: String, imageName: String) {
        super.init(frame: frame)
        setTitle(title, forState: .Normal)
        setTitleColor(UIColor.colorWithCustom(80, g: 80, b: 80), forState: .Normal)
        setImage(UIImage(named: imageName), forState: .Normal)
        userInteractionEnabled = false
        titleLabel?.font = UIFont.systemFontOfSize(13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}