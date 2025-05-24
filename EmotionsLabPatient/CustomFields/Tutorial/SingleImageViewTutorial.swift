//
//  SingleImageViewTutorial.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 12/05/2025.
//

//
//  SingleImage.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//
import SwiftUI

struct SingleImageViewTutorial: View {
    @State var imgWidthAndHeight = 140.0
    @ObservedObject var currentImage: SingleImage
    var selectCurrentImageParentFunc: (SingleImage) -> Void
    @State var selectedColorGradient = [
        Color.green
    ]
    @State var notSelectedColorGradient = [
        Color(red: 255/255, green: 0/255, blue: 127/255), // light pink
        Color(red: 255/255, green: 140/255, blue: 0/255) //dark orange
    ]
    
    @State var isPulsing = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 40)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: currentImage.isSelected ? selectedColorGradient : notSelectedColorGradient),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    
                )
                .frame(width:imgWidthAndHeight, height: imgWidthAndHeight)
                
            
            Image(currentImage.imageName)
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(25)
            if currentImage.isTutorialShowIndicator{
                Circle()
                    .stroke(Color.blue, lineWidth: 10)
                    .frame(width: 180, height: 180)
                    .scaleEffect(isPulsing ? 1.1 : 1.0)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                        value: isPulsing
                    )
                    .onAppear{
                        isPulsing = true
                        
                    }
            }
            
            
        }
        .onChange(of: currentImage.isSelected){
            SelectOrUnselectView()
        }
        .onTapGesture {
            if currentImage.isAbleToSelect{
                currentImage.isSelected.toggle()
                selectCurrentImageParentFunc(currentImage)
                
                
            }
        }
    }
    
    private func SelectOrUnselectView(){
        if currentImage.isSelected{
            withAnimation(.easeIn(duration: 0.1)){
                imgWidthAndHeight += 10
            }
        } else{
            withAnimation(.easeIn(duration: 0.1)){
                imgWidthAndHeight -= 10
            }
        }
        
    }
}





#Preview {
    @Previewable @State var currentImage = SingleImage(imageName: "happy1", emotionName: "happy", isTutorialState: true, isTutorialShowIndicator: true)

    let dummyFunc: (SingleImage) -> Void = { image in
        print("Dummy function called with: \(image), selected:")
    }

    SingleImageViewTutorial(currentImage: currentImage, selectCurrentImageParentFunc: dummyFunc)
}


