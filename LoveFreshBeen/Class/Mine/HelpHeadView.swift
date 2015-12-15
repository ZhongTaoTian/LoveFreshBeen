//
//  HelpHeadView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/15.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class HelpHeadView: UITableViewHeaderFooterView {

    var questionLabel: UILabel?
    var arrowImageView: UIImageView?
    var isSelected: Bool = false {
        willSet {
            if newValue {
                arrowImageView!.image = UIImage(named: "cell_arrow_up_accessory")
            } else {
                arrowImageView!.image = UIImage(named: "cell_arrow_down_accessory")
            }
        }
    }
    let lineView = UIView()
    
    weak var delegate: HelpHeadViewDelegate?
    
    var question: Question? {
        didSet {
            questionLabel?.text = question?.title
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.whiteColor()
        
        questionLabel = UILabel()
        questionLabel?.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(questionLabel!)
        
        arrowImageView = UIImageView(image: UIImage(named: "cell_arrow_down_accessory"))
        contentView.addSubview(arrowImageView!)
        
        let tap = UITapGestureRecognizer(target: self, action: "headViewDidClick:")
        contentView.addGestureRecognizer(tap)
        
        lineView.alpha = 0.08
        lineView.backgroundColor = UIColor.blackColor()
        contentView.addSubview(lineView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        questionLabel?.frame = CGRectMake(20, 0, width - 20, height)
        arrowImageView?.frame = CGRectMake(width - 30, (height - arrowImageView!.size.height) * 0.5, arrowImageView!.size.width, arrowImageView!.size.height)
        lineView.frame = CGRectMake(0, 0, width, 1)
        
    }
    
    func headViewDidClick(tap: UITapGestureRecognizer) {
        isSelected = !isSelected
        
        if delegate != nil && delegate!.respondsToSelector("headViewDidClck:") {

            delegate!.headViewDidClck!(self)
        }
    }
}

@objc protocol HelpHeadViewDelegate: NSObjectProtocol {
    optional
    func headViewDidClck(headView: HelpHeadView)
}
