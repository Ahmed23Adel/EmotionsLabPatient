//
//  buyAvatarViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 04/05/2025.
//

import Foundation

@MainActor
class BuyAvatarViewModel: ObservableObject{
    @Published var walletCoins: Int = 0
    @Published var avatarsAvailable: Int = 0
    private let apiCaller = ApiCaller()
    @Published var isLoading = true
    @Published var avatars: [SingleAvatar]  = []
    init(){
        Task {
            await loadAvatarsData()
            DispatchQueue.main.async{
                self.isLoading = false
            }
        }
    }
    
    private func loadAvatarsData() async {
        do{
            let data = try await apiCaller.callApiWithToken(
                endpoint: "user/coins-and-avatars",
                method: .get,
                token: Patient.shared.authAccess.accessTokenValue
                
            )
            parseApiResponse(data: data)
        } catch{
            
        }
    }
    
    private func parseApiResponse(data: Data){
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(AllAvatarsAndCoinsResponseModel.self, from: data)
            walletCoins = response.coins
            avatars = response.extractAllAvatars()
            
        } catch{
            
        }
        
        
    }
    
    func onAvatarPurchase(price: Int){
        print("onAvatarPurchase")
        walletCoins -= price
    }
    
    func isAbleToBuy(price: Int) -> Bool{
        if price <= walletCoins{
            return true
        } else{
            return false
        }
    }
}
