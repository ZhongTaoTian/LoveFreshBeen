//
//  IconImageTextView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/23.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class IconImageTextView: UIView {

    private var imageView: UIImageView?
    private var textLabel: UILabel?
    private var placeholderImage: UIImage?
    var activitie: Activities? {
        didSet {
           textLabel?.text = activitie?.name
            imageView?.image = placeholderImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.userInteractionEnabled = false
        addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel!.textAlignment = NSTextAlignment.Center
        textLabel!.font = UIFont.systemFontOfSize(12)
        textLabel!.textColor = UIColor.blackColor()
        textLabel?.userInteractionEnabled = false
        addSubview(textLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholderImage: UIImage) {
        self.init(frame: frame)
        self.placeholderImage = placeholderImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRectMake(0, 0, width, height - 20)
        textLabel?.frame = CGRectMake(0, height - 20, width, 20)
    }
}
