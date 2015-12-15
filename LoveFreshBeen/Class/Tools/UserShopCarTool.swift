//
//  UserShopCarTool.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/30.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//  记录用户购物车商品

import UIKit

class UserShopCarTool: NSObject {

    private static let instance = UserShopCarTool()
    
    private var supermarketProducts = [Goods]()
    
    class var sharedUserShopCar: UserShopCarTool {
        return instance
    }
    
    func userShopCarProductsNumber() -> Int {
        return ShopCarRedDotView.sharedRedDotView.buyNumber
    }
    
    func isEmpty() -> Bool {
        return ShopCarRedDotView.sharedRedDotView.buyNumber == 0
    }
    
    func addSupermarkProductToShopCar(goods: Goods) {
        supermarketProducts.append(goods)
    }
    
    func getShopCarProducts() -> [Goods] {
        return supermarketProducts
    }
    
    func removeSupermarketProduct(goods: Goods) {

    }
}
