//
//  BuyView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class BuyView: UIView {
    
    var clickAddShopCar: (() -> ())?
    var zearIsShow = false
    
    /// 添加按钮
    private lazy var addGoodsButton: UIButton = {
        let addGoodsButton = UIButton(type: .Custom)
        addGoodsButton.setImage(UIImage(named: "v2_increase"), forState: .Normal)
        addGoodsButton.addTarget(self, action: "addGoodsButtonClick", forControlEvents: .TouchUpInside)
        return addGoodsButton
        }()
    
    /// 删除按钮
    private lazy var reduceGoodsButton: UIButton = {
        let reduceGoodsButton = UIButton(type: .Custom)
        reduceGoodsButton.setImage(UIImage(named: "v2_reduce")!, forState: .Normal)
        reduceGoodsButton.addTarget(self, action: "reduceGoodsButtonClick", forControlEvents: .TouchUpInside)
        reduceGoodsButton.hidden = false
        return reduceGoodsButton
        }()
    
    /// 购买数量
    private lazy var buyCountLabel: UILabel = {
        let buyCountLabel = UILabel()
        buyCountLabel.hidden = false
        buyCountLabel.text = "0"
        buyCountLabel.textColor = UIColor.blackColor()
        buyCountLabel.textAlignment = NSTextAlignment.Center
        buyCountLabel.font = HomeCollectionTextFont
        return buyCountLabel
        }()
    
    /// 补货中
    private lazy var supplementLabel: UILabel = {
        let supplementLabel = UILabel()
        supplementLabel.text = "补货中"
        supplementLabel.hidden = true
        supplementLabel.textAlignment = NSTextAlignment.Right
        supplementLabel.textColor = UIColor.redColor()
        supplementLabel.font = HomeCollectionTextFont
        return supplementLabel
        }()
    
    private var buyNumber: Int = 0 {
        willSet {
            if newValue > 0 {
                reduceGoodsButton.hidden = false
                buyCountLabel.text = "\(newValue)"
            } else {
                reduceGoodsButton.hidden = true
                buyCountLabel.hidden = false
                buyCountLabel.text = "\(newValue)"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addGoodsButton)
        addSubview(reduceGoodsButton)
        addSubview(buyCountLabel)
        addSubview(supplementLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buyCountWidth: CGFloat = 25
        addGoodsButton.frame = CGRectMake(width - height - 2, 0, height, height)
        buyCountLabel.frame = CGRectMake(CGRectGetMinX(addGoodsButton.frame) - buyCountWidth, 0, buyCountWidth, height)
        reduceGoodsButton.frame = CGRectMake(CGRectGetMinX(buyCountLabel.frame) - height, 0, height, height)
        supplementLabel.frame = CGRectMake(CGRectGetMinX(reduceGoodsButton.frame), 0, height + buyCountWidth + height, height)
    }
    
    /// 商品模型Set方法
    var goods: Goods? {
        didSet {
            buyNumber = goods!.userBuyNumber
            
            if goods?.number <= 0 {
                showSupplementLabel()
            } else {
                hideSupplementLabel()
            }
            if 0 == buyNumber {
                reduceGoodsButton.hidden = true && !zearIsShow
                buyCountLabel.hidden = true && !zearIsShow
            } else {
                reduceGoodsButton.hidden = false
                buyCountLabel.hidden = false
            }
        }
    }
    
    /// 显示补货中
    private func showSupplementLabel() {
        supplementLabel.hidden = false
        addGoodsButton.hidden = true
        reduceGoodsButton.hidden = true
        buyCountLabel.hidden = true
    }
    
    /// 隐藏补货中,显示添加按钮
    private func hideSupplementLabel() {
        supplementLabel.hidden = true
        addGoodsButton.hidden = false
        reduceGoodsButton.hidden = false
        buyCountLabel.hidden = false
    }
    
    // MARK: - Action
    func addGoodsButtonClick() {
        
        if buyNumber >= goods?.number {
            NSNotificationCenter.defaultCenter().postNotificationName(HomeGoodsInventoryProblem, object: goods?.name)
            return
        }
        
        reduceGoodsButton.hidden = false
        buyNumber++
        goods?.userBuyNumber = buyNumber
        buyCountLabel.text = "\(buyNumber)"
        buyCountLabel.hidden = false
        
        if clickAddShopCar != nil {
            clickAddShopCar!()
        }
        
        ShopCarRedDotView.sharedRedDotView.addProductToRedDotView(true)
        UserShopCarTool.sharedUserShopCar.addSupermarkProductToShopCar(goods!)
        NSNotificationCenter.defaultCenter().postNotificationName(LFBShopCarBuyPriceDidChangeNotification, object: nil, userInfo: nil)
    }
    
    func reduceGoodsButtonClick() {
        if buyNumber <= 0 {
            return
        }
        
        buyNumber--
        goods?.userBuyNumber = buyNumber
        if buyNumber == 0 {
            reduceGoodsButton.hidden = true && !zearIsShow
            buyCountLabel.hidden = true && !zearIsShow
            buyCountLabel.text = zearIsShow ? "0" : ""
            UserShopCarTool.sharedUserShopCar.removeSupermarketProduct(goods!)
        } else {
            buyCountLabel.text = "\(buyNumber)"
        }
        
        ShopCarRedDotView.sharedRedDotView.reduceProductToRedDotView(true)
        NSNotificationCenter.defaultCenter().postNotificationName(LFBShopCarBuyPriceDidChangeNotification, object: nil, userInfo: nil)
    }
}


