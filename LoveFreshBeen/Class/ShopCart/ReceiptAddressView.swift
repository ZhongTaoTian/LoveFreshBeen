//
//  ReceiptAddressView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class ReceiptAddressView: UIView {
    
    private let topImageView = UIImageView(image: UIImage(named: "v2_shoprail"))
    private let bottomImageView = UIImageView(image: UIImage(named: "v2_shoprail"))
    private let consigneeLabel = UILabel()
    private let phoneNumLabel = UILabel()
    private let receiptAdressLabel = UILabel()
    private let consigneeTextLabel = UILabel()
    private let phoneNumTextLabel = UILabel()
    private let receiptAdressTextLabel = UILabel()
    private let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
    private let modifyButton = UIButton()
    var modifyButtonClickCallBack: (() -> ())?
    var adress: Adress? {
        didSet {
            if adress != nil{
                consigneeTextLabel.text = adress!.accept_name! + (adress!.gender! == "1" ? " 先生" : " 女士")
                phoneNumTextLabel.text = adress!.telphone
                receiptAdressTextLabel.text = adress!.address
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubview(topImageView)
        addSubview(bottomImageView)
        addSubview(arrowImageView)
        
        modifyButton.setTitle("修改", forState: UIControlState.Normal)
        modifyButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        modifyButton.addTarget(self, action: "modifyButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        modifyButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        addSubview(modifyButton)
        
        initLabel(consigneeLabel, text: "收  货  人  ")
        initLabel(phoneNumLabel, text:  "电       话  ")
        initLabel(receiptAdressLabel, text: "收货地址  ")
        initLabel(consigneeTextLabel, text: "")
        initLabel(phoneNumTextLabel, text: "")
        initLabel(receiptAdressTextLabel, text: "")
    }
    
    convenience init(frame: CGRect, modifyButtonClickCallBack:(() -> ())) {
        self.init(frame: frame)
        
        self.modifyButtonClickCallBack = modifyButtonClickCallBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftMargin: CGFloat = 15
        
        topImageView.frame = CGRectMake(0, 0, width, 2)
        bottomImageView.frame = CGRectMake(0, height - 2, width, 2)
        consigneeLabel.frame = CGRectMake(leftMargin, 10, consigneeLabel.width, consigneeLabel.height)
        consigneeTextLabel.frame = CGRectMake(CGRectGetMaxX(consigneeLabel.frame) + 5, consigneeLabel.y, 150, consigneeLabel.height)
        phoneNumLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(consigneeLabel.frame) + 5, phoneNumLabel.width, phoneNumLabel.height)
        phoneNumTextLabel.frame = CGRectMake(consigneeTextLabel.x, phoneNumLabel.y, 150, phoneNumLabel.height)
        receiptAdressLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(phoneNumTextLabel.frame) + 5, receiptAdressLabel.width, receiptAdressLabel.height)
        receiptAdressTextLabel.frame = CGRectMake(consigneeTextLabel.x, receiptAdressLabel.y, 150, receiptAdressLabel.height)
        modifyButton.frame = CGRectMake(width - 60, 0, 30, height)
        arrowImageView.frame = CGRectMake(width - 15, (height - arrowImageView.height) * 0.5, arrowImageView.width, arrowImageView.height)
    }
    
    private func initLabel(label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.blackColor()
        label.sizeToFit()
        addSubview(label)
    }
    
    func modifyButtonClick() {
        if modifyButtonClickCallBack != nil {
            modifyButtonClickCallBack!()
        }
    }
}
