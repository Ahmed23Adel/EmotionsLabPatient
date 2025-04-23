//
//  ImagesSessionGameViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation

class ImagesSessionGameViewModel: ObservableObject{
    @Published var currentSession = ImagesSession (sessionId: UUID(), status: .scheduled)
    private let gameData = GameData()
    @Published var emotionsImages: [String: [ImageData]] = [:]
    @Published var emotionNumbersShown: [String: Int] = [:]
    
    init(){
        emotionsImages = gameData.emotionsImages
        emotionNumbersShown = gameData.emotionNumbersShown
    }
    func setCurrentSession(_ session: ImagesSession) {
        self.currentSession = session
    }
}
