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
                hideImgAndName(selectedName: selectedName, selectedImage: selectedImage)
            } else {
                // user selected both image and name but they are incorrect
                showSelectError(selectedName: selectedName, selectedImage: selectedImage)
            }
        } else if let _ = selectedImage{
            // user selected only image
            gameData.enableSelectionForAllNames()
            gameData.disableSelectionForAllImages()
        } else if let _ = selectedName {
            // user selected only name
            gameData.enableSelectionForAllImages()
            gameData.disableSelectionForAllNames()
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
        selectedName.isSelected = false
        selectedImage.isSelected = false
    }
    
    
}
