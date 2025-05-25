//
//  ImageSessionGameTutorial.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 12/05/2025.
//

import SwiftUI

struct ImageSessionGameTutorialView: View {
    @Environment(\.dismiss) var dismiss
    var currentSession: ImagesSession
    @StateObject var viewModel = ImageSessionGameTutorialViewModel()
    var onSessionFinished: () -> Void
    
    var body: some View {
        ZStack {
            if viewModel.chosenBakcground != "noBackground" {
                Image(viewModel.chosenBakcground)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
            
            VStack {
                MultipleImagesViewTutorial(emotionsImages: $viewModel.emotionsImages, selectCurrentImageParentFunc: viewModel.imageSelect)
                MultiplieImageNamesViewTutorial(emotionNames: $viewModel.emotionNames, selectCurrentNameParentFunc: viewModel.nameSelect)
            }
            .padding(.top, 50)
            if viewModel.currentTutorialStep == .initial{
                tutorialOverlayIntial
            } else if viewModel.currentTutorialStep == .completed{
                tutorialOverlayCompleted
            } 
        }
        .onAppear{
            viewModel.setFinishingFunc(fn: onSessionFinished)
        }
    }
    
    
    private var tutorialOverlayIntial: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
                .opacity(0.6)
            VStack{
                Text("Welcome to the Emotion lab Game!")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Text("In this game, you'll match images with their corresponding emotions.")
                    .foregroundColor(.white)
                    .padding()
                Button("Start Tutorial") {
                    withAnimation {
                        viewModel.setStateToImageSelect()
                    }
                }
                .buttonStyle(.borderless)
            }
        }
        
        
    }
    private var tutorialOverlayCompleted: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
                .opacity(0.6)
            VStack{
                Text("Congratulations you finished the first tutorial 🎉")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Button("Finish") {
                    withAnimation {
                        viewModel.onSessionFinished()
                        dismiss()
                    }
                }
                .buttonStyle(.borderless)
            }
        }
        
        
    }

}

#Preview {
    ImageSessionGameTutorialView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled), onSessionFinished: {
        
    })
}
