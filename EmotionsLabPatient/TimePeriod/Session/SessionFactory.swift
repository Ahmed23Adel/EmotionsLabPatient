//
//  Session.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation


class SessionFactory{
    private var sessionId: String = ""
    private var gameTypeName: GameType = .images
    private var status: SessionStatus = .scheduled
    
    static func generateSession(sessionId: UUID, gameTypeName: String, status: SessionStatus) -> any Session{
        if gameTypeName == "images"{
            return ImagesSession(sessionId: sessionId, status: status)
        }
        return ImagesSession(sessionId: sessionId, status: status)
    }
    
    
    
    
}
