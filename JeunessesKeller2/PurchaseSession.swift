import Foundation

struct PurchaseSession: Identifiable, Codable {
    let id = UUID()
    let timestamp: Date
    let items: [BasketItem]

    var total: Double {
        items.reduce(0) { $0 + (Double($1.quantity) * $1.unitPrice) }
    }
}
