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
    private(set) var username = ""
    private let subServiceName = "patient"
    private var serviceName: String {
        Constants.KeyChainConstants.baseService + subServiceName
    }
    private let usernameAccount = "username"
    private let apiCaller = ApiCaller()
    
    private init(){
        
    }
    
    func loadPatientData(){
        self.username = String(data: readKeychainForServiceAndAccount(subServiceName, usernameAccount), encoding: .utf8) ?? ""
        print("username", self.username)
    }
        
    func readKeychainForServiceAndAccount(_ service: String, _ account: String) -> Data {
        let output =  KeychainHelper.shared.read(service: Constants.KeyChainConstants.baseService + service, account: account)
        if let output = output{
            return output
        }
        return Data()
    }
    
    func setUserName(username: String){
        self.username = username
        print("saving username", username)
        KeychainHelper.shared.save(self.username.data(using: .utf8) ?? Data(), service: serviceName, account: usernameAccount)
    }
    
    func tryReadUsername() -> (Bool, String?){
        loadPatientData()
        if !self.username.isEmpty{
            return (true, self.username)
        }
        else {
            return (false, "")
        }
    }
    
    func loginUsingUsername(username: String) async throws {
        do{
            let data = try await apiCaller.callApiNoToken(
                endpoint: "token",
                method: .post,
                body: [
                    "username": username.trimmingCharacters(in: .whitespacesAndNewlines)
                ])
            
                if try parseSignupDataAndSave(data: data) {
                    setUserName(username: username)
                }
        } catch let error as ApiCallingErrorDetails{
            throw SignupError.invalidUsername
        }
    }
    
    private func parseSignupDataAndSave(data: Data) throws -> Bool{
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(TokenRsponseModel.self, from: data)
            saveTokenValues(accesToken: response.accesToken, refreshToken: response.refreshToken)
            return true
        } catch{
            throw ApiCallerErrors.serializationError
        }
        
    }
    
    
    private func saveTokenValues(accesToken: String, refreshToken: String){
        authAccess.setAccessAndRefreshAndSave(accessToken: accesToken, refreshToken: refreshToken)
        
    }
    
    
}
