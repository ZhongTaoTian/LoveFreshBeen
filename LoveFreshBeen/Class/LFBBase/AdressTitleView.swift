//
//  AdressTitleView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class AdressTitleView: UIView {

    private let playLabel = UILabel()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView(image: UIImage(named: "allowBlack"))
    var adressWidth: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        playLabel.text = "配送至"
        playLabel.textColor = UIColor.blackColor()
        playLabel.backgroundColor = UIColor.clearColor()
        playLabel.layer.borderWidth = 0.5
        playLabel.layer.borderColor = UIColor.blackColor().CGColor
        playLabel.font = UIFont.systemFontOfSize(10)
        playLabel.sizeToFit()
        playLabel.textAlignment = NSTextAlignment.Center
        playLabel.frame = CGRectMake(0, (frame.size.height - playLabel.height - 2) * 0.5, playLabel.frame.size.width + 6, playLabel.frame.size.height + 2)
        addSubview(playLabel)

        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(15)
        if let adress = UserInfo.sharedUserInfo.defaultAdress() {
            if adress.address?.characters.count > 0 {
                let adressStr = adress.address! as NSString
                if adressStr.componentsSeparatedByString(" ").count > 1 {
                    titleLabel.text = adressStr.componentsSeparatedByString(" ")[0]
                } else {
                    titleLabel.text = adressStr as String
                }

            } else {
                titleLabel.text = "你在哪里呀"
            }
            
        } else {
            titleLabel.text = "你在哪里呀"
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(CGRectGetMaxX(playLabel.frame) + 4, 0, titleLabel.width, frame.height)
        addSubview(titleLabel)
        
        arrowImageView.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 4, (frame.size.height - 6) * 0.5, 10, 6)
        addSubview(arrowImageView)
        
        adressWidth = CGRectGetMaxX(arrowImageView.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(text: String) {
        let adressStr = text as NSString
        if adressStr.componentsSeparatedByString(" ").count > 1 {
            titleLabel.text = adressStr.componentsSeparatedByString(" ")[0]
        } else {
            titleLabel.text = adressStr as String
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(CGRectGetMaxX(playLabel.frame) + 4, 0, titleLabel.width, frame.height)
        arrowImageView.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 4, (frame.size.height - arrowImageView.height) * 0.5, arrowImageView.width, arrowImageView.height)
        adressWidth = CGRectGetMaxX(arrowImageView.frame)
    }
}
