//
//  HotSearchView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class SearchView: UIView {
    
    private let searchLabel = UILabel()
    private var lastX: CGFloat = 0
    private var lastY: CGFloat = 35
    private var searchButtonClickCallback:((sender: UIButton) -> ())?
    var searchHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchLabel.frame = CGRectMake(0, 0, frame.size.width - 30, 35)
        searchLabel.font = UIFont.systemFontOfSize(15)
        searchLabel.textColor = UIColor.colorWithCustom(140, g: 140, b: 140)
        addSubview(searchLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(frame: CGRect, searchTitleText: String, searchButtonTitleTexts: [String], searchButtonClickCallback:((sender: UIButton) -> ())) {
        self.init(frame: frame)
        
        searchLabel.text = searchTitleText
        
        var btnW: CGFloat = 0
        let btnH: CGFloat = 30
        let addW: CGFloat = 30
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        
        for i in 0..<searchButtonTitleTexts.count {
            let btn = UIButton()
            btn.setTitle(searchButtonTitleTexts[i], forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = UIColor.whiteColor()
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 15
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColor.colorWithCustom(200, g: 200, b: 200).CGColor
            btn.addTarget(self, action: "searchButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            btnW = btn.titleLabel!.width + addW
            
            if frame.width - lastX > btnW {
                btn.frame = CGRectMake(lastX, lastY, btnW, btnH)
            } else {
                btn.frame = CGRectMake(0, lastY + marginY + btnH, btnW, btnH)
            }
            
            lastX = CGRectGetMaxX(btn.frame) + marginX
            lastY = btn.y
            searchHeight = CGRectGetMaxY(btn.frame)
            
            addSubview(btn)
        }
        
        self.searchButtonClickCallback = searchButtonClickCallback
    }
    
    func searchButtonClick(sender: UIButton) {
        if searchButtonClickCallback != nil {
            searchButtonClickCallback!(sender: sender)
        }
    }
    
}
