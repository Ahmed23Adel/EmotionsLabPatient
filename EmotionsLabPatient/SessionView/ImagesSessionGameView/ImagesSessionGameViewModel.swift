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
    @Published var emotionsImages: [String: [SingleImage]] = [:]
    @Published var emotionNames: [String: [SingleImageName]] = [:]
    @Published var emotionNumbersShown: [String: Int] = [:]
    var selectedImage: SingleImage?
    var selectedName: SingleImageName?
    
    init(){
        emotionsImages = gameData.emotionsImages
        emotionNames = gameData.emotionNames
        emotionNumbersShown = gameData.emotionNumbersShown
        
    }
    func setCurrentSession(_ session: ImagesSession) {
        self.currentSession = session
    }
    
    func imageSelect(selectedImage: SingleImage, newValue: Bool) {
        self.selectedImage = selectedImage
        trySelectImgAndName(selectedName: selectedName, selectedImage: self.selectedImage)
    }
    
    func nameSelect(selectedName: SingleImageName){
        self.selectedName = selectedName
        trySelectImgAndName(selectedName: self.selectedName, selectedImage: self.selectedImage)
    }
    
    func trySelectImgAndName(selectedName: SingleImageName?, selectedImage: SingleImage?){
        if let selectedName = selectedName, let selectedImage = selectedImage{
            if validateSelection(img: selectedImage, name: selectedName){
                // user selected both image and name but they are correct
                resetSelectionOnCorrectMatch(
                    selectedName: selectedName,
                    selectedImage: selectedImage)
            } else {
                // user selected both image and name but they are incorrect
                showSelectError(selectedName: selectedName, selectedImage: selectedImage)
            }
        } else {
            storeSelectedImageOrName(selectedName: selectedName, selectedImage: selectedImage)
        }
    }
    
    func resetSelectionOnCorrectMatch(selectedName: SingleImageName, selectedImage: SingleImage){
        hideImgAndName(selectedName: selectedName, selectedImage: selectedImage)
        gameData.enableSelectionForAllNames()
        gameData.enableSelectionForAllImages()
        self.selectedImage = nil
        self.selectedName = nil
    }
    func storeSelectedImageOrName(selectedName: SingleImageName?, selectedImage: SingleImage?){
        if let selectedName = selectedImage {
            selectedName.isSelected = true
            gameData.enableSelectionForAllNames()
            gameData.disableSelectionForAllImages()
        }
        if let selectedImage = selectedImage {
            selectedImage.isSelected = true
            gameData.enableSelectionForAllNames()
            gameData.disableSelectionForAllImages()
        }
        
        
    }
    
    func hideImgAndName(selectedName: SingleImageName, selectedImage: SingleImage){
        selectedName.isHide = true
        selectedImage.isHide = true
    }
    func validateSelection(img: SingleImage, name: SingleImageName) -> Bool{
        img.emotionName == name.emotionName
    }
    
    
    func showSelectError(selectedName: SingleImageName, selectedImage: SingleImage){
        vibrateViews(selectedName: selectedName, selectedImage: selectedImage)
        resetSelection(selectedName: selectedName, selectedImage: selectedImage)
    }
    
    func vibrateViews(selectedName: SingleImageName, selectedImage: SingleImage){
        selectedName.isShowError = true
        selectedImage.isShowError = true
    }
    
    
    func resetSelection(selectedName: SingleImageName, selectedImage: SingleImage){
        unselectViews(selectedName: selectedName, selectedImage: selectedImage)
        gameData.enableSelectionForAllNames()
        gameData.enableSelectionForAllImages()
        self.selectedImage = nil
        self.selectedName = nil
        
    }
    
    func unselectViews(selectedName: SingleImageName, selectedImage: SingleImage){
        selectedName.isSelected = false
        selectedImage.isSelected = false
    }
    
}
