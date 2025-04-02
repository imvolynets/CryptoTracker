import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [Coin] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
}

// MARK: - GET
private extension CoinDataService {
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ (output) -> Data in
                guard let resonse = output.response as? HTTPURLResponse,
                      resonse.statusCode >= 200 && resonse.statusCode <= 300 else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] coins in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }
}
