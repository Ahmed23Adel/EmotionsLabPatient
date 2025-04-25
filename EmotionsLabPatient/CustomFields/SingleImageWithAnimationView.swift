//
//  SingleImageWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

struct SingleImageWithAnimationView: View {
    @State var scaleValue = 0.1
    @ObservedObject var currentImage: SingleImage
    var selectCurrentImageParentFunc: (SingleImage, Bool) -> Void
    
    var body: some View {
        if !currentImage.isHide {
            // Pass the currentImage object directly instead of as a binding
            SingleImageView(currentImage: currentImage, selectCurrentImageParentFunc: selectCurrentImageParentFunc)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) {
                        scaleValue = 1
                    }
                }
        } else {
            Text("")
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
