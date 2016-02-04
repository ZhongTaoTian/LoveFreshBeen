//
//  ShopCartGoodsListView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class ShopCartGoodsListView: UIView {
    
    var goodsHeight: CGFloat = 0

    private var lastViewY: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        let goodses = UserShopCarTool.sharedUserShopCar.getShopCarProducts()
        
        for i in 0..<goodses.count {
            let goods = goodses[i]
            
            buildLineView(CGRectMake(15, lastViewY, ScreenWidth - 15, 0.5))
            
            if goods.pm_desc != "买一赠一" {
                let goodsDetailView = PayGoodsDetailView(frame: CGRectMake(0, lastViewY + 10, ScreenWidth, 20))
                goodsDetailView.goods = goods
                addSubview(goodsDetailView)
                lastViewY += 40
                goodsHeight += 40
            } else {
                let goodsDetailView = PayGoodsDetailView(frame: CGRectMake(0, lastViewY + 10, ScreenWidth, 20))
                goods.pm_desc = ""
                goodsDetailView.goods = goods
                addSubview(goodsDetailView)
                lastViewY += 30
                
                let giftView = PayGoodsDetailView(frame: CGRectMake(0, lastViewY, ScreenWidth, 20))
                goods.pm_desc = "买一赠一"
                giftView.goods = goods
                addSubview(giftView)
                lastViewY += 30
                
                goodsHeight += 60
            }
        }
        
        let lineView = UIView(frame: CGRectMake(15, lastViewY - 0.5, ScreenWidth - 15, 0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        addSubview(lineView)
        
        goodsHeight += 40
        
        let finePriceLabel = UILabel(frame: CGRectMake(50, lastViewY, ScreenWidth - 60, 40))
        finePriceLabel.textAlignment = NSTextAlignment.Right
        finePriceLabel.textColor = UIColor.redColor()
        finePriceLabel.font = UIFont.systemFontOfSize(14)
        finePriceLabel.text = "合计:$" + UserShopCarTool.sharedUserShopCar.getAllProductsPrice()
        addSubview(finePriceLabel)
        
        let lineView1 = UIView(frame: CGRectMake(0, goodsHeight - 1, ScreenWidth, 1))
        lineView1.backgroundColor = UIColor.blackColor()
        lineView1.alpha = 0.1
        addSubview(lineView1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func buildLineView(lineFrame: CGRect) {
        let lineView = UIView(frame: lineFrame)
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        
        addSubview(lineView)
    }
}


class PayGoodsDetailView: UIView {
    
    let titleLabel = UILabel()
    let numberLabel = UILabel()
    let priceLabel = UILabel()
    let giftImageView = UIImageView()
    
    var isShowImageView = false
    
    var goods: Goods? {
        didSet {
            if goods?.is_xf == 1 {
                titleLabel.text = "[精选]" + (goods?.name)!
            } else {
                titleLabel.text = goods?.name
            }
            
            numberLabel.text = "x" + "\(goods!.userBuyNumber)"
            priceLabel.text = "$" + (goods!.price)!.cleanDecimalPointZear()
            
            if !(goods!.pm_desc == "买一赠一") {
                giftImageView.hidden = true
                isShowImageView = false
                layoutSubviews()
            } else  {
                giftImageView.hidden = false
                isShowImageView = true
                priceLabel.hidden = true
                titleLabel.text = "[精选]" + (goods?.name)! + "[赠]"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20))
        
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Left
        addSubview(titleLabel)
        
        numberLabel.font = UIFont.systemFontOfSize(13)
        numberLabel.textColor = UIColor.blackColor()
        numberLabel.textAlignment = NSTextAlignment.Left
        addSubview(numberLabel)
        
        priceLabel.font = UIFont.systemFontOfSize(13)
        priceLabel.textColor = UIColor.blackColor()
        priceLabel.textAlignment = NSTextAlignment.Right
        addSubview(priceLabel)
        
        giftImageView.hidden = true
        giftImageView.image = UIImage(named: "zengsong")
        addSubview(giftImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isShowImageView {
            giftImageView.frame = CGRectMake(15, (height - 20) * 0.5, 40, 20)
            titleLabel.frame = CGRectMake(CGRectGetMaxX(giftImageView.frame) + 5, 0, width * 0.5, height)
            numberLabel.frame = CGRectMake(ScreenWidth * 0.7, 0, 50, height)
        } else {
            titleLabel.frame = CGRectMake(15, 0, width * 0.6, height)
            numberLabel.frame = CGRectMake(ScreenWidth * 0.7, 0, 50, height)
        }
        priceLabel.frame = CGRectMake(width - 60 - 10, 0, 60, 20)
    }
    
}