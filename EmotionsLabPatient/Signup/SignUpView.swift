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
                        CustomButton(text: "Confirm", height: 110){
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
            .navigationBarBackButtonHidden(true)
            .interactiveDismissDisabled()
            .onChange(of: viewModel.isNavigateToMainView) { newValue in
                if newValue {
                    isNavigateToMainViewLocal = true
                }
            }
        }
        
        
    }
}




#Preview {
    SignUpView()
}
