//
//  GameResultResponse.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 02/05/2025.
//

import Foundation

struct GameResultResponse: Decodable {
    var resultId: String
    var sessionId: String
    var completedAt: String
    var timeTaken: Int

    enum CodingKeys: String, CodingKey {
        case resultId = "result_id"
        case sessionId = "session_id"
        case completedAt = "completed_at"
        case timeTaken = "time_taken"
    }
}
