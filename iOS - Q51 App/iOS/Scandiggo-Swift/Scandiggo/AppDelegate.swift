//
//  AppDelegate.swift
//  Scandiggo
//
//  Created by WTS on 28/01/16.
//  Copyright © 2016 wings. All rights reserved.
//#084959
//_placeholderLabel.textColor

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var drawer = MMDrawerController()
    var loginRootViewController = UIViewController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().barTintColor = NavigaionColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        IQKeyboardManager.sharedManager().enable = true
        
        loginRootViewController = (self.window?.rootViewController)!
        
        return true
    }
    
    func myCardNavControl() -> UIViewController {
        return drawer.centerViewController
    }
    
    func logout(){
        drawer.removeFromParentViewController()
        self.window?.rootViewController = loginRootViewController
    }
    
    func setMyCardNavigationView() {
        //loginRootViewController = (self.window?.rootViewController)!
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mycardView = mainStoryboard.instantiateViewControllerWithIdentifier ("MyCardViewController") as! MyCardViewController
        let leftSideMenu = mainStoryboard.instantiateViewControllerWithIdentifier ("LeftSideMenuViewController") as! LeftSideMenuViewController
        
        let mycard = UINavigationController(rootViewController: mycardView)
        let leftside = UINavigationController(rootViewController: leftSideMenu)
        
        drawer = MMDrawerController(centerViewController: mycard, leftDrawerViewController: leftside)
        //drawer.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
        window?.rootViewController = drawer
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

