//
//  AppDelegate.swift
//  LoveFreshBeen
//
//  Created by sfbest on 15/11/18.
//  Copyright © 2015年 tianzhongtao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
// MARK:- public方法
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setAppSubject()
        
        let tabBarVC = MainTabBarController()
        window = UIWindow(frame: ScreenBounds)
        window!.rootViewController = tabBarVC
        window!.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {}
    
    
// MARK:- privete方法
    // MARK:主题设置
    private func setAppSubject() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.whiteColor()

        let navBarnAppearance = UINavigationBar.appearance()
        navBarnAppearance.translucent = false
    }

    
}
