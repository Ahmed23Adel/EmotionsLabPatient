//
//  SingleImage.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//
import SwiftUI

struct SingleImageView: View {
    @State var imgWidthAndHeight = 140.0
    @ObservedObject var currentImage: SingleImage
    var selectCurrentImageParentFunc: (SingleImage, Bool) -> Void
    @State var selectedColorGradient = [
        Color.green
    ]
    @State var notSelectedColorGradient = [
        Color(red: 255/255, green: 0/255, blue: 127/255), // light pink
        Color(red: 255/255, green: 140/255, blue: 0/255) //dark orange
    ]
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
                
            
        }
        .onTapGesture {
            if currentImage.isAbleToSelect{
                print("currentImage.isSelected", currentImage.isSelected)
                if !currentImage.isSelected{
                    withAnimation(.easeIn(duration: 0.1)){
                        imgWidthAndHeight += 10
                    }
                } else{
                    withAnimation(.easeIn(duration: 0.1)){
                        imgWidthAndHeight -= 10
                    }
                }
                currentImage.isSelected.toggle()
                selectCurrentImageParentFunc(currentImage, currentImage.isSelected)
                
            }
            
        }
        
        
    }
}





#Preview {
    @State var currentImage = SingleImage(imageName: "happy1", emotionName: "happy")

    let dummyFunc: (SingleImage, Bool) -> Void = { image, isSelected in
        print("Dummy function called with: \(image), selected: \(isSelected)")
    }

    SingleImageView(currentImage: currentImage, selectCurrentImageParentFunc: dummyFunc)
}

