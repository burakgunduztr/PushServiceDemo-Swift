//
//  ViewController.swift
//  StandartPushTestAppSwift
//
//  Created by Burak Gunduz on 5.12.2019.
//  Copyright © 2019 StandartPushTestAppSwift. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("notifications are fetched:")
        
        let center = UNUserNotificationCenter.current()
        center.getDeliveredNotifications { (notifications: [UNNotification]) in
            print(notifications.description)
        }
    }
}

