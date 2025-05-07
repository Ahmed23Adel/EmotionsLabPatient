//
//  ImagesSessionGame.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import SwiftUI

struct ImagesSessionGameView: View {
    @Environment(\.dismiss) var dismiss
    var currentSession: ImagesSession
    @StateObject var viewModel = ImagesSessionGameViewModel()
    var onSessionFinished: () -> Void
    var body: some View {
        ZStack{
            Color(red: 25/255, green: 166/255, blue: 220/255)
                .ignoresSafeArea()
            if viewModel.isUploadingResults{
                ProgressView("Please wait...")
            } else if viewModel.isShowCoins{
                StackedCoinsView()
            } else{
                VStack{
                    MultipleImagesView(emotionsImages: $viewModel.emotionsImages, selectCurrentImageParentFunc: viewModel.imageSelect)
                    MultiplieImageNamesView(emotionNames: $viewModel.emotionNames, selectCurrentNameParentFunc: viewModel.nameSelect)
                }
            }
            
            
            
        }
        .onAppear{
            viewModel.setCurrentSession(currentSession)
            viewModel.setFuncOnSessionFinshed(onSessionFinished: onSessionFinished)
        }
        .onChange(of: viewModel.isGameFinished){
            if viewModel.isGameFinished{
                dismiss()
            }
        }
    }
}



#Preview {
    
    ImagesSessionGameView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled), onSessionFinished: {
        
    })
}
