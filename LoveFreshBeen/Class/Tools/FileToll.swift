//
//  FileToll.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6
//

import UIKit

class FileTool: NSObject {
    
    static let fileManager = NSFileManager.defaultManager()
    
    /// 计算单个文件的大小
    class func fileSize(path: String) -> Double {
        
        if fileManager.fileExistsAtPath(path) {
            var dict = try? fileManager.attributesOfItemAtPath(path)
            if let fileSize = dict![NSFileSize] as? Int{
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }
        
        return 0.0
    }
    
    /// 计算整个文件夹的大小
    class func folderSize(path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExistsAtPath(path) {
            let chilerFiles = fileManager.subpathsAtPath(path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                folderSize += FileTool.fileSize(fileFullPathName)
            }
            return folderSize
        }
        return 0
    }
    
    /// 清除文件 同步
    class func cleanFolder(path: String, complete:() -> ()) {

        let chilerFiles = self.fileManager.subpathsAtPath(path)
        for fileName in chilerFiles! {
            let tmpPath = path as NSString
            let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
            if self.fileManager.fileExistsAtPath(fileFullPathName) {
                do {
                    try self.fileManager.removeItemAtPath(fileFullPathName)
                } catch _ {
                    
                }
            }
        }
        
        complete()
    }
    
    /// 清除文件 异步
    class func cleanFolderAsync(path: String, complete:() -> ()) {

        let queue = dispatch_queue_create("cleanQueue", nil)
        dispatch_async(queue) { () -> Void in
            let chilerFiles = self.fileManager.subpathsAtPath(path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                if self.fileManager.fileExistsAtPath(fileFullPathName) {
                    do {
                        try self.fileManager.removeItemAtPath(fileFullPathName)
                    } catch _ {
                    }
                }
            }
            
            complete()
        }
    }
}