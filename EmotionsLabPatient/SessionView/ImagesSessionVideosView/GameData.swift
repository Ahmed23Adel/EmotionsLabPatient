//
//  GameData.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation

struct ImageData: Identifiable {
    var id: String { imageName }  // Ensure unique ID based on imageName
    var imageName: String
    var emotionName: String
    var isSelected: Bool
}

class GameData{
    let emotionNames = ["disgusted", "happy", "feared", "surprised"]
    var emotionsImages: [String: [ImageData]] = [:]
    var emotionNumbersShown: [String: Int] = [:]
    let numImagesPerEmotion = 3
    let maxNumberOfShownImages = 12
    
    init(){
        generateEmotionsImages()
    }
    
    private func generateEmotionsImages(){
        for emotionName in emotionNames {
            let number1 = Int.random(in: 1...10)
            let number2 = Int.random(in: 1...10)
            let number3 = Int.random(in: 1...10)
            emotionsImages[emotionName] = [
                ImageData(imageName: emotionName + String(number1), emotionName: emotionName, isSelected: false),
                ImageData(imageName: emotionName + String(number2), emotionName: emotionName, isSelected: false),
                ImageData(imageName: emotionName + String(number3), emotionName: emotionName, isSelected: false),
            ]
            emotionNumbersShown[emotionName] = numImagesPerEmotion
            
        }
    }
    
    
    
}
