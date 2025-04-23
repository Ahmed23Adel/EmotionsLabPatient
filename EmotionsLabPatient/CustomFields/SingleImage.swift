//
//  SingleImage.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//
import SwiftUI

struct SingleImage: View {
    var imgName: String
    @State var imgWidthAndHeight = 140.0
    @Binding var isSelected: Bool
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 40)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 255/255, green: 0/255, blue: 127/255), // light pink
                            Color(red: 255/255, green: 140/255, blue: 0/255) //dark orange
                            
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    
                )
                .frame(width:imgWidthAndHeight, height: imgWidthAndHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.white.opacity(0.7),
                                        Color.white.opacity(0.0),
                                    ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
            
            Image(imgName)
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(25)
                
            
        }
        .onChange(of: isSelected){
            if isSelected{
                self.imgWidthAndHeight = 150.0
            } else{
                self.imgWidthAndHeight = 140
            }
        }
    }
}





#Preview {
    @State var isSelected = false
    SingleImage(imgName: "happy1", isSelected: $isSelected)
}
