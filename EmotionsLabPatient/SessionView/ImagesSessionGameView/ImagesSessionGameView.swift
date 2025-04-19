//
//  ImagesSessionGame.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import SwiftUI

struct ImagesSessionGameView: View {
    var currentSession: ImagesSession
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ImagesSessionGameView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled))
}
