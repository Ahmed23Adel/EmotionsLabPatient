//
//  ImagesSession.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation

class ImagesSession: Session{
    var id: UUID
    var sessionId: UUID
    @Published var status: SessionStatus
    private let apiCaller = ApiCaller()
    
    init(sessionId: UUID, status: SessionStatus){
        self.sessionId = sessionId
        self.status = status
        self.id = sessionId
    }
    
    func setStateFinishedAndUpload() async {
        await MainActor.run {
            self.status = .finished
        }
        do{
            let _ = try await apiCaller.callApiWithToken(
                endpoint: "sessions/finish",
                method: .put,
                token: Patient.shared.authAccess.accessTokenValue,
                body: [
                    "session_id": String(sessionId.uuidString)
                ]
            )
        } catch {
            print("set finished error", error)
        }
    }
}
