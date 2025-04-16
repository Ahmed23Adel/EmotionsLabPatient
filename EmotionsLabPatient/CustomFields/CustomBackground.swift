//
//  CustomBackground.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import SwiftUI

struct CustomBackground: View {
    @State private var emojiPositions: [CGPoint] = [
        CGPoint(x: 0.1, y: 0.2),
        CGPoint(x: 0.3, y: 0.4),
        CGPoint(x: 0.9, y: 0.3)
    ]
    
    @State private var animationComplete = false
    let emojis = ["emojiexcited", "emojihappy", "emojisurprised"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Falling emojis with strings
                ForEach(0..<emojis.count, id: \.self) { index in
                    
                    VStack(spacing: 0) {
                        // The string
                        Image("string")
                            .resizable()
                            .frame(width: 20, height: animationComplete ?
                                  geometry.size.height * emojiPositions[index].y : 0)
                        
                        // The emoji
                        Image(emojis[index])
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .position(
                        x: geometry.size.width * emojiPositions[index].x,
                        y: animationComplete ?
                            geometry.size.height * emojiPositions[index].y / 2 : 0
                    )
                }
            }
            .onAppear {
                // change the value of animationComplete and do that with animations
                withAnimation(.easeOut(duration: 2.0)) {
                    animationComplete = true
                }
            }
        }
    }
}

#Preview {
    CustomBackground()
}
