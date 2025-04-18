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
            parseTimePeriod(data: data)
        } catch{
            throw TimePeriodError.noTimePeriod
        }
    }
    
    
    private func parseTimePeriod(data: Data){
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(TimePeriodRespons.self, from: data)
            self.periodId = response.periodId
        }
        catch {
            
        }
        
    }
    
    
}
