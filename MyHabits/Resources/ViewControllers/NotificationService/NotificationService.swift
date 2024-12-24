//
//  NotificationService.swift
//  MyHabits
//
//  Created by Ковалев Никита on 16.12.2024.
//
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
    
    func addNotification(date: Date, context: UNMutableNotificationContent) {
        
        if date < Date.now { return }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: context , trigger: trigger )
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func deleteNotification() {
        
    }
    
}
