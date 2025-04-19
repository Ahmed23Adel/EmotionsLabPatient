//
//  ImagesView.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import SwiftUI
import WebKit

struct ImagesSessionVideosView: View {
    @StateObject var viewModel = ImagesSessionVideoViewModel()
    
    var currentSession: ImagesSession
    var body: some View {
        NavigationStack{
            ZStack{
                CustomBackground()
                VStack(spacing: 20){
                    Text("Please watch this video carefuly first")
                        .font(.title)
                    YouTubeView(videoURL: viewModel.preGameVideo.getCurrentVideoLink())
                        .padding(40)
                        .cornerRadius(40)
                       
                    CustomButton(text: "Next"){
                        viewModel.navigateToNext = true
                    }
                    
                    
                    
                    
                }
                .cornerRadius(40)
                .background(.ultraThinMaterial)
                
            }
            .onAppear{
                viewModel.setSession(session: currentSession)
            }
            .navigationDestination(isPresented: $viewModel.navigateToNext) {
                ImagesSessionGameView(currentSession: currentSession)
            }

        }
        
    }
}


struct YouTubeView: UIViewRepresentable {
    let videoURL: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: videoURL) else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    ImagesSessionVideosView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled))
}
