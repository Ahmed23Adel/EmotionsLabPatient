//
//  SingleImageWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI
struct SingleImageWithAnimationView: View {
    @State var scaleValue = 0.1
    @State private var offsetX: CGFloat = 0 // For vibration effect
    @State private var showErrorOverlay = false // For white overlay
    @ObservedObject var currentImage: SingleImage
    var selectCurrentImageParentFunc: (SingleImage, Bool) -> Void
    
    var body: some View {
        ZStack {
            // Main image view with vibration effect
            SingleImageView(currentImage: currentImage, selectCurrentImageParentFunc: selectCurrentImageParentFunc)
                .scaleEffect(scaleValue)
                .offset(x: offsetX) // Apply horizontal offset for vibration
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) {
                        scaleValue = 1
                    }
                }
                .onChange(of: currentImage.isHide) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        scaleValue = 0
                    }
                }
                .onChange(of: currentImage.showError){
                    if currentImage.showError{
                        vibrateView()
                       
                        
                    }
                }
            
            
        }
    }
    
    private func vibrateView() {
        // Series of quick animations to create vibration
        let duration = 0.05
        let numVibrations = 5
        
        for i in 0..<numVibrations {
            // Move right
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(i * 2)) {
                withAnimation(.easeInOut(duration: duration)) {
                    offsetX = 5 // Adjust strength of vibration as needed
                }
            }
            
            // Move left
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(i * 2 + 1)) {
                withAnimation(.easeInOut(duration: duration)) {
                    offsetX = -5 // Adjust strength of vibration as needed
                }
            }
        }
        
        // Reset position at the end
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(numVibrations * 2)) {
            withAnimation(.easeInOut(duration: duration)) {
                offsetX = 0
            }
        }
        currentImage.showError = false
    }
}

#Preview {
    @State var currentImage = SingleImage(imageName: "happy1", emotionName: "happy")
    let dummyFunc: (SingleImage, Bool) -> Void = { image, isSelected in
        print("Dummy function called with: \(image), selected: \(isSelected)")
    }
    SingleImageWithAnimationView(currentImage: currentImage, selectCurrentImageParentFunc: dummyFunc)
}
