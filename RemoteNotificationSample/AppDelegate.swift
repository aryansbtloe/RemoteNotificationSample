//
//  AppDelegate.swift
//  RemoteNotificationSample
//
//  Created by Alok Singh on 11/08/17.
//  Skype           : alok.singh.confident
//  Phone/Whatsapp  : 8287757210
//  Email           : alok.singh.confident@gmail.com
//  Official Email  : alok.k.singh@orahi.com
//  Github          : https://github.com/aryansbtloe
//  LinkedIn        : https://in.linkedin.com/in/alok-kumar-singh-09141164
//  Facebook        : https://www.facebook.com/aryansbtloe
//  Stack OverFlow  : http://stackoverflow.com/users/911270/alok-singh
//  CocoaControls   : https://www.cocoacontrols.com/authors/aryansbtloe
//  Copyright (c) 2017 Orahi. All rights reserved.
//

import UIKit
import UserNotifications

let KNotificationRemoteNotificationReceived = "KNotificationRemoteNotificationReceived"
let KNotificationDeviceTokenFetched         = "KNotificationDeviceTokenFetched"
let KNotificationAppAboutToTerminate        = "KNotificationAppAboutToTerminate"
let ud                                      = UserDefaults.standard
let df                                      = "yyyy-MM-dd'T'HH:mm:ssZ"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupForNotifications()
        showAppRunningStatus()
        return true
    }
    
    func showAppRunningStatus(){
        let notification = UILocalNotification()
        notification.alertTitle = "DEBUG"
        notification.alertBody = "Application is executing code in background"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.fireDate = Date()
        notification.hasAction = false
        UIApplication.shared.presentLocalNotificationNow(notification)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(AppDelegate.showAppRunningStatus), object: nil)
        self.perform(#selector(AppDelegate.showAppRunningStatus), with: nil, afterDelay: 5)
    }

    func setupForNotifications(){
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
                if error == nil {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        func deviceTokenUsingData(_ tokenData:Data)-> String{
            let tokenChars = (tokenData as NSData).bytes.bindMemory(to: CChar.self, capacity: tokenData.count)
            var tokenString = ""
            for i in 0 ..< tokenData.count {
                tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
            }
            return tokenString
        }
        
        ud.set(deviceTokenUsingData(deviceToken), forKey: "deviceToken")
        ud.synchronize()
        
        print("DEVICE TOKEN : \(getDeviceToken())")
        
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: KNotificationDeviceTokenFetched), object: nil)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: KNotificationRemoteNotificationReceived), object: nil)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Swift.Void){
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: KNotificationRemoteNotificationReceived), object: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(25 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            completionHandler(UIBackgroundFetchResult.newData)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: KNotificationAppAboutToTerminate), object: nil)        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: KNotificationAppAboutToTerminate), object: nil)
    }
}

func getDeviceToken()->String{
    if let dt = ud.object(forKey: "deviceToken") as? String {
        return dt
    }
    return ""
}

