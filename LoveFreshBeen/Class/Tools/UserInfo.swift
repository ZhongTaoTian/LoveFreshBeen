//
//  UserInfo.swift
//  LoveFreshBeen
//
//  Created by sfbest on 16/1/8.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  当前用户信息

import UIKit

class UserInfo: NSObject {

    private static let instance = UserInfo()
    
    private var allAdress: [Adress]?
    
    class var sharedUserInfo: UserInfo {
        return instance
    }
    
    func hasDefaultAdress() -> Bool {
        if allAdress != nil {
            return true
        } else {
            return false
        }
    }
    
    func setAllAdress(adresses: [Adress]) {
        allAdress = adresses
    }
    
    func cleanAllAdress() {
        allAdress = nil
    }
    
    func defaultAdress() -> Adress {
        return allAdress![0]
    }
}
