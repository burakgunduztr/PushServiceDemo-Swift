# PushServiceDemo-Swift
It's a demo app to test remote APNS features: category, mutable-content, localization for alert title or body.

- **Note: Use these payloads with your desired APNS client.**

## Simple-Alert
```
{"aps":{"alert":{"title":"Test push","body":"This is simple alert push."}}}
```

## Mutable-Content
```
{"aps":{"mutable-content":1,"alert":{"title":"Test m-content","body":"It's a test for mutable content."}}}
```

## Category
```
{"aps":{"category":"MEETING_INVITATION","alert":{"title":"Test category","body":"Tap to see actions about that push."}}}
```

## Mutable-Content & Category
```
{"aps":{"category":"MEETING_INVITATION","mutable-content":1,"alert":{"title":"Test m-content, category","body":"It's a test for mutable content and category."}}}
```

## Alert Localization - Key/Value sets
```
{"aps":{"alert":{"title-loc-key":"groupChatSessionInvitationNotification_title","loc-key":"groupChatSessionInvitationNotification_body","loc-args":["Friends"]}}}
```

**Localizable.strings file on Xcode project** <br/>
```
"groupChatSessionInvitationNotification_title" = "You're invited to join a group";
"groupChatSessionInvitationNotification_body" = "Group name is: %@";
```

- **Note: See sample clients below that you can send payloads.**

## Send payloads by JWT [APNs Provider:(sideshow/apns2)](https://github.com/sideshow/apns2)

- **Learn how to create token from [Apple](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)**

```
package main

import (
  "fmt"
  "log"

  "github.com/sideshow/apns2"
  "github.com/sideshow/apns2/token"
)

func main() {

  authKey, err := token.AuthKeyFromFile("________.p8")
  if err != nil {
    log.Fatal("token error:", err)
  }

  token := &token.Token{
    AuthKey: authKey,
    // KeyID from developer account (Certificates, Identifiers & Profiles -> Keys)
    KeyID:   "________",
    // TeamID from developer account (View Account -> Membership)
    TeamID:  "________",
  }

  notification := &apns2.Notification{}
  notification.DeviceToken = "________"
  notification.Topic = "________"
  notification.Payload = []byte(`{"aps":{"category":"MEETING_INVITATION","alert":{"title":"Test category","body":"Tap to see actions about that push."}}}`)

  client := apns2.NewTokenClient(token)
  res, err := client.Push(notification)

  if err != nil {
    log.Println("There was an error", err)
    return
  }

  if res.Sent() {
    log.Println("Sent:", res.ApnsID)
  } else {
    fmt.Printf("Not Sent: %v %v %v\n", res.StatusCode, res.ApnsID, res.Reason)
  } 
}
```
- **Note: You can do it with certificate too. You can check details from [(sideshow/apns2)](https://github.com/sideshow/apns2)**

## How to enable mutable-content on iOS app:

**Create Notification Service Extension:**<br/>
Xcode > File > New > Target > Notification Service Extension

## How to get deviceToken on iOS app:

**Register remote notification and device-token handler in AppDelegate: didFinishLaunchingWithOptions**
```
let center = UNUserNotificationCenter.current()
center.delegate = self
        
center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {
   (granted, error) in
   if granted {
      DispatchQueue.main.async {
         UIApplication.shared.registerForRemoteNotifications()
      }
   }
})
```

**Add UNUserNotificationCenterDelegate to AppDelegate class, then add this method**
```
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
   let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
   print("Handled deviceToken: \(token)")
}
```

**Use device token and mutable-content payload to test it.**
