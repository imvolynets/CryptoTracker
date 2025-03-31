import Foundation

extension Double {
    private struct Formatter {
        static let currency: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.currencyCode = "USD"
            return formatter
        }()
    }
    
    /// Converts a Double into a currency string with a specified number of decimal places.
    /// ```
    /// Convert 1234.56 to "$1,234.56" (for 2 decimals)
    /// Convert 12.3456 to "$12.3456" (for 6 decimals)
    /// ```
    private func formattedCurrency(minDecimals: Int, maxDecimals: Int) -> String {
        let formatter = Formatter.currency
        formatter.minimumFractionDigits = minDecimals
        formatter.maximumFractionDigits = maxDecimals
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    /// Converts a Double into a Currency as a String with 2 decimal places.
    func asCurrencyWith2Decimals() -> String {
        return formattedCurrency(minDecimals: 2, maxDecimals: 2)
    }
    
    /// Converts a Double into a Currency as a String with 2-6 decimal places.
    func asCurrencyWith6Decimals() -> String {
        return formattedCurrency(minDecimals: 2, maxDecimals: 6)
    }
}
