//
//  SettingViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class SettingViewController: BaseViewController {
    
    private let subViewHeight: CGFloat = 50
    
    private var aboutMeView: UIView!
    private var cleanCacheView: UIView!
    private var cacheNumberLabel: UILabel!
    private var logoutView: UIView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        buildaboutMeView()
        buildCleanCacheView()
        buildLogoutView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        print(self)
    }
    
    // MARK: - Build UI
    private func setUpUI() {
        navigationItem.title = "设置"
    }
    
    private func buildaboutMeView() {
        aboutMeView = UIView(frame: CGRectMake(0, 10, ScreenWidth, subViewHeight))
        aboutMeView.backgroundColor = UIColor.whiteColor()
        view.addSubview(aboutMeView!)
        
        let tap = UITapGestureRecognizer(target: self, action: "aboutMeViewClick")
        aboutMeView.addGestureRecognizer(tap)
        
        let aboutLabel = UILabel(frame: CGRectMake(20, 0, 200, subViewHeight))
        aboutLabel.text = "关于小熊"
        aboutLabel.font = UIFont.systemFontOfSize(16)
        aboutMeView.addSubview(aboutLabel)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRectMake(ScreenWidth - 20, (subViewHeight - 10) * 0.5, 5, 10)
        aboutMeView.addSubview(arrowImageView)
    }
    
    private func buildCleanCacheView() {
        cleanCacheView = UIView(frame: CGRectMake(0, subViewHeight + 10, ScreenWidth, subViewHeight))
        cleanCacheView.backgroundColor = UIColor.whiteColor()
        view.addSubview(cleanCacheView!)
        
        let cleanCacheLabel = UILabel(frame: CGRectMake(20, 0, 200, subViewHeight))
        cleanCacheLabel.text = "清理缓存"
        cleanCacheLabel.font = UIFont.systemFontOfSize(16)
        cleanCacheView.addSubview(cleanCacheLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "cleanCacheViewClick")
        cleanCacheView.addGestureRecognizer(tap)
        
        cacheNumberLabel = UILabel(frame: CGRectMake(150, 0, ScreenWidth - 165, subViewHeight))
        cacheNumberLabel.textAlignment = NSTextAlignment.Right
        cacheNumberLabel.textColor = UIColor.colorWithCustom(180, g: 180, b: 180)
        cacheNumberLabel.text = String().stringByAppendingFormat("%.2fM", FileTool.folderSize(LFBCachePath)).cleanDecimalPointZear()
        cleanCacheView.addSubview(cacheNumberLabel)
        
        let lineView = UIView(frame: CGRectMake(10, -0.5, ScreenWidth - 10, 0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.08
        cleanCacheView.addSubview(lineView)
    }
    
    private func buildLogoutView() {
        logoutView = UIView(frame: CGRectMake(0, CGRectGetMaxY(cleanCacheView.frame) + 20, ScreenHeight, subViewHeight))
        logoutView.backgroundColor = UIColor.whiteColor()
        view.addSubview(logoutView)
        
        let logoutLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth, subViewHeight))
        logoutLabel.text = "退出当前账号"
        logoutLabel.textColor = UIColor.colorWithCustom(60, g: 60, b: 60)
        logoutLabel.font = UIFont.systemFontOfSize(15)
        logoutLabel.textAlignment = NSTextAlignment.Center
        logoutView.addSubview(logoutLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "logoutViewClick")
        logoutLabel.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    func aboutMeViewClick() {
        let aboutVc = AboltAuthorViewController()
        navigationController?.pushViewController(aboutVc, animated: true)
    }
    
    func cleanCacheViewClick() {
        weak var tmpSelf = self
        ProgressHUDManager.show()
        FileTool.cleanFolder(LFBCachePath) { () -> () in
            tmpSelf!.cacheNumberLabel.text = "0M"
            ProgressHUDManager.dismiss()
        }
    }
    
    func logoutViewClick() {}
}
