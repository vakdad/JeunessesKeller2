import SwiftUI

struct EditItemsView: View {
    @EnvironmentObject var itemStore: ItemStore
    @State private var newName = ""
    @State private var newPrice = ""

    var body: some View {
//        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add New Item")) {
                        TextField("Name", text: $newName)
                        TextField("Price", text: $newPrice)
                            .keyboardType(.decimalPad)

                        Button("Add") {
                            guard let price = Double(newPrice), !newName.isEmpty else { return }
                            let item = SaleItem(name: newName, price: price)
                            itemStore.items.append(item)
                            newName = ""
                            newPrice = ""
                        }
                    }

                    Section(header: Text("Current Items")) {
                        ForEach($itemStore.items) { $item in
                            VStack(alignment: .leading) {
                                TextField("Item Name", text: $item.name)
                                TextField("Price", value: $item.price, formatter: NumberFormatter.currency)
                                    .keyboardType(.decimalPad)
                            }
                        }
                        .onDelete { indexSet in
                            itemStore.items.remove(atOffsets: indexSet)
                        }
                    }
                }
            }
            .navigationTitle("Edit Sale Items")
//        }
    }
}

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
