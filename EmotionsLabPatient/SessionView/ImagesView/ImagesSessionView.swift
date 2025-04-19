//
//  ImagesView.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import SwiftUI

struct ImagesSessionView: View {
    @StateObject var viewModel = ImagesSessionViewModel()
    var currentSession: ImagesSession
    var body: some View {
        ZStack{
            Text("images view")
        }
        .onAppear{
            viewModel.setSession(session: currentSession)
        }
    }
}

#Preview {
    ImagesSessionView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled))
}
