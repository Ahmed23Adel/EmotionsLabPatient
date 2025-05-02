//
//  GameResults.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 30/04/2025.
//

import Foundation

class GameResults{
    private var startTime = Date()
    private var endTime = Date()
    private var coins = 0
    private var apiCaller = ApiCaller()
    private var currentPatient = Patient.shared
    
    
    func endGame(session: ImagesSession) async -> String{
        setEndTime()
        calcCoins()
        return await uploadGameResults(session: session)
    }
    
    private func setEndTime(){
        endTime = Date()
    }
    
    private func calcCoins(){
        coins = 100
    }
    
    private func uploadGameResults(session: ImagesSession) async -> String{
        do{
            let formatter = ISO8601DateFormatter()
            let completeDateString = formatter.string(from: endTime)
            let data = try await apiCaller.callApiWithToken(
                endpoint: "game-results",
                method: .post,
                token: currentPatient.authAccess.accessTokenValue,
                body: [
                    "session_id": String(session.sessionId.uuidString),
                    "completed_at": completeDateString,
                    "time_taken": String(getTimeTakenInSeconds())
                ]
            )
            let decoder = JSONDecoder()
            let response = try decoder.decode(GameResultResponse.self, from: data)
            return response.resultId
            
        } catch {
            print(error)
            return ""
        }
        
    }
    
    private func getTimeTakenInSeconds() -> Int{
        Int(endTime.timeIntervalSince(startTime))
    }
}
