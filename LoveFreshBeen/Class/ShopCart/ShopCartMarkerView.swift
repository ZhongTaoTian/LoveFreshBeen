//
//  ShopCartMarkerView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 16/1/9.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//

import UIKit

class ShopCartMarkerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let marketHeight: CGFloat = 60
        
        
        backgroundColor = UIColor.whiteColor()
        
        
        addSubview(lineView(CGRectMake(0, 0, ScreenWidth, 0.5)))
        
        let rocketImageView = UIImageView(image: UIImage(named: "icon_lighting"))
        rocketImageView.frame = CGRectMake(15, 5, 20, 20)
        addSubview(rocketImageView)
        
        let redDotImaegView = UIImageView(image: UIImage(named: "reddot"))
        redDotImaegView.frame = CGRectMake(15, (marketHeight - CGRectGetMaxY(rocketImageView.frame) - 4) * 0.5 + CGRectGetMaxY(rocketImageView.frame), 4, 4)
        addSubview(redDotImaegView)
        
        let marketTitleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(rocketImageView.frame) + 10, 5, ScreenWidth * 0.6, 20))
        marketTitleLabel.text = "闪电超市"
        marketTitleLabel.font = UIFont.systemFontOfSize(12)
        marketTitleLabel.textColor = UIColor.lightGrayColor()
        addSubview(marketTitleLabel)
        
        let marketLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(redDotImaegView.frame) + 5, CGRectGetMaxY(rocketImageView.frame), ScreenWidth * 0.7, 60 - CGRectGetMaxY(rocketImageView.frame)))
        marketLabel.text = "   22:00前满$30免运费,22:00后满$50面运费"
        marketLabel.textColor = UIColor.lightGrayColor()
        marketLabel.font = UIFont.systemFontOfSize(10)
        addSubview(marketLabel)
        
        addSubview(lineView(CGRectMake(0, marketHeight - 0.5, ScreenWidth, 0.5)))
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
