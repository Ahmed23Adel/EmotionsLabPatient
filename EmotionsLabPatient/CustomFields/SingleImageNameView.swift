//
//  SingleImageName.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

struct SingleImageNameView: View {
    @ObservedObject var currentSingleName: SingleImageName
    @State var selectedColorGradient = [
        Color.green
    ]
    @State var notSelectedColorGradient = [
        Color(red: 255/255, green: 110/255, blue: 199/255)
    ]
    @State var imgWidthBig = 160.0
    @State var imgHeightBig = 70.0
    @State var imgWidthSmall = 140.0
    @State var imgHeightSmall = 50.0
    
    var selectCurrentNameParentFunc: (SingleImageName) -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: currentSingleName.isSelected ? selectedColorGradient : notSelectedColorGradient),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    
                )
                .frame(width: imgWidthBig, height: imgHeightBig)
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 255/255, green: 219/255, blue: 50/255), // light orange
                            Color(red: 255/255, green: 140/255, blue: 0/255) //dark orange
                            
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                )
                .frame(width: imgWidthSmall, height: imgHeightSmall)
            CustomText(text: currentSingleName.emotionName.capitalizingFirstLetter())
        }
        .onTapGesture {
            if currentSingleName.isAbleToSelect{
                currentSingleName.isSelected.toggle()
                selectCurrentNameParentFunc(currentSingleName)
                
                
            }
        }
        .onChange(of: currentSingleName.isSelected){
            SelectOrUnselectView()
        }
    }
    
    
    private func selectName(){
        imgWidthBig += 10
        imgHeightBig += 10
        imgWidthSmall += 10
        imgHeightSmall += 10
    }
    private func unSelectName(){
        imgWidthBig -= 10
        imgHeightBig -= 10
        imgWidthSmall -= 10
        imgHeightSmall -= 10
    }
    
    private func SelectOrUnselectView(){
        if currentSingleName.isSelected{
            withAnimation(.easeIn(duration: 0.1)){
                selectName()
            }
        } else{
            withAnimation(.easeIn(duration: 0.1)){
                unSelectName()
            }
        }
        
    }
}


struct CustomText: View {
    var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .foregroundColor(Color(red: 24/255, green: 59/255, blue: 78/255))
                .font(.system(size: 25))
                
        }
    }
}



#Preview {
    @State var currentSingleName = SingleImageName(emotionName: "Happy")
    let dummyFunc: (SingleImageName) -> Void = { image in
        print("Dummy function called with: \(image)")
    }

    SingleImageNameView(currentSingleName: currentSingleName, selectCurrentNameParentFunc: dummyFunc)
}
