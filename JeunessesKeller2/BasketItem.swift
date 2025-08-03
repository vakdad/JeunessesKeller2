import Foundation

struct BasketItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let unitPrice: Double
    var quantity: Int
}
