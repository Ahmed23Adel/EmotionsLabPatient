//
//  ErrorDetailsContainer.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 30/04/2025.
//

import Foundation

class ErrorDetailsContainer{
    var emotionsErrors: [String: Int] = [:]
    private var apiCaller = ApiCaller()
    private var currentPatient = Patient.shared
    
    
    init(emotionsNames: [String]){
        for name in emotionsNames{
            emotionsErrors[name] = 0
        }
    }
    
    
    func incrementErrorForImage(image: SingleImage){
        emotionsErrors[image.emotionName]! += 1
    }
    
    func uploadResultsErrors(resultId: String) async {
        for emotionName in emotionsErrors.keys{
            let errorCount: Int = emotionsErrors[emotionName]!
            await uploadSingleResultEmotionError(resultId: resultId, emotionName: emotionName, errorCount: errorCount)
        }
    }
    
    private func uploadSingleResultEmotionError(resultId: String, emotionName: String, errorCount: Int) async{
        do{
            let _ = try await apiCaller.callApiWithToken(
                endpoint: "game-results-emotions",
                method: .post,
                token: currentPatient.authAccess.accessTokenValue,
                body: [
                    "result_id": resultId,
                    "emotion_name": emotionName,
                    "error_count": String(errorCount)
                ]
            )
        } catch {
        }
    }
    
}
