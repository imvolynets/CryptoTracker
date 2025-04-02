import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(Coin.bitcoin)
            self.portfolioCoins.append(Coin.bitcoin)
        }
    }
}
