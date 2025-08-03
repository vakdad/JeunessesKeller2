import Foundation

class ItemStore: ObservableObject {
    @Published var items: [SaleItem] = [] {
        didSet { saveItems() }
    }

    private let fileName = "sale_items.json"

    init() {
        loadItems()
    }

    private func getFileURL() -> URL? {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(fileName)
    }

    private func saveItems() {
        guard let url = getFileURL() else { return }
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: url)
        }
    }

    private func loadItems() {
        guard let url = getFileURL(), FileManager.default.fileExists(atPath: url.path) else {
            self.items = [
                SaleItem(name: "Wine", price: 6.0),
                SaleItem(name: "Beer", price: 5.0),
                SaleItem(name: "Peanuts", price: 2.5),
                SaleItem(name: "Pretzels", price: 2.0)
            ]
            return
        }

        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([SaleItem].self, from: data) {
            self.items = decoded
        }
    }
}
