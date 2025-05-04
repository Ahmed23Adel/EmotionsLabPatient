//
//  SingleAvatarViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 04/05/2025.
//

import Foundation

class SingleAvatarViewModel: ObservableObject{
    @Published var currentAvatar = SingleAvatar(avatarId: "", name: "tommy", imageUrl: "https://i.ibb.co/ycwpvmGb/Tommy.gif", price: 250, isPurchased: false)
    @Published var isLoading = false
    private let apiCaller =  ApiCaller()
    var onAvatarPurchase: (Int) -> Void
    var isAbleToBuy: (Int) -> Bool
    
    init(onAvatarPurchaseFn: @escaping (Int) -> Void, isAbleToBuyFn: @escaping (Int) -> Bool){
        onAvatarPurchase = onAvatarPurchaseFn
        isAbleToBuy = isAbleToBuyFn
    }
    
    func setCurrentAvatar(currentAvatar: SingleAvatar){
        self.currentAvatar = currentAvatar
    }
    
    func setOnAvatarPurchaseFunc(fn: @escaping (Int) -> Void){
        self.onAvatarPurchase = fn
        
    }
    
    func setIsAbleToBuyFunc(fn: @escaping (Int) -> Bool){
        self.isAbleToBuy = fn
        
    }
    
    func buyCurrentAvatar(){
        Task {
            isLoading = true
            await uploadBuyCurrentAvatar()
            isLoading = false
            currentAvatar.isPurchased = true
            onAvatarPurchase(currentAvatar.price)
        }
        
    }
    
    private func uploadBuyCurrentAvatar() async {
        do{
            let _ = try await apiCaller.callApiWithToken(
                endpoint: "user/buy-avatar",
                method: .post,
                token: Patient.shared.authAccess.accessTokenValue,
                body:[
                    "avatar_id": currentAvatar.avatarId
                ]
            )
            
        }catch{
            
        }
    }
    
    func isAbleToBuyCurrentAvatar() -> Bool{
        isAbleToBuy(currentAvatar.price)
    }
}
