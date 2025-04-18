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
    private let apiCaller = ApiCaller()
    private let authAccess = AuthAccess.shared
    private let patient = Patient.shared
    @Published var isLoading = false
    @Published var isNavigateToMainView = false
    func trySignup() async{
        if validateUsernameField(){
            do{
                isLoading = true
                try await patient.loginUsingUsername(username: self.username)
                letUserEnterUsernameAgain()
                navigateToMainView()
            } catch ApiCallerErrors.serializationError{
                showErrorParsing()
            }
            catch SignupError.invalidUsername{
                showErrorWrongUserName()
            } catch{
                showGeneralError()
            }
            
        }
    }
    private func validateUsernameField() -> Bool{
        if username.isEmpty{
            showErrorNoUsername()
            return false
        }
        return true
    }
    
    private func showErrorNoUsername(){
        isShowError = true
        errorTitle = "Username is empty"
        errorMsg = "Please add a username"
    }
    
    private func parseSignupDataAndSave(data: Data) -> Bool{
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(TokenRsponseModel.self, from: data)
            saveTokenValues(accesToken: response.accesToken, refreshToken: response.refreshToken)
            return true
        } catch{
            print("error", error)
            showErrorParsing()
        }
        return false
        
    }
    
    private func showErrorParsing(){
        letUserEnterUsernameAgain()
        isShowError = true
        errorTitle = "Error with singning up"
        errorMsg = "Please try again later"
    }
    
    private func saveTokenValues(accesToken: String, refreshToken: String){
        authAccess.setAccessAndRefreshAndSave(accessToken: accesToken, refreshToken: refreshToken)
        isLoading = false
        
    }
    
    private func showErrorWrongUserName(){
        letUserEnterUsernameAgain()
        isShowError = true
        errorTitle = "Wrong username"
        errorMsg = "Please contact your therapist and enter valid username"
    }
    
    private func letUserEnterUsernameAgain(){
        isLoading = false
        
    }
    
    
    
    private func navigateToMainView(){
        isLoading = false
        isNavigateToMainView = true
    }
    
    private func showGeneralError(){
        letUserEnterUsernameAgain()
        isShowError = true
        errorTitle = "Error happened"
        errorMsg = "Please try again later"
    }
    
}
