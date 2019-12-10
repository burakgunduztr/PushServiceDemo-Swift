# pushDemoApp-Swift
It's a demo app to test remote APNS features: category, mutable-content, localization for alert title or body.

- **Note: Use these payloads with your desired APNS client.**

## Mutable-Content
{"aps":{"mutable-content":1,"alert":{"title":"React with push actions","body":"Tap to see actions about that push."}}}

## Category
{"aps":{"category":"MEETING_INVITATION","alert":{"title":"React with push actions","body":"Tap to see actions about that push."}}}

## Mutable-Content & Category
{"aps":{"category":"MEETING_INVITATION","mutable-content":1,"alert":{"title":"React with push actions","body":"Tap to see actions about that push."}}}

## Alert Localization
{"aps":{"alert":{"title-loc-key":"groupChatSessionInvitationNotification_title","loc-key":"groupChatSessionInvitationNotification_body","loc-args":["Friends"]}}}

- **Note: See sample clients below that you can send payloads.**

## Send payloads by JWT [APNs Provider:(sideshow/apns2)](https://github.com/sideshow/apns2)

- **Learn how to create token from [Apple](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)**

```package main

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
  notification.Payload = []byte(`{"aps":{"mutable-content":1,"alert":{"title":"React with push actions","body":"Tap to see actions about that push."}}}`)

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
