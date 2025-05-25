//
//  EmotionsLabPatientApp.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 10/04/2025.
//

import SwiftUI
import BackgroundTasks
import UserNotifications

@main
struct EmotionsLabPatientApp: App {
    @StateObject private var backgroundTaskManager = BackgroundTaskManager.shared
        
    init(){
        AppResetDetector.clearKeychainIfFirstLaunch()
        debugBackgroundTaskSetup()
        setupBackgroundTasks()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupBackgroundTasks() {
       // 1. Request notification permission first
       backgroundTaskManager.requestNotificationPermission()
       
       // 2. Register the background task handler (this just sets up the handler)
       backgroundTaskManager.registerBackgroundTasks()
       
       // 3. Schedule the first background task (this actually schedules it for 4 PM)
       backgroundTaskManager.scheduleBackgroundTask()
       
       print("Background tasks setup completed - next check scheduled for 4 PM")
   }
    
    func debugBackgroundTaskSetup() {
        print("Bundle ID: \(Bundle.main.bundleIdentifier ?? "Unknown")")
        let backgroundTaskIdentifier = "com.EmotionsLabPatient.dailycheck"
        
        print("Task ID: \(backgroundTaskIdentifier)")
        
        // Check if background app refresh is enabled
        print("Background App Refresh Status: \(UIApplication.shared.backgroundRefreshStatus.rawValue)")
        
        // Try to get pending tasks
        BGTaskScheduler.shared.getPendingTaskRequests { requests in
            print("Pending background tasks: \(requests.count)")
            for request in requests {
                print("- \(request.identifier)")
            }
        }
    }
}
