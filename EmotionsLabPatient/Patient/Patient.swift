//
//  Patient.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import Foundation

class Patient{
    static let shared = Patient()
    private(set) var authAccess = AuthAccess.shared
    
    private init(){
        
    }
    
    func loadPatientData(){
//        self.fullName = String(data: readKeychainForServiceAndAccount(therapistService, fullNameAccount), encoding: .utf8) ?? ""
//        self.email = String(data: readKeychainForServiceAndAccount(therapistService, emailAccount), encoding: .utf8) ?? ""
//        self.appleId = String(data: readKeychainForServiceAndAccount(therapistService, appleIdAccount), encoding: .utf8) ?? ""
//        self.therapistID = String(data: readKeychainForServiceAndAccount(therapistService, therapistIdAccount), encoding: .utf8) ?? ""
    }
        
    func readKeychainForServiceAndAccount(_ service: String, _ account: String) -> Data {
        let output =  KeychainHelper.shared.read(service: Constants.KeyChainConstants.baseService + service, account: account)
        if let output = output{
            return output
        }
        return Data()
    }
}
