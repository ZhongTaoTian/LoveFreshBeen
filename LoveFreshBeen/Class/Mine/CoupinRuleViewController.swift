//
//  CoupinRuleViewController.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/12/7.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

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
