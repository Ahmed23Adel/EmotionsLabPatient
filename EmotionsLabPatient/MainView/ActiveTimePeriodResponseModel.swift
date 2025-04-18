//
//  ActiveTimePeriod.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 18/04/2025.
//

import Foundation

struct TimePeriodRespons: Codable {
    let name: String
    let startDate: Date
    let endDate: Date
    let periodId: String
    let patientId: String
    let therapistId: String
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case name
        case startDate = "start_date"
        case endDate = "end_date"
        case periodId = "period_id"
        case patientId = "patient_id"
        case therapistId = "therapist_id"
        case createdAt = "created_at"
    }
}
