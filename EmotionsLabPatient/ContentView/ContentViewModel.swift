//
//  ContentViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject{
    @Published var userNeedsToSignUp: Bool = false
    @Published var isChecking: Bool = true
    private var patient = Patient.shared
    
    init() {
        Task {
            await checkIsSignedIn()
            DispatchQueue.main.async {
                self.isChecking = false
            }
        }
    }

    
    func checkIsSignedIn() async{
        if checkIsAbleToContinueSession(){
            print("a1")
            if await checkIsAbleToContinueSessionWithExistingAccessToken(){
                print("a2")
                userNeedsToSignUp = false
                patient.loadPatientData()
            } else{
                print("a3")
                // some time refresh coulld fail if it's expired
                if await patient.authAccess.refreshToken(){
                    print("a4")
                    userNeedsToSignUp = false
                    patient.loadPatientData()
                } else{
                    print("a5")
//                    let (isSuccess, appleId) = patient.tryReadAppleId()
//                    if isSuccess {
//                        print("a6")
//                        if let appleId = appleId{
//                            print("a7")
//                            if await patient.authAccess.loginUsingAppleAuth(appleId: appleId){
//                                print("a8")
//                                userNeedsToSignUp = false
//                                patient.loadPatientData()
//                            } else{
//                                print("a9")
//                                userNeedsToSignUp = true
//                            }
//                            
//                        }
//                    } else{
//                        print("a11")
//                        userNeedsToSignUp = true
//                    }
                    
                }
            }
        } else{
            // sign up
            DispatchQueue.main.async {
                self.userNeedsToSignUp = true
            }
        }
    }
    private func checkIsAbleToContinueSession() -> Bool{
        patient.authAccess.tryReadRefreshTokenFromKeyChainAndValidate()
    }
    
    private func checkIsAbleToContinueSessionWithExistingAccessToken() async -> Bool{
        return await patient.authAccess.tryReadAccessTokenFromKeyChainAndValidate()
    }
    
}
