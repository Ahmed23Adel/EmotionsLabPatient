//
//  ActiveSessionsResponseModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation

struct SessionsTodayResponse: Codable {
    let sessionCount: Int?
    let sessions: [SessionDetail]

    enum CodingKeys: String, CodingKey {
        case sessionCount = "session_count"
        case sessions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sessionCount = try container.decodeIfPresent(Int.self, forKey: .sessionCount) ?? 0
        sessions = try container.decode([SessionDetail].self, forKey: .sessions)
    }
}

// MARK: - Session Detail
struct SessionDetail: Codable, Identifiable {
    var id: UUID { sessionID } // For SwiftUI lists
    let sessionID: UUID
    let periodID: UUID
    let patientID: UUID
    let gameTypeID: UUID
    let gameTypeName: String
    let sessionDateString: String
    let coinsReward: Int
    let status: String
    let createdAtString: String
    let emotions: [Emotion]
    
    // Computed properties to convert string dates to Date objects when needed
    var sessionDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: sessionDateString)
    }
    
    var createdAt: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return formatter.date(from: createdAtString)
    }

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
        case periodID = "period_id"
        case patientID = "patient_id"
        case gameTypeID = "game_type_id"
        case gameTypeName = "game_type_name"
        case sessionDateString = "session_date"
        case coinsReward = "coins_reward"
        case status
        case createdAtString = "created_at"
        case emotions
    }
}

// MARK: - Emotion
struct Emotion: Codable, Identifiable {
    var id: UUID { emotionID } // For SwiftUI lists
    let emotionID: UUID
    let name: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case emotionID = "emotion_id"
        case name
        case description
    }
}
