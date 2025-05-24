//
//  CustomBackground.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import SwiftUI


struct CustomBackground: View {
    @State private var animationComplete = false
    @State private var showFence = false
    @State private var showSign = false
    @State private var showTree = false
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("basicbackground")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Fence
                Image("fence")
                    .offset(y: showFence ? 0 : geometry.size.height)
                    .position(
                        x: geometry.size.width * 0.8,
                        y: geometry.size.height * 0.6
                    )
                
                // Sign
                Image("sign")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(y: showSign ? 0 : geometry.size.height)
                    .position(
                        x: geometry.size.width * 0.2,
                        y: geometry.size.height * 0.7
                    )
                
                // Tree
                Image("tree")
                    .resizable()
                    .frame(width: 400, height: 600)
                    .offset(y: showTree ? 0 : geometry.size.height)
                    .position(
                        x: geometry.size.width * 0.75,
                        y: geometry.size.height * 0.5
                    )

                Color.white
                    .opacity(0.5 )
                    .ignoresSafeArea()
            }
            .onAppear {
                // Drop the entire emoji + string
                withAnimation(.easeOut(duration: 2.0)) {
                    animationComplete = true
                }
                // Animate other background elements
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.2)) {
                        showFence = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.2)) {
                        showSign = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.2)) {
                        showTree = true
                    }
                }
            }
            
        }
    }
    
}

#Preview {
    CustomBackground()
}
