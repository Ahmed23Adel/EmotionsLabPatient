//
//  EmotionsLabPatientApp.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 10/04/2025.
//

import SwiftUI

@main
struct EmotionsLabPatientApp: App {
    
    init(){
        AppResetDetector.clearKeychainIfFirstLaunch()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
