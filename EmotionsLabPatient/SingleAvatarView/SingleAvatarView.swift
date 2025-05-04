import SwiftUI
import SDWebImageSwiftUI

struct SingleAvatarView: View {
    @ObservedObject var currentAvatar: SingleAvatar
    @ObservedObject var viewModel = SingleAvatarViewModel(
        onAvatarPurchaseFn: { _ in
            print("Dummy purchase called")
        },
        isAbleToBuyFn: { _ in
            return true
        }
    )
    @State private var showPurchaseAlert = false
    @State private var showCannotBuyAlert = false
    @State private var cannotBuyMessage = "Insufficient credits"
    var onAvatarPurchase: (Int) -> Void
    var isAbleToBuy: (Int) -> Bool
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Purchasing..")
            } else {
                WebImage(url: URL(string: viewModel.currentAvatar.imageUrl))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(25)
                    .mask(
                        RadialGradient(
                            gradient: Gradient(stops: [
                                .init(color: .white, location: 0),
                                .init(color: .white, location: 0.7),
                                .init(color: .clear, location: 1.0)
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 60
                        )
                    )
                
                HStack {
                    Text(viewModel.currentAvatar.name)
                        .foregroundColor(Color.black)
                    if viewModel.currentAvatar.isPurchased {
                        Text("Purchased")
                            .foregroundColor(Color.orange)
                    } else {
                        Text("Price: \(viewModel.currentAvatar.price)")
                    }
                }
            }
            
        }
        .onTapGesture {
            if !viewModel.currentAvatar.isPurchased {
                if viewModel.isAbleToBuyCurrentAvatar() {
                    showPurchaseAlert = true
                } else {
                    cannotBuyMessage = "Insufficient credits to purchase this avatar"
                    showCannotBuyAlert = true
                }
            }
        }
        .alert("Purchase Avatar", isPresented: $showPurchaseAlert) {
            Button("Yes") {
                viewModel.buyCurrentAvatar()
            }
            Button("No", role: .cancel) {}
        } message: {
            Text("Do you want to purchase \(viewModel.currentAvatar.name) for \(viewModel.currentAvatar.price) credits?")
        }
        .alert("Cannot Purchase", isPresented: $showCannotBuyAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(cannotBuyMessage)
        }
        .onAppear {
            viewModel.setCurrentAvatar(currentAvatar: currentAvatar)
            viewModel.setOnAvatarPurchaseFunc(fn: onAvatarPurchase)
            viewModel.setIsAbleToBuyFunc(fn: isAbleToBuy)
        }
    }
}

#Preview {
    SingleAvatarView(currentAvatar: SingleAvatar(avatarId: "", name: "tommy", imageUrl: "https://i.ibb.co/ycwpvmGb/Tommy.gif", price: 250, isPurchased: false), onAvatarPurchase: { _ in }, isAbleToBuy: { _ in
        return true
    })
}
