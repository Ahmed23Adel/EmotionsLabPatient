//
//  GameData.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation


class GameData{
    let basicEmotionNames = ["disgusted", "happy", "feared", "surprised"]
    var emotionsImages: [String: [SingleImage]] = [:]
    var emotionNames: [String: [SingleImageName]] = [:]
    var emotionNumbersShown: [String: Int] = [:]
    let numImagesPerEmotion = 3
    let maxNumberOfShownImages = 12
    
    init(){
        generateEmotionsImages()
    }
    
    private func generateEmotionsImages() {
        for emotionName in basicEmotionNames {
            let uniqueNumbers = Array(1...10).shuffled().prefix(numImagesPerEmotion)
            
            emotionsImages[emotionName] = uniqueNumbers.map { number in
                SingleImage(imageName: emotionName + String(number), emotionName: emotionName)
            }
            
            emotionNames[emotionName] = [
                SingleImageName(emotionName: emotionName),
                SingleImageName(emotionName: emotionName),
                SingleImageName(emotionName: emotionName)
            ]
            
            emotionNumbersShown[emotionName] = numImagesPerEmotion
        }
    }
    
    
    func disableSelectionFromOtherImagesExcept(_ image: SingleImage){
        for tmpImgsInEmotion in emotionsImages.values{
            for tmpImg in tmpImgsInEmotion{
                if tmpImg != image {
                    tmpImg.isAbleToSelect = false
                }
            }
            
        }
    }
    
    func disableSelectionForAllImages(){
        for tmpImgsInEmotion in emotionsImages.values{
            for tmpImg in tmpImgsInEmotion{
                tmpImg.isAbleToSelect = false
            }
            
        }
    }
    
    func disableTutorialForAllImages(){
        for tmpImgsInEmotion in emotionsImages.values{
            for tmpImg in tmpImgsInEmotion{
                tmpImg.isAbleToSelect = false
                tmpImg.isTutorialShowIndicator = false
            }
            
        }
    }
    
    func enableSelectionForAllImages(){
        for tmpImgsInEmotion in emotionsImages.values{
            for tmpImg in tmpImgsInEmotion{
                tmpImg.isAbleToSelect = true
            }
            
        }
    }
    
    func enableSelectionForAllNames(){
        for tmpNameInEmotion in emotionNames.values{
            for tmpName in tmpNameInEmotion{
                tmpName.isAbleToSelect = true
            }
            
        }
    }
    
    func disableSelectionForAllNames(){
        for tmpNameInEmotion in emotionNames.values{
            for tmpName in tmpNameInEmotion{
                tmpName.isAbleToSelect = false
            }
            
        }
    }
    
    func disableTutorialForAllNames(){
        for tmpNameInEmotion in emotionNames.values{
            for tmpName in tmpNameInEmotion{
                tmpName.isAbleToSelect = false
                tmpName.isTutorialShowIndicator = false
            }
            
        }
    }
    
    
    
}
