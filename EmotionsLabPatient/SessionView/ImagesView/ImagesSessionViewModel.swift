//
//  ImagesViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation
class ImagesSessionViewModel: ObservableObject{
    private(set) var session: ImagesSession = ImagesSession(sessionId: UUID(), status: .scheduled)
    
    func setSession(session: ImagesSession){
        self.session = session
    }
}
