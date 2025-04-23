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
                
                MultipleImages(emotionsImages: $viewModel.emotionsImages)
                MultiplieImageNames(emotionNumbersShown: $viewModel.emotionNumbersShown)
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
