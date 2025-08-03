import Foundation

struct SaleItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var price: Double
}
