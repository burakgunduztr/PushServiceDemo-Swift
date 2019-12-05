//
//  NotificationService.swift
//  StandartPushTestAppSwiftNotificationExtension
//
//  Created by Burak Gunduz on 5.12.2019.
//  Copyright © 2019 StandartPushTestAppSwift. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    // Storage for the completion handler and content.
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    // Modify the payload contents.
    
    override func didReceive(_ request: UNNotificationRequest,
                             withContentHandler contentHandler:
        @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        self.bestAttemptContent = (request.content.mutableCopy()
            as? UNMutableNotificationContent)
        
//        if let bestAttemptContent = bestAttemptContent {
//            contentHandler(bestAttemptContent)
//
//            bestAttemptContent.title = "Weekly Staff Meeting"
//            bestAttemptContent.body = "Every Tuesday at 2pm"
//            bestAttemptContent.userInfo = ["MEETING_ID" : "32323",
//                                           "USER_ID" : "K324KJ124S1J23N"]
//            bestAttemptContent.categoryIdentifier = "MEETING_INVITATION"
//
//            contentHandler(bestAttemptContent)
//        }
        
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "Title new set"
            bestAttemptContent.body = "Payload content updated on app level"

            contentHandler(bestAttemptContent)
        }
        
//        if let aps = bestAttemptContent?.userInfo["aps"] as? NSDictionary, let bestAttemptContent = bestAttemptContent {
//            if let alert = aps["alert"] as? NSDictionary {
//                if let _ = alert["body"] as? NSString {
//                    bestAttemptContent.title = "Title new set"
//                    bestAttemptContent.body = "Payload content updated on app level"
//                }
//            }
//
//            contentHandler(bestAttemptContent)
//        }
        
//        // Try to decode the encrypted message data.
//        let encryptedData = bestAttemptContent?.userInfo["ENCRYPTED_DATA"]
//        if let bestAttemptContent = bestAttemptContent {
//            if let _ = encryptedData as? String {
//                bestAttemptContent.body = "Payload content updated on app level"
//            }
//            else {
//                bestAttemptContent.body = "(Encrypted)"
//            }
//
//            // Always call the completion handler when done.
//            contentHandler(bestAttemptContent)
//        }
    }
    
    // Return something before time expires.
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler,
            let bestAttemptContent = bestAttemptContent {
            
            // Mark the message as still encrypted.
            bestAttemptContent.subtitle = "(Encrypted)"
            bestAttemptContent.body = ""
            contentHandler(bestAttemptContent)
        }
    }

}
