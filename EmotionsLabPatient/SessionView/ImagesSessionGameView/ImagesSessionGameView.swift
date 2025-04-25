//
//  ImagesSessionGame.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import SwiftUI

struct ImagesSessionGameView: View {
    var currentSession: ImagesSession
    @StateObject var viewModel = ImagesSessionGameViewModel()
    var body: some View {
        ZStack{
            CustomBackground()
                .blur(radius: 5)
            VStack{
                
                MultipleImagesView(emotionsImages: $viewModel.emotionsImages, selectCurrentImageParentFunc: viewModel.imageSelect)
                MultiplieImageNamesView(emotionNames: $viewModel.emotionNames, selectCurrentNameParentFunc: viewModel.nameSelect)
            }
            
            
        }
        .onAppear{
            viewModel.setCurrentSession(currentSession)
        }
    }
}



#Preview {
    ImagesSessionGameView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled))
}
