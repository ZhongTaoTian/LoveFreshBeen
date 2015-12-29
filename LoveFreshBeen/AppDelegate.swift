
////////////////////////////////////////////////////////////////////
//                          _ooOoo_                               //
//                         o8888888o                              //
//                         88" . "88                              //
//                         (| ^_^ |)                              //
//                         O\  =  /O                              //
//                      ____/`---'\____                           //
//                    .'  \\|     |//  `.                         //
//                   /  \\|||  :  |||//  \                        //
//                  /  _||||| -:- |||||-  \                       //
//                  |   | \\\  -  /// |   |                       //
//                  | \_|  ''\---/''  |   |                       //
//                  \  .-\__  `-`  ___/-. /                       //
//                ___`. .'  /--.--\  `. . ___                     //
//              ."" '<  `.___\_<|>_/___.'  >'"".                  //
//            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
//            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//      ========`-.____`-.___\_____/___.-`____.-'========         //
//                           `=---='                              //
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑            永无BUG              永不修改         //
////////////////////////////////////////////////////////////////////


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var adViewController: ADViewController?
    
// MARK:- public方法
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSThread.sleepForTimeInterval(1.0)
        
        setAppSubject()

        addNotification()
        
        window = UIWindow(frame: ScreenBounds)
        window!.makeKeyAndVisible()

        adViewController = ADViewController()

        weak var tmpSelf = self
        MainAD.loadADData { (data, error) -> Void in
            if data?.data?.img_name != nil {
                tmpSelf!.adViewController!.imageName = data!.data!.img_name
                tmpSelf!.window?.rootViewController = self.adViewController
            }
        }
    
        return true
    }

    func applicationDidReceiveMemoryWarning(application: UIApplication) {}
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
// MARK: - Public Method
    func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainTabbarControllerSucess:", name: ADImageLoadSecussed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainTabbarControllerFale", name: ADImageLoadFail, object: nil)

    }
    
    func showMainTabbarControllerSucess(noti: NSNotification) {
        let adImage = noti.object as! UIImage
        let mainTabBar = MainTabBarController()
        mainTabBar.adImage = adImage
        window?.rootViewController = mainTabBar
    }
    
    func showMainTabbarControllerFale() {
        window!.rootViewController = MainTabBarController()
    }
    

// MARK:- privete Method
    // MARK:主题设置
    private func setAppSubject() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.whiteColor()
        tabBarAppearance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        let navBarnAppearance = UINavigationBar.appearance()
        navBarnAppearance.translucent = false
    }
}



