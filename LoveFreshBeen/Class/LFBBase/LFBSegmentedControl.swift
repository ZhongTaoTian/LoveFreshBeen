//
//  LFBSegmentedControl.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/15.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class LFBSegmentedControl: UISegmentedControl {
    
    var segmentedClick:((index: Int) -> Void)?
    
    override init(items: [AnyObject]?) {
        super.init(items: items)
        tintColor = LFBNavigationYellowColor
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Selected)
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithCustom(100, g: 100, b: 100)], forState: UIControlState.Normal)
        addTarget(self, action: "segmentedControlDidValuechange:", forControlEvents: UIControlEvents.ValueChanged)
        selectedSegmentIndex = 0
    }
    
    convenience init(items: [AnyObject]?, didSelectedIndex: (index: Int) -> ()) {
        self.init(items: items)
        
        segmentedClick = didSelectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func segmentedControlDidValuechange(sender: UISegmentedControl) {
        if segmentedClick != nil {
            segmentedClick!(index: sender.selectedSegmentIndex)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
