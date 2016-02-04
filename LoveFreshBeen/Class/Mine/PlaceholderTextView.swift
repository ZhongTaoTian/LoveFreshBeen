//
//  PlaceholderTextView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class PlaceholderTextView: UITextView {
    
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
            updatePlaceholderLabelSize()
        }
    }
    var placeholderColor: UIColor? {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override var font: UIFont? {
        willSet {
            super.font = font

            placeholderLabel.font = newValue
            updatePlaceholderLabelSize()
        }
    }
    
    override var text: String? {
        willSet {
            super.text = text
            textDidChange()
        }
    }
    
    override var attributedText: NSAttributedString? {
        willSet {
            super.attributedText = attributedText
            textDidChange()
        }
    }
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.frame.origin.x = 4
        label.frame.origin.y = 7
        return label
        }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        
        alwaysBounceVertical = true
        font = UIFont.systemFontOfSize(14)
        placeholderColor = UIColor.grayColor()
        placeholderLabel.alpha = 0.6

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func textDidChange() {
        self.placeholderLabel.hidden = hasText()
    }
    
    func updatePlaceholderLabelSize() {
        let maxSize = CGSizeMake(bounds.size.width - 2 * placeholderLabel.frame.origin.x, 100000)
        if placeholder != nil {
        placeholderLabel.frame.size = (placeholder! as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : placeholderLabel.font as AnyObject], context: nil).size
            placeholderLabel.backgroundColor = UIColor.clearColor()
        }
    }
}
