//
//  YellowShopCarView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 16/1/13.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//

import UIKit

class YellowShopCarView: UIView {

    private var shopViewClick:(() -> ())?
    private let yellowImageView = UIImageView()
    private let redDot = ShopCarRedDotView.sharedRedDotView
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, 61, 61))
        
        clipsToBounds = false
        
        yellowImageView.image = UIImage(named: "v2_shopNoBorder")
        yellowImageView.frame = CGRectMake(0, 0, 61, 61)
        addSubview(yellowImageView)
        
        let shopCarImageView = UIImageView(image: UIImage(named: "v2_whiteShopBig"))
        shopCarImageView.frame = CGRectMake((61 - 45) * 0.5, (61 - 45) * 0.5, 45, 45)
        addSubview(shopCarImageView)
        
        redDot.frame = CGRectMake(frame.size.width - 20, 0, 20, 20)
        addSubview(redDot)
        
        userInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, shopViewClick:(() -> ())) {
        self.init(frame: frame)

        let tap = UITapGestureRecognizer(target: self, action: "shopViewShowShopCar")
        addGestureRecognizer(tap)
        
        self.shopViewClick = shopViewClick
    }
    
    func shopViewShowShopCar() {
        if shopViewClick != nil {
            shopViewClick!()
        }
    }
}
