//
//  File.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 25/05/2025.
//

import Foundation
import BackgroundTasks
import UserNotifications


class BackgroundTaskManager: ObservableObject {
    static let shared = BackgroundTaskManager()
    
    // Background task identifier - must match what's registered in target's Info tab
    // Replace "com.yourapp" with your actual bundle identifier
    private let backgroundTaskIdentifier = "com.EmotionsLabPatient.dailycheck"
    
    private init() {}
    
    // Register background tasks when app launches
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: nil) { task in
            self.handleBackgroundCheck(task: task as! BGAppRefreshTask)
        }
    }
    
    // Schedule the next background task
    func scheduleBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        
        // Schedule for 4 PM today, or tomorrow if it's already past 4 PM
        let calendar = Calendar.current
        let now = Date()
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        dateComponents.hour = 16 // 4 PM in 24-hour format
        dateComponents.minute = 0
        dateComponents.second = 0
        
        guard let scheduledDate = calendar.date(from: dateComponents) else { return }
        
        // If 4 PM today has passed, schedule for tomorrow
        let targetDate = scheduledDate < now ?
            calendar.date(byAdding: .day, value: 1, to: scheduledDate)! :
            scheduledDate
        
        request.earliestBeginDate = targetDate
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Background task scheduled for: \(targetDate)")
        } catch {
            print("Could not schedule background task: \(error)")
        }
    }
    
    // Handle the background task execution
    private func handleBackgroundCheck(task: BGAppRefreshTask) {
        // Schedule the next occurrence immediately
        scheduleBackgroundTask()
        
        // Set expiration handler
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        // Perform the API check
        performAPICheck { [weak self] success in
            task.setTaskCompleted(success: success)
        }
    }
    
    // Perform the actual API call and check
    private func performAPICheck(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let apiCaller = ApiCaller()
                let data = try await apiCaller.callApiWithToken(
                    endpoint: "sessions-notifications/today",
                    method: .get,
                    token: Patient.shared.authAccess.accessTokenValue
                )
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(TodaySessionCountNotificationModel.self, from: data)
                
                if response.hasSessions {
                    // Send notification on main thread since it involves UI-related operations
                    await MainActor.run {
                        self.sendSessionNotification()
                    }
                    completion(true)
                } else {
                    completion(true) // API call succeeded, just no sessions
                }
            } catch {
                print("API call failed: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    // Send local notification
    func sendSessionNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Session Reminder"
        content.body = "You have a session scheduled for today!"
        content.sound = .default
        
        // Create a trigger to show immediately
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // Create the request
        let request = UNNotificationRequest(
            identifier: "session-reminder-\(Date().timeIntervalSince1970)",
            content: content,
            trigger: trigger
        )
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Session notification scheduled successfully")
            }
        }
    }
}

// MARK: - Notification Permission Helper
extension BackgroundTaskManager {
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }
            }
        }
    }
}
