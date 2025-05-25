//
//  TodaySessionCountNotificationModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 25/05/2025.
//

import Foundation
struct TodaySessionCountNotificationModel: Codable{
    
    let hasSessions: Bool
    let sessionCount: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case hasSessions = "has_sessions"
        case sessionCount = "session_count"
        case date
    }
}
