import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let imageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()

    init(coin: Coin) {
        self.coin = coin
        self.imageService = CoinImageService(coin: coin)
        addSubsribers()
    }
    
    private func addSubsribers() {
        isLoading = true
        
        imageService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [ weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
