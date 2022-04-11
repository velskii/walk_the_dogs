

import SwiftUI
import NotificationBannerSwift

enum NotificationAction: String {
    case dismiss
    case reminder
}

enum NotificationCategory: String {
    case general
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}

struct NotificationView: View {
    var body: some View {
        
        VStack{
            Button("Scehdule a notification"){
                
                
                
                let center = UNUserNotificationCenter.current()
                
                let content = UNMutableNotificationContent()
                
                if let url = Bundle.main.url(forResource: "corgi", withExtension: "jpg") {
                    if let attachment = try? UNNotificationAttachment(identifier: "image", url: url, options: nil) {
                        content.attachments = [attachment]
                    }
                        
                }
                
                content.title = "Time to exercise"
                content.body = "Your schedule says, it's time to walk your dog."
                content.userInfo = ["name": "John Smith" ]
                content.categoryIdentifier = NotificationCategory.general.rawValue
                
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
                
                let request = UNNotificationRequest(identifier: "WALK_DOGS", content: content, trigger: trigger)
                
                let dismiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
                
                let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
                
                let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [], options: [])
                
                center.setNotificationCategories([generalCategory])
                
                center.add(request) { error in
                    if let error = error {
                        print(error)
                    }
                    
                }
                
            }
        }
        
        
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
