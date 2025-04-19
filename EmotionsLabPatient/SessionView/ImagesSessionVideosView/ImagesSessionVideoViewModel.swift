//
//  ImagesViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation
class ImagesSessionVideoViewModel: ObservableObject{
    private(set) var session: ImagesSession = ImagesSession(sessionId: UUID(), status: .scheduled)
    let preGameVideo = PreGameVideos()
    @Published var navigateToNext = false
    
    func setSession(session: ImagesSession){
        self.session = session
    }
}
