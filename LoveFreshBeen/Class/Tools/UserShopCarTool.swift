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
    
    class var sharedUserShopCar: UserShopCarTool {
        return instance
    }
    
}
