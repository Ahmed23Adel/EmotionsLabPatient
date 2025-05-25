//
//  ImagesSessionGameViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//
import Foundation
import AVFoundation
import SwiftUI

enum ExitReason: String, CaseIterable, Identifiable {
    case tired = "I'm tired"
    case tooHard = "This is too hard"
    case other = "Other reason"
    
    var id: String { self.rawValue }
}

class ImagesSessionGameViewModel: ObservableObject{
    @Published var currentSession = ImagesSession (sessionId: UUID(), status: .scheduled)
    private let gameData = GameData()
    @Published var emotionsImages: [String: [SingleImage]] = [:]
    @Published var emotionNames: [String: [SingleImageName]] = [:]
    @Published var emotionNumbersShown: [String: Int] = [:]
    var selectedImage: SingleImage?
    var selectedName: SingleImageName?
    let errorDetailContainer:ErrorDetailsContainer
    let gameResults = GameResults()
    
    @Published var isUploadingResults = false
    @Published var isShowCoins = false
    @Published var isGameFinished = false
    @Published var isPaused = false  // Add pause state to view model
    var onSessionFinished: () -> Void = {}
    private var audioPlayer: AVAudioPlayer?
    

    @Published var showFeedbackMessage = false
    @Published var feedbackMessage = ""
    let encouragementMessages = [
        "Hmm, try again!",
        "Let’s take another look!",
        "Almost there!",
        "Keep going, you got this!",
        "Nice try, let’s try again!",
        "Great effort!",
        "Don't give up!",
        "One more try!"
    ]

    @AppStorage("chosenBakcground") var chosenBakcground: String = "brightBackground1"
    
    init(){
        emotionsImages = gameData.emotionsImages
        emotionNames = gameData.emotionNames
        emotionNumbersShown = gameData.emotionNumbersShown
        errorDetailContainer = ErrorDetailsContainer(emotionsNames: gameData.basicEmotionNames)
    }
    
    func setCurrentSession(_ session: ImagesSession) {
        self.currentSession = session
    }
    
    func pauseGame() {
        isPaused = true
    }
    
    func resumeGame() {
        isPaused = false
    }
    
    func togglePause() {
        isPaused.toggle()
    }
    
    func imageSelect(selectedImage: SingleImage, newValue: Bool) {
        // Don't allow selection when paused
        guard !isPaused else { return }
        
        self.selectedImage = selectedImage
        trySelectImgAndName(selectedName: selectedName, selectedImage: self.selectedImage)
    }
    
    func nameSelect(selectedName: SingleImageName){
        // Don't allow selection when paused
        guard !isPaused else { return }
        
        self.selectedName = selectedName
        trySelectImgAndName(selectedName: self.selectedName, selectedImage: self.selectedImage)
    }
    
    func trySelectImgAndName(selectedName: SingleImageName?, selectedImage: SingleImage?){
        if let selectedName = selectedName, let selectedImage = selectedImage{
            if validateSelection(img: selectedImage, name: selectedName){
                // user selected both image and name but they are correct
                saveResultOnCorrect(selectedName: selectedName,
                                    selectedImage: selectedImage)
                resetSelectionOnCorrectMatch(
                    selectedName: selectedName,
                    selectedImage: selectedImage)
            } else {
                // user selected both image and name but they are incorrect
                errorDetailContainer.incrementErrorForImage(image: selectedImage)
                showSelectError(selectedName: selectedName, selectedImage: selectedImage)
            }
        } else {
            storeSelectedImageOrName(selectedName: selectedName, selectedImage: selectedImage)
        }
        
        checkIfGameOverAndClose()
    }
    
    func resetSelectionOnCorrectMatch(selectedName: SingleImageName, selectedImage: SingleImage){
        hideImgAndName(selectedName: selectedName, selectedImage: selectedImage)
        gameData.enableSelectionForAllNames()
        gameData.enableSelectionForAllImages()
        self.selectedImage = nil
        self.selectedName = nil
    }
    
    func storeSelectedImageOrName(selectedName: SingleImageName?, selectedImage: SingleImage?){
        if let selectedName = selectedName {
            selectedName.isSelected = true
            gameData.enableSelectionForAllImages()
            gameData.disableSelectionForAllNames()
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
        showRandomFeedbackMessage()
    }
    
    func showRandomFeedbackMessage() {
        feedbackMessage = encouragementMessages.randomElement() ?? "Try again!"
        withAnimation(.easeInOut(duration: 0.7)) {
            showFeedbackMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: 0.7)) {
                self.showFeedbackMessage = false
            }
        }
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
    
    func saveResultOnCorrect(selectedName: SingleImageName, selectedImage: SingleImage){
        let emotionSelected = selectedName.emotionName
        emotionNumbersShown[emotionSelected]! -= 1
    }
    
    func checkIfGameOverAndClose(){
        if isGameOver(){
            Task{
                setStateUploadingResults()
                let resultId = await gameResults.endGame(session: currentSession)
                await errorDetailContainer.uploadResultsErrors(resultId: resultId)
                await currentSession.setStateFinishedAndUpload()
                onSessionFinished()
                setStateShowCoins()
                playCoinsDroppingSound()
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                setStateGameFinished()
            }
        }
    }
    
    func isGameOver() -> Bool{
        emotionNumbersShown.allSatisfy { $0.value == 0 }
    }
    
    private func setStateUploadingResults(){
        DispatchQueue.main.async{
            self.isUploadingResults = true
            self.isShowCoins = false
            self.isGameFinished = false
        }
    }
    
    private func setStateShowCoins(){
        DispatchQueue.main.async{
            self.isUploadingResults = false
            self.isShowCoins = true
            self.isGameFinished = false
        }
    }
    
    private func setStateGameFinished(){
        DispatchQueue.main.async{
            self.isUploadingResults = false
            self.isShowCoins = false
            self.isGameFinished = true
        }
    }
    
    func setFuncOnSessionFinshed(onSessionFinished: @escaping () -> Void){
        self.onSessionFinished = onSessionFinished
    }
    
    func playCoinsDroppingSound() {
        guard let soundURL = Bundle.main.url(forResource: "coinsDropping", withExtension: "mp3") else {
            print("No sound file")
            return
        }

        do {
            // Use the class-level property instead of a local variable
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                self?.audioPlayer?.stop()
            }
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    
    func uploadExitReason(exitReason: String) async {
        let apiCaller = ApiCaller()
        do {
            print("currentSession.sessionId.uuidString,", currentSession.sessionId.uuidString, exitReason )
            _ = try await apiCaller.callApiWithToken(
                endpoint: "add-session-exit-reason",
                method: .post,
                token: Patient.shared.authAccess.accessTokenValue,
                body: [
                    "session_id": currentSession.sessionId.uuidString,
                    "reason": exitReason
                ]
            )
        } catch {
            
        }
    }
}
