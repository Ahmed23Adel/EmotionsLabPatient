//
//  SignUpView.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @State var isNavigateToMainViewLocal = false
    var body: some View {
        NavigationStack{
            ZStack{
                CustomBackground()
               
                VStack(spacing: 0){
                    CustomInputFieldWithAnimations(placeholder: "Username", text: $viewModel.username) {
                        CustomButton(text: "Confirm"){
                            Task{
                                await viewModel.trySignup()
                            }
                            
                        }
                    }
                    
                }
                if viewModel.isLoading{
                    Color.black.opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 10)
                    ProgressView("please wait...")
                }
                
            }
            .alert(isPresented: $viewModel.isShowError){
                Alert(
                    title: Text(viewModel.errorTitle),
                    message: Text(viewModel.errorMsg),
                    dismissButton: .default(Text("Ok"))
                )
            }
            .navigationDestination(isPresented: $isNavigateToMainViewLocal) {
                            MainView()
                        }
            .onChange(of: viewModel.isNavigateToMainView) { newValue in
                if newValue {
                    isNavigateToMainViewLocal = true
                }
            }
        }
        
        
    }
}


struct CustomButton: View {
    var text: String
    var action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(minWidth: 150, minHeight: 80)
                .background(
                    ZStack {
                        // Main red background
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.red)
                        
                        // Candy stripe border
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(
                                StripedBorderPattern(stripeCount: 12),
                                lineWidth: 8
                            )
                    }
                )
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
        }
    }
}

struct StripedBorderPattern: ShapeStyle {
    let stripeCount: Int
    
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0.9),
                Color.red
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}


#Preview {
    SignUpView()
}
