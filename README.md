# pushDemoApp-Swift
It's a demo app to test remote APNS features: category, mutable-content, localization for alert title or body.

** Send below payloads with your desired APNS client. **

## Mutable-Content
{"aps":{"mutable-content":1,"alert":{"title":"React with push actions","body":"Tap to see actions about that push."}}}

## Category
{"aps":{"category":"MEETING_INVITATION","alert":{"title":"React with push actions","body":"Tap to see actions about that push."}}}

## Mutable-Content & Category
{"aps":{"category":"MEETING_INVITATION","mutable-content":1,"alert":{"title":"React with push actions","body":"Tap to see actions about that push."}}}

## Alert Localization
{"aps":{"alert":{"title-loc-key":"groupChatSessionInvitationNotification_title","loc-key":"groupChatSessionInvitationNotification_body","loc-args":["Friends"]}}}
