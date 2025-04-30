//
//  SingleImageWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI
struct SingleImageWithAnimationView: View {
    @State var scaleValue = 0.1
    @State private var showErrorOverlay = false
    @ObservedObject var currentImage: SingleImage
    var selectCurrentImageParentFunc: (SingleImage, Bool) -> Void
    
    var body: some View {
        ZStack {
            VibratingView(triggerVibration: $currentImage.isShowError, vibratingData: currentImage){
                SingleImageView(currentImage: currentImage, selectCurrentImageParentFunc: selectCurrentImageParentFunc)
                    .scaleEffect(scaleValue)
            }
            .onAppear{
                withAnimation(.easeIn(duration: 0.5)) {
                    scaleValue = 1
                }
            }
            .onChange(of: currentImage.isHide) {
                withAnimation(.easeOut(duration: 0.2)) {
                    scaleValue = 0
                }
            }
        }
    }
    
   
}

#Preview {
    @State var currentImage = SingleImage(imageName: "happy1", emotionName: "happy")
    let dummyFunc: (SingleImage, Bool) -> Void = { image, isSelected in
        print("Dummy function called with: \(image), selected: \(isSelected)")
    }
    SingleImageWithAnimationView(currentImage: currentImage, selectCurrentImageParentFunc: dummyFunc)
}
