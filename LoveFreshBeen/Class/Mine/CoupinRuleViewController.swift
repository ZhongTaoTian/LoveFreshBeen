//
//  CoupinRuleViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class CoupinRuleViewController: BaseViewController {
    
    private let webView = UIWebView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavigationH))
    private let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRectMake(0, 0, ScreenWidth, 3))
    var loadURLStr: String? {
        didSet {
            webView.loadRequest(NSURLRequest(URL: NSURL(string: loadURLStr!)!))
        }
    }
    
    var navTitle: String? {
        didSet {
            navigationItem.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        buildWebView()
        webView.addSubview(loadProgressAnimationView)
    }
    
    private func buildWebView() {
        webView.delegate = self
        webView.backgroundColor = UIColor.whiteColor()
        view.addSubview(webView)
    }
}

extension CoupinRuleViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}
