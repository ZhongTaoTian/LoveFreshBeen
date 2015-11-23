//
//  HotView.swift
//  LoveFreshBeen
//
//  Created by MacBook on 15/11/21.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class HotView: UIView {

    private let iconH = (ScreenWidth - 20) * 0.25
    private let iconW: CGFloat = 80
    
    var hotButtonClick:((index: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, hotButtonClick: ((index: Int) -> Void)) {
        self.init(frame:frame)
        self.hotButtonClick = hotButtonClick
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: 模型的Set方法
    var headData: HeadData? {
        didSet {
            if headData?.icons?.count > 0 {
                for i in 0..<headData!.icons!.count {
                
                }
            }
        }
    }

}
