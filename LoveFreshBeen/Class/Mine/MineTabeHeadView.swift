//
//  MineTabeHeadView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/19.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

enum MineHeadViewButtonType: Int {
    case Order = 0
    case Coupon = 1
    case Message = 2
}

class MineTabeHeadView: UIView {
    
    private let orderView = MineOrderView()
    private let couponView = MineCouponView()
    private let messageView = MineMessageView()
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
        line1.frame = CGRectMake(subViewW - 0.5, height * 0.2, 1, height * 0.6)
        line2.frame = CGRectMake(subViewW * 2 - 0.5, height * 0.2, 1, height * 0.6)
    }
    
    func click(tap: UIGestureRecognizer) {
        print(tap.view!.tag)
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