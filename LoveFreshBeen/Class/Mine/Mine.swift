//
//  Mine.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class Mine: NSObject , DictModelProtocol{

    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: MineData?
    
    class func loadMineData(completion:(data: Mine?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("Mine", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: Mine.self) as? Mine
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(MineData.self)"]
    }
}

class MineData: NSObject {
    var has_new: Int = -1
    var has_new_user: Int = -1
    var availble_coupon_num = 0
}