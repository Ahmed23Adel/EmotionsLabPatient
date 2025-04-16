//
//  SignUpViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import Foundation

@MainActor
class SignUpViewModel: ObservableObject{
    @Published var username = ""
    @Published var isShowError = false
    @Published var errorTitle = ""
    @Published var errorMsg = ""
    
    func trySignup(){
        if username.isEmpty{
            showErrorNoUsername()
        }
    }
    
    private func showErrorNoUsername(){
        isShowError = true
        errorTitle = "Username is empty"
        errorMsg = "Please add a username"
    }
}
