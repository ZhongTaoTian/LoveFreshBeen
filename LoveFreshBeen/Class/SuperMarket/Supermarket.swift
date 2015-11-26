//
//  SupermarketResouce.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/26.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class Supermarket: NSObject, DictModelProtocol {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: SupermarketResouce?
    
    class func loadSupermarketData(completion:(data: Supermarket?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("supermarket", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: Supermarket.self) as? Supermarket
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(SupermarketResouce.self)"]
    }
}

class SupermarketResouce: NSObject {
    var categories: [Categorie]?
    var products: Products?
    var trackid: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["categories" : "\(Categorie.self)", "products" : "\(Products.self)"]
    }
}

class Categorie: NSObject {
    var id: String?
    var name: String?
    var sort: String?
}

class Products: NSObject {

}

