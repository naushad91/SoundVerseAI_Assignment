//
//  NotificationManager.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import Foundation
import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() {}
    
    // MARK: - Request Permission
    func requestPermission() {
        
        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { granted, error in
                
                if let error {
                    print("Notification permission error:", error)
                }
                
                print("Permission granted:", granted)
            }
    }
    
    // MARK: - Schedule Notification
    func scheduleNotification(for item: ActivityItem) {
        let content = UNMutableNotificationContent()
        content.title = item.user
        content.body = item.message
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error { print("Notification error:", error) }
        }
    }
}
