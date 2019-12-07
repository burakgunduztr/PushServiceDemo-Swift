//
//  AppDelegate.swift
//  StandartPushTestAppSwift
//
//  Created by Burak Gunduz on 5.12.2019.
//  Copyright © 2019 StandartPushTestAppSwift. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (status: Bool, error: Error?) in
            if error == nil {
                self.registerCategory()
                // It's just for testing action buttons
                // self.scheduleNotification(event: "test", interval: 3)
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                print("Push registration success.")
            }
            else {
                print("Push registration failed:")
                print(error!.localizedDescription)
            }
        }
        
        return true
    }
    
    func registerCategory() -> Void {
        
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                                                title: "Accept",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                 title: "Decline",
                                                 options: UNNotificationActionOptions(rawValue: 0))
        
        let category : UNNotificationCategory = UNNotificationCategory.init(identifier: "MEETING_INVITATION", actions: [acceptAction, declineAction], intentIdentifiers: [], options: [])
        
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Handled deviceToken: ")
        print(token)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Perform the task associated with the action.
        switch response.actionIdentifier {
        case "ACCEPT_ACTION":
            break
        case "DECLINE_ACTION":
            break
        default:
            break
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    // It's just for testing action buttons
    func scheduleNotification (event : String, interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        
        content.title = event
        content.body = "body"
        content.categoryIdentifier = "MEETING_INVITATION"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: interval, repeats: false)
        let identifier = "id_" + event
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: { (error) in
        })
    }
}

