//
//  DiscountPriceView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/24.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class DiscountPriceView: UIView {
    
    private var marketPriceLabel: UILabel?
    private var priceLabel: UILabel?
    private var lineView: UIView?
    private var hasMarketPrice = false
    
    var priceColor: UIColor? {
        didSet {
            if priceLabel != nil {
                priceLabel!.textColor = priceColor
            }
        }
    }
    var marketPriceColor: UIColor? {
        didSet {
            if marketPriceLabel != nil {
                marketPriceLabel!.textColor = marketPriceColor
                
                if lineView != nil {
                    lineView?.backgroundColor = marketPriceColor
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        marketPriceLabel = UILabel()
        marketPriceLabel?.textColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        marketPriceLabel?.font = HomeCollectionTextFont
        addSubview(marketPriceLabel!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        
        marketPriceLabel?.addSubview(lineView!)
        
        priceLabel = UILabel()
        priceLabel?.font = HomeCollectionTextFont
        priceLabel!.textColor = UIColor.redColor()
        addSubview(priceLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(price: String?, marketPrice: String?) {
        self.init()
        
        if price != nil && price?.characters.count != 0 {
            priceLabel!.text = "$" + price!.cleanDecimalPointZear()
            priceLabel!.sizeToFit()
        }
        
        if marketPrice != nil && marketPrice?.characters.count  != 0 {
            marketPriceLabel?.text = "$" + marketPrice!.cleanDecimalPointZear()
            hasMarketPrice = true
            marketPriceLabel?.sizeToFit()
        } else {
            hasMarketPrice = false
        }
        
        if marketPrice == price {
            hasMarketPrice = false
        } else {
            hasMarketPrice = true
        }
        
        marketPriceLabel?.hidden = !hasMarketPrice
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        priceLabel?.frame = CGRectMake(0, 0, priceLabel!.width, height)
        if hasMarketPrice {
            marketPriceLabel?.frame = CGRectMake(CGRectGetMaxX(priceLabel!.frame) + 5, 0, marketPriceLabel!.width, height)
            lineView?.frame = CGRectMake(0, marketPriceLabel!.height * 0.5 - 0.5, marketPriceLabel!.width, 1)
        }
    }
}
