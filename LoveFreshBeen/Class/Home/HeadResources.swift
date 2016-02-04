//
//  HeadResources.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class HeadResources: NSObject, DictModelProtocol {

    var msg: String?
    var reqid: String?
    var data: HeadData?
    
    class func loadHomeHeadData(completion:(data: HeadResources?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("首页焦点按钮", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: HeadResources.self) as? HeadResources
            completion(data: data, error: nil)
        }
    }

    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(HeadData.self)"]
    }
}


class HeadData: NSObject, DictModelProtocol {
    var focus: [Activities]?
    var icons: [Activities]?
    var activities: [Activities]?
    
    static func customClassMapping() -> [String : String]? {
        return ["focus" : "\(Activities.self)", "icons" : "\(Activities.self)", "activities" : "\(Activities.self)"]
    }
}


class Activities: NSObject {
    var id: String?
    var name: String?
    var img: String?
    var topimg: String?
    var jptype: String?
    var trackid: String?
    var mimg: String?
    var customURL: String?
}