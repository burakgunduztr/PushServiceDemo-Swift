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
        
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                                                title: "Accept",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                 title: "Decline",
                                                 options: UNNotificationActionOptions(rawValue: 0))
        // Define the notification type
        let meetingInviteCategory =
            UNNotificationCategory(identifier: "MEETING_INVITATION",
                                   actions: [acceptAction, declineAction],
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .customDismissAction)
 
        center.setNotificationCategories([meetingInviteCategory])
        
        center.requestAuthorization(options: [.alert, .sound]) { (status: Bool, error: Error?) in
            if error == nil {
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Handled deviceToken: ")
        print(token)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Get the meeting ID from the original notification.
        let userInfo = response.notification.request.content.userInfo
        
        // Perform the task associated with the action.
        switch response.actionIdentifier {
        case "ACCEPT_ACTION":
            
            break
            
        case "DECLINE_ACTION":
            
            break
            
            // Handle other actions…
            
        default:
            break
        }
        
        // Always call the completion handler when done.
        completionHandler()
    }
    
//    // Modify the payload contents.
//    func didReceive(_ request: UNNotificationRequest,
//                             withContentHandler contentHandler:
//        @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        self.bestAttemptContent = (request.content.mutableCopy()
//            as? UNMutableNotificationContent)
//
//        // Try to decode the encrypted message data.
//        let encryptedData = bestAttemptContent?.userInfo["ENCRYPTED_DATA"]
//        if let bestAttemptContent = bestAttemptContent {
//            if let data = encryptedData as? String {
//                let decryptedMessage = self.decrypt(data: data)
//                bestAttemptContent.body = decryptedMessage
//            }
//            else {
//                bestAttemptContent.body = "(Encrypted)"
//            }
//
//            // Always call the completion handler when done.
//            contentHandler(bestAttemptContent)
//        }
//    }
//
//    // Return something before time expires.
//    func serviceExtensionTimeWillExpire() {
//        if let contentHandler = contentHandler,
//            let bestAttemptContent = bestAttemptContent {
//
//            // Mark the message as still encrypted.
//            bestAttemptContent.subtitle = "(Encrypted)"
//            bestAttemptContent.body = ""
//            contentHandler(bestAttemptContent)
//        }
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

