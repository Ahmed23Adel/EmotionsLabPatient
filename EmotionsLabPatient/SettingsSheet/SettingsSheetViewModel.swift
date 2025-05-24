//
//  SettingsSheetViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/05/2025.
//

import Foundation
import SwiftUI

class SettingsSheetViewModel: ObservableObject{
    var noBackgroundName = "noBackground"
    var allBackgrounds: [String] = ["noBackground","brightBackground1", "brightBackground2", "brightBackground3", "brightBackground4", "brightBackground5"]
    @AppStorage("chosenBakcground") var chosenBakcground = "brightBackground1"
    @Published var isNavigateToSignUp = false
    
    func logout(){
        AppResetDetector.resetHasLuanchedBefore()
        Patient.shared.logout()
        isNavigateToSignUp = true
    }
    
}
