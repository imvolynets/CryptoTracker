import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private let dataService = CoinDataService()
    
    init() {
        addSubsribers()
    }
    
    private func addSubsribers() {
        dataService.$allCoins
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
    }
}
