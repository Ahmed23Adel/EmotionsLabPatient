//
//  SingleImageNameWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

struct SingleImageNameWithAnimationView: View {
    @State var scaleValue = 0.1
    @State private var offsetX: CGFloat = 0 // For vibration effect
    @ObservedObject var currentSingleName: SingleImageName
    var selectCurrentNameParentFunc: (SingleImageName) -> Void
    
    var body: some View {
        SingleImageNameView(currentSingleName: currentSingleName, selectCurrentNameParentFunc: selectCurrentNameParentFunc)
            .scaleEffect(scaleValue)
            .offset(x: offsetX) // Apply horizontal offset for vibration
            .onAppear {
                withAnimation(.bouncy(duration: 1)) {
                    scaleValue = 1
                }
            }
            .onChange(of: currentSingleName.isHide) {
                withAnimation(.easeOut(duration: 0.2)) {
                    scaleValue = 0
                }
            }
            .onChange(of: currentSingleName.showError){
                if currentSingleName.showError{
                    vibrateView()
                }
            }
          
    }
    
    // Function to create vibration effect
    private func vibrateView() {
        // Series of quick animations to create vibration
        let duration = 0.05
        let numVibrations = 5
        
        for i in 0..<numVibrations {
            // Move right
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(i * 2)) {
                withAnimation(.easeInOut(duration: duration)) {
                    offsetX = 5
                }
            }
            
            // Move left
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(i * 2 + 1)) {
                withAnimation(.easeInOut(duration: duration)) {
                    offsetX = -5
                }
            }
        }
        
        // Reset position at the end
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(numVibrations * 2)) {
            withAnimation(.easeInOut(duration: duration)) {
                offsetX = 0
            }
        }
    }
}

#Preview {
    @State var currentSingleName = SingleImageName(emotionName: "Happy")
    let dummyFunc: (SingleImageName) -> Void = { image in
        print("Dummy function called with: \(image)")
    }
    SingleImageNameWithAnimationView(currentSingleName: currentSingleName, selectCurrentNameParentFunc: dummyFunc)
}
