//
//  Help.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/15.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

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


