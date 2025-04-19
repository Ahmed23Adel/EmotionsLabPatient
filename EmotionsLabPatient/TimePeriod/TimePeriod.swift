//
//  TimePeriod.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 18/04/2025.
//

import Foundation


class TimePeriod{
    private(set) var periodId = ""
    private let apiCaller = ApiCaller()
    
    func loadActiveTimePeriod() async throws{
        
        do {
           let data = try await apiCaller.callApiWithToken(
                endpoint: "my/active-time-period",
                method: .get,
                token: Patient.shared.authAccess.accessTokenValue)
            print("s1")
            parseTimePeriod(data: data)
            
        } catch{
            throw TimePeriodError.noTimePeriod
        }
    }
    
    private func parseTimePeriod(data: Data) {
        let decoder = JSONDecoder()
        
        // Create a custom date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // For the created_at field which includes fractional seconds
        let createdAtFormatter = DateFormatter()
        createdAtFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        createdAtFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        createdAtFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Custom date decoding strategy
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            // Try the regular date format first
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
            
            // If that fails, try the format with fractional seconds
            if let date = createdAtFormatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)"
            )
        }
        
        do {
            let response = try decoder.decode(TimePeriodRespons.self, from: data)
            self.periodId = response.periodId
        } catch {
            print("Decoding error:", error)
        }
    }

    
    
}
