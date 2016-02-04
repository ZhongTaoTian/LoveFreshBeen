//
//  PageScrollView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class PageScrollView: UIView {
    
    private let imageViewMaxCount = 3
    private var imageScrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var timer: NSTimer?
    private var placeholderImage: UIImage?
    private var imageClick:((index: Int) -> ())?
    var headData: HeadResources? {
        didSet {
            
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
            
            if headData?.data?.focus?.count >= 0 {
                pageControl.numberOfPages = (headData?.data?.focus?.count)!
                pageControl.currentPage = 0
                updatePageScrollView()
                
                startTimer()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildImageScrollView()
        
        buildPageControl()
        
    }
    
    convenience init(frame: CGRect, placeholder: UIImage, focusImageViewClick:((index: Int) -> Void)) {
        self.init(frame: frame)
        placeholderImage = placeholder
        imageClick = focusImageViewClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageScrollView.frame = bounds
        imageScrollView.contentSize = CGSizeMake(CGFloat(imageViewMaxCount) * width, 0)
        for i in 0...imageViewMaxCount - 1 {
            let imageView = imageScrollView.subviews[i] as! UIImageView
            imageView.userInteractionEnabled = true
            imageView.frame = CGRectMake(CGFloat(i) * imageScrollView.width, 0, imageScrollView.width, imageScrollView.height)
        }
        
        let pageW: CGFloat = 80
        let pageH: CGFloat = 20
        let pageX: CGFloat = imageScrollView.width - pageW
        let pageY: CGFloat = imageScrollView.height - pageH
        pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH)
        
        updatePageScrollView()
    }
    
    // MARK: BuildUI
    private func buildImageScrollView() {
        imageScrollView = UIScrollView()
        imageScrollView.bounces = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.pagingEnabled = true
        imageScrollView.delegate = self
        addSubview(imageScrollView)
        
        for _ in 0..<3 {
            let imageView = UIImageView()
            let tap = UITapGestureRecognizer(target: self, action: "imageViewClick:")
            imageView.addGestureRecognizer(tap)
            imageScrollView.addSubview(imageView)
        }
    }
    
    private func buildPageControl() {
        pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_normal")!)
        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_selected")!)
        addSubview(pageControl)
    }
    
    //MARK: 更新内容
    private func updatePageScrollView() {
        for var i = 0; i < imageScrollView.subviews.count; i++ {    
            let imageView = imageScrollView.subviews[i] as! UIImageView
            var index = pageControl.currentPage
            
            if i == 0 {
                index--
            } else if 2 == i {
                index++
            }
            
            if index < 0 {
                index = self.pageControl.numberOfPages - 1
            } else if index >= pageControl.numberOfPages {
                index = 0
            }
            
            imageView.tag = index
            if headData?.data?.focus?.count > 0 {
                imageView.sd_setImageWithURL(NSURL(string: headData!.data!.focus![index].img!), placeholderImage: placeholderImage)
            }
        }
        
        imageScrollView.contentOffset = CGPointMake(imageScrollView.width, 0)
    }
    

    // MARK: Timer
    private func startTimer() {
        timer = NSTimer(timeInterval: 3.0, target: self, selector: "next", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func next() {
        imageScrollView.setContentOffset(CGPointMake(2.0 * imageScrollView.frame.size.width, 0), animated: true)
    }
    
    // MARK: ACTION
    func imageViewClick(tap: UITapGestureRecognizer) {
        if imageClick != nil {
            imageClick!(index: tap.view!.tag)
        }
    }
}

// MARK:- UIScrollViewDelegate
extension PageScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page: Int = 0
        var minDistance: CGFloat = CGFloat(MAXFLOAT)
        for i in 0..<imageScrollView.subviews.count {
            let imageView = imageScrollView.subviews[i] as! UIImageView
            let distance:CGFloat = abs(imageView.x - scrollView.contentOffset.x)
            
            if distance < minDistance {
                minDistance = distance
                page = imageView.tag
            }
        }
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageScrollView()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        updatePageScrollView()
    }
}
