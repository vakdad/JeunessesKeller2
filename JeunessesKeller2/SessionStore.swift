import Foundation

class SessionStore: ObservableObject {
    @Published var sessions: [PurchaseSession] = [] {
        didSet { saveToDisk() }
    }

    private let fileName = "sessions.json"

    init() {
        loadFromDisk()
    }

    func addSession(items: [BasketItem]) {
        let session = PurchaseSession(timestamp: Date(), items: items)
        sessions.append(session)
    }

    private func getFileURL() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }

    private func saveToDisk() {
        guard let url = getFileURL(),
              let data = try? JSONEncoder().encode(sessions) else { return }
        try? data.write(to: url)
    }

    private func loadFromDisk() {
        guard let url = getFileURL(),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([PurchaseSession].self, from: data) else { return }
        self.sessions = decoded
    }
}
