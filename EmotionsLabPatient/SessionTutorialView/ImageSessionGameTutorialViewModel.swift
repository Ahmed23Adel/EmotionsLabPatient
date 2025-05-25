//
//  ImageSessionGameTutorialViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 12/05/2025.
//

import Foundation
import SwiftUI

class ImageSessionGameTutorialViewModel: ObservableObject{
    private let gameData = GameData()
    @Published var emotionsImages: [String: [SingleImage]] = [:]
    @Published var emotionNames: [String: [SingleImageName]] = [:]
    @Published var emotionNumbersShown: [String: Int] = [:]
    var selectedImage: SingleImage?
    var selectedName: SingleImageName?
    @Published var currentTutorialStep: tutorialStep
    var onSessionFinished: () -> Void = {}
    @AppStorage("chosenBakcground") var chosenBakcground: String = "brightBackground1"
    enum tutorialStep{
        case initial
        case imageSelection
        case nameSelection
        case completed
    }
    
    init(){
        emotionsImages = gameData.emotionsImages
        emotionNames = gameData.emotionNames
        emotionNumbersShown = gameData.emotionNumbersShown
        currentTutorialStep = .initial
    }
    
    func setFinishingFunc(fn: @escaping () -> Void){
        self.onSessionFinished = fn
    }
    
    func imageSelect(selectedImage: SingleImage) {
        self.selectedImage = selectedImage
        setStateToNameSelect()
    }
    
    func nameSelect(selectedName: SingleImageName){
        self.selectedName = selectedName
        disableAllTutorial()
        currentTutorialStep = .completed
        
        
    }
    
    
    func setStateToImageSelect(){
        disableAllTutorial()
        
        for imgArray in emotionsImages.values {
            for image in imgArray{
                if image.emotionName == "happy"{
                    image.isAbleToSelect = true
                    image.isTutorialShowIndicator = true
                    currentTutorialStep = .imageSelection
                    return
                    
                }
            }
        }
        
    }
    
    func setStateToNameSelect(){
        disableAllTutorial()
        // i will choose one happy for no reasone
        for nameArray in emotionNames.values {
            for name in nameArray{
                if name.emotionName == "happy"{
                    name.isAbleToSelect = true
                    name.isTutorialShowIndicator = true
                    return
                }
            }
        }
        currentTutorialStep = .nameSelection
    }
    
    func disableAllTutorial(){
        gameData.disableTutorialForAllImages()
        gameData.disableTutorialForAllNames()
    }
    
    
}
