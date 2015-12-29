//
//  OrderUserDetailView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/28.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class OrderUserDetailView: UIView {

    let consigneeLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let consigneeAdressLabel = UILabel()
    let lineView = UIView()
    let shopLabel = UILabel()
    let collectionButton = UIButton()
    
    var order: Order? {
        didSet {
            consigneeLabel.text = "收 货 人:    " + (order?.accept_name)!
            phoneNumberLabel.text = order?.telphone
            consigneeAdressLabel.text = "收货地址:    "  + (order?.address)!
            shopLabel.text = "配送店铺    " + (order?.dealer_name)!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        consigneeLabel.textColor = UIColor.colorWithCustom(50, g: 50, b: 50)
        consigneeLabel.font = UIFont.systemFontOfSize(14)
        addSubview(consigneeLabel)
        
        consigneeAdressLabel.textColor = UIColor.colorWithCustom(50, g: 50, b: 50)
        consigneeAdressLabel.font = UIFont.systemFontOfSize(12)
        addSubview(consigneeAdressLabel)
        
        phoneNumberLabel.textColor = UIColor.colorWithCustom(50, g: 50, b: 50)
        phoneNumberLabel.textAlignment = NSTextAlignment.Right
        phoneNumberLabel.font = UIFont.systemFontOfSize(12)
        addSubview(phoneNumberLabel)
        
        lineView.backgroundColor = UIColor.lightGrayColor()
        lineView.alpha = 0.1
        addSubview(lineView)
        
        shopLabel.textColor = UIColor.colorWithCustom(50, g: 50, b: 50)
        shopLabel.font = UIFont.systemFontOfSize(12)
        addSubview(shopLabel)
        
        collectionButton.setTitle("+ 收藏", forState: .Normal)
        collectionButton.setTitleColor(UIColor.colorWithCustom(50, g: 50, b: 50), forState: .Normal)
        collectionButton.setTitle("取消收藏", forState: .Selected)
        collectionButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        collectionButton.setBackgroundImage(UIImage.imageWithColor(LFBNavigationYellowColor, size: CGSizeMake(60, 25), alpha: 1), forState: UIControlState.Normal)
        collectionButton.setBackgroundImage(UIImage.imageWithColor(LFBNavigationYellowColor, size: CGSizeMake(60, 25), alpha: 1), forState: .Selected)
        collectionButton.layer.masksToBounds = true
        collectionButton.layer.cornerRadius = 5
        collectionButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        addSubview(collectionButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftMargin: CGFloat = 10
        let labelHeight: CGFloat = 30
        consigneeLabel.frame = CGRectMake(leftMargin, 5, width * 0.5, labelHeight)
        phoneNumberLabel.frame = CGRectMake(width - width * 0.4 - 10, 5, width * 0.4, labelHeight)
        consigneeAdressLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(consigneeLabel.frame), width - 20, labelHeight)
        lineView.frame = CGRectMake(leftMargin, CGRectGetMaxY(consigneeAdressLabel.frame) + 5, width - leftMargin, 1)
        shopLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(lineView.frame), width * 0.6, 40)
        collectionButton.frame = CGRectMake(width - 60 - 10, CGRectGetMaxY(lineView.frame) + (40 - 25) * 0.5, 60, 25)
    }

}
