import SwiftUI

struct StackedCoinsView: View {
    @State private var coins: [CoinModel] = []
    let frameWidth: CGFloat = 600
    let frameHeight: CGFloat = 600
    let coinSize: CGFloat = 400
    
    var body: some View {
        ZStack {
            ForEach(coins) { coin in
                Image("coin")
                    .resizable()
                    .frame(width: coinSize, height: coinSize)
                    .position(x: coin.x, y: coin.y)
                    .rotationEffect(.degrees(coin.rotation))
            }
        }
        .frame(width: frameWidth, height: frameHeight)
        .cornerRadius(25)
        .foregroundStyle(.white)
        .onAppear {
            addCoins()
        }
    }
    
    private func addCoins() {
        coins = []
        for i in 0..<5 {
            let bottomY = frameHeight - coinSize/2 - CGFloat(i) * 10
            
            // Create coin starting at top
            let newCoin = CoinModel(
                id: UUID(),
                x: frameWidth/2,
                y: coinSize/2,
                finalY: bottomY,
                rotation: Double.random(in: 0...10)
            )
            coins.append(newCoin)
            
            let delay = 0.2 * Double(i)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    if let index = coins.firstIndex(where: { $0.id == newCoin.id }) {
                        coins[index].y = newCoin.finalY
                    }
                }
            }
        }
    }
}

struct CoinModel: Identifiable {
    let id: UUID
    let x: CGFloat
    var y: CGFloat
    let finalY: CGFloat
    let rotation: Double
}

#Preview {
    StackedCoinsView()
}
