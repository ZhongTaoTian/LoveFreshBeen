//
//  HomeTableHeadView.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/20.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

class HomeTableHeadView: UIView {
    
    private var pageScrollView: PageScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildPageScrollView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildPageScrollView() {
        pageScrollView = PageScrollView(frame: CGRectMake(0, 0, ScreenWidth, 150), placeholder: UIImage(named: "guide_40_3")!)
        pageScrollView?.imageURLSting = ["aa", "bb", "cc", "dd", "rr"]
        addSubview(pageScrollView!)
    }
    
}
