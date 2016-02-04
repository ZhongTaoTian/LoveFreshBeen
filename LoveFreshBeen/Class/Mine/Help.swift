//
//  Help.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class Question: NSObject {
    var title: String?
    var texts: [String]? {
        didSet {
            let maxSize = CGSizeMake(ScreenWidth - 40, 100000)
            for i in 0..<texts!.count {
                let str = texts![i] as NSString
                let rowHeight: CGFloat = str.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)], context: nil).size.height + 14
                cellHeight += rowHeight
                everyRowHeight.append(rowHeight)
            }
        }
    }
    
    var everyRowHeight: [CGFloat] = []
    var cellHeight: CGFloat = 0
    
    class func question(dict: NSDictionary) -> Question {
        let question = Question()
        question.title = dict.objectForKey("title") as? String
        question.texts = dict.objectForKey("texts") as? [String]
        
        return question
    }
    
    class func loadQuestions(complete: ([Question] -> ())) {
        let path = NSBundle.mainBundle().pathForResource("HelpPlist", ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        
        var questions: [Question] = []
        if array != nil {
            for dic in array! {
                questions.append(Question.question(dic as! NSDictionary))
            }
        }
        complete(questions)
    }
}


