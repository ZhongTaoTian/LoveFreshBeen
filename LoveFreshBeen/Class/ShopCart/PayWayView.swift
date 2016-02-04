//
//  PayWayView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

enum PayWayType: Int {
    case WeChat   = 0
    case QQPurse  = 1
    case AliPay   = 2
    case Delivery = 3
}

class PayWayView: UIView {
    
    private var payType: PayWayType?
    private let payIconImageView = UIImageView(frame: CGRectMake(20, 10, 20, 20))
    private let payTitleLabel: UILabel = UILabel(frame: CGRectMake(55, 0, 150, 40))
    private var selectedCallback: ((type: PayWayType) -> Void)?
    let selectedButton = UIButton(frame: CGRectMake(ScreenWidth - 10 - 16, (40 - 16) * 0.5, 16, 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        payIconImageView.contentMode = UIViewContentMode.ScaleAspectFill
        addSubview(payIconImageView)
        
        payTitleLabel.textColor = UIColor.blackColor()
        payTitleLabel.font = UIFont.systemFontOfSize(14)
        addSubview(payTitleLabel)
        
        selectedButton.setImage(UIImage(named: "v2_noselected"), forState: UIControlState.Normal)
        selectedButton.setImage(UIImage(named: "v2_selected"), forState: UIControlState.Selected)
        selectedButton.userInteractionEnabled = false
        addSubview(selectedButton)
        
        let lineView = UIView(frame: CGRectMake(15, 0, ScreenWidth - 15, 0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        addSubview(lineView)
        
        let tap = UITapGestureRecognizer(target: self, action: "selectedPayView")
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, payType: PayWayType, selectedCallBack: ((type: PayWayType) -> ())) {
        self.init(frame: frame)
        self.payType = payType
        
        switch payType {
        case .WeChat:
            payIconImageView.image = UIImage(named: "v2_weixin")
            payTitleLabel.text = "微信支付"
            break
        case .QQPurse:
            payIconImageView.image = UIImage(named: "icon_qq")
            payTitleLabel.text = "QQ钱包"
            break
        case .AliPay:
            payIconImageView.image = UIImage(named: "zhifubaoA")
            payTitleLabel.text = "支付宝支付"
            break
        case .Delivery:
            payIconImageView.image = UIImage(named: "v2_dao")
            payTitleLabel.text = "货到付款"
            break
        }
        
        self.selectedCallback = selectedCallBack
    }
    
    // MARK: Action
    func selectedPayView() {
        selectedButton.selected = true
        if selectedCallback != nil && payType != nil {
            selectedCallback!(type: payType!)
        }
    }
    
}


class PayView: UIView {
    
    private var weChatView: PayWayView?
    private var qqPurseView: PayWayView?
    private var alipayView: PayWayView?
    private var deliveryView: PayWayView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        weak var tmpSelf = self
        weChatView = PayWayView(frame: CGRectMake(0, 0, ScreenWidth, 40), payType: .WeChat, selectedCallBack: { (type) -> () in
            tmpSelf!.setSelectedPayView(type)
        })
        weChatView?.selectedButton.selected = true
        qqPurseView = PayWayView(frame: CGRectMake(0, 40, ScreenWidth, 40), payType: .QQPurse, selectedCallBack: { (type) -> () in
            tmpSelf!.setSelectedPayView(type)
        })
        alipayView = PayWayView(frame: CGRectMake(0, 80, ScreenWidth, 40), payType: .AliPay, selectedCallBack: { (type) -> () in
            tmpSelf!.setSelectedPayView(type)
        })
        deliveryView = PayWayView(frame: CGRectMake(0, 120, ScreenWidth, 40), payType: .Delivery, selectedCallBack: { (type) -> () in
            tmpSelf!.setSelectedPayView(type)
        })
        
        addSubview(weChatView!)
        addSubview(qqPurseView!)
        addSubview(alipayView!)
        addSubview(deliveryView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedPayView(type: PayWayType) {
        weChatView?.selectedButton.selected = type.rawValue == PayWayType.WeChat.rawValue
        qqPurseView?.selectedButton.selected = type.rawValue == PayWayType.QQPurse.rawValue
        alipayView?.selectedButton.selected = type.rawValue == PayWayType.AliPay.rawValue
        deliveryView?.selectedButton.selected = type.rawValue == PayWayType.Delivery.rawValue
    }
}





