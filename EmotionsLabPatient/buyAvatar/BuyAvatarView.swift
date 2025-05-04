//
//  buyAvatar.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 04/05/2025.
//

import SwiftUI

struct BuyAvatarView: View {
    @StateObject private var viewModel = BuyAvatarViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack{
            Color(red: 138/255, green: 204/255, blue: 213/255)
            if viewModel.isLoading{
                ProgressView("Please wait..")
            } else{
                VStack {
                    HStack {
                        Text("Wallet: \(viewModel.walletCoins)")
                            .font(.title)
                            .foregroundColor(Color(red: 34/255, green: 40/255, blue: 49/255))
                            .padding(40)
                        ZStack {
                            StackedCoinsView()
                                .frame(width: 20, height: 20)
                                .scaleEffect(0.2)
                        }
                        .padding(40)
                    }
                    ScrollView{
                        LazyVGrid(columns: columns){
                            ForEach(viewModel.avatars, id: \.id){ avatar in
                                SingleAvatarView(currentAvatar: avatar, onAvatarPurchase: viewModel.onAvatarPurchase, isAbleToBuy: viewModel.isAbleToBuy)
                            }
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    BuyAvatarView()
}
