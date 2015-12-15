//
//  Mine.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/3.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

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