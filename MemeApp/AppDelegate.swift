//
//  AppDelegate.swift
//  MemeApp
//
//  Created by Tu Tong on 7/10/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var sharedMemes = [TMMeme]()
    
    static func sharedAppDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        let img = UIImage(named: "IMG_1341")
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 1", bottomText: "Meme 1 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 2", bottomText: "Meme 2 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 3", bottomText: "Meme 3 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 4", bottomText: "Meme 4 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 5", bottomText: "Meme 5 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 6", bottomText: "Meme 6 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 7", bottomText: "Meme 7 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 8", bottomText: "Meme 8 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 9", bottomText: "Meme 9 for testing"))
//        self.sharedMemes.append(TMMeme(orgImage: img!, memeImage: img!, topText: "Meme 10", bottomText: "Meme 10 for testing"))
        
        return true
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

