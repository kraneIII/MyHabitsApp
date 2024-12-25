
import NotificationCenter
import Foundation

class NotificationService {
    
    init() {
        
    }
    
    func AskForNotificationPermission() {
        Task {
            try await
            UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound])
        }
    }
    
    func checkNotificationPermission() async -> Bool {
        await 
            UNUserNotificationCenter.current().notificationSettings()
            .authorizationStatus == .authorized
    }
    
    func addNotification(date: Date, context: UNMutableNotificationContent, id: Int) {
        
        if date < Date.now { return }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let notificationId = "\(id)"

        
        let request = UNNotificationRequest(identifier: notificationId, content: context , trigger: trigger )
        
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func deleteAllNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

    }
    
    func removeNotification(indetifier: Int) {
        let notificationId = "\(indetifier)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
    }

    
}
