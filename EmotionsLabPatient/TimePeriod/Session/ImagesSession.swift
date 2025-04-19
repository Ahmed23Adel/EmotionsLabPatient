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
    var status: SessionStatus
    
    init(sessionId: UUID, status: SessionStatus){
        self.sessionId = sessionId
        self.status = status
        self.id = sessionId
    }
    
}
