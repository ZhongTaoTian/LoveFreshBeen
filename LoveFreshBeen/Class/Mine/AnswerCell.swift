//
//  AnswerCell.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/15.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
    
    static private let identifier: String = "cellID"
    private let lineView = UIView()
    
    var question: Question? {
        didSet {
            for i in 0..<question!.texts!.count {
                var textY: CGFloat = 0
                for j in 0..<i {
                    textY += question!.everyRowHeight[j]
                }
                
                let textLabel = UILabel(frame: CGRectMake(20, textY, ScreenWidth - 40, question!.everyRowHeight[i]))
                textLabel.text = question!.texts![i]
                textLabel.numberOfLines = 0
                textLabel.textColor = UIColor.grayColor()
                textLabel.font = UIFont.systemFontOfSize(14)
                
                contentView.addSubview(textLabel)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        lineView.alpha = 0.25
        lineView.backgroundColor = UIColor.grayColor()
        contentView.addSubview(lineView)
    }
    
    class func answerCell(tableView: UITableView) -> AnswerCell {
        
//        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? AnswerCell
//        if cell == nil {
           let cell = AnswerCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
//        }
        
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lineView.frame = CGRectMake(20, 0, width - 40, 0.5)
    }
}
