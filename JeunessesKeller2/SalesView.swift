import SwiftUI

struct SalesView: View {
    @EnvironmentObject var itemStore: ItemStore
    @EnvironmentObject var sessionStore: SessionStore
    @State private var basket: [BasketItem] = []

    var body: some View {
//        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 16)], spacing: 16) {
                        ForEach(itemStore.items) { item in
                            Button(action: {
                                addToBasket(item: item)
                            }) {
                                VStack {
                                    Text(item.name)
                                    Text("$\(item.price, specifier: "%.2f")")
                                  .padding(15)
                                }
//                                .frame(width: 140, height: 80)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
//                                .padding(10)
                            }
                        }
                    }
                    .padding()
                }

                if !basket.isEmpty {
                    List {
                        ForEach(basket) { item in
                            HStack {
                                Text("\(item.name) x\(item.quantity)")
                                Spacer()
                                Text("$\(Double(item.quantity) * item.unitPrice, specifier: "%.2f")")
                            }
                        }
                        .onDelete(perform: removeFromBasket)
                    }

                    HStack {
                        Text("Total: $\(basketTotal, specifier: "%.2f")")
                            .font(.title2)
                        Spacer()
                        Button("Finalize Purchase") {
                            sessionStore.addSession(items: basket)
                            basket.removeAll()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Keller Shop")
//        }//nav view
    }

    private var basketTotal: Double {
        basket.reduce(0) { $0 + Double($1.quantity) * $1.unitPrice }
    }

    private func addToBasket(item: SaleItem) {
        if let index = basket.firstIndex(where: { $0.name == item.name }) {
            basket[index].quantity += 1
        } else {
            basket.append(BasketItem(name: item.name, unitPrice: item.price, quantity: 1))
        }
    }

    private func removeFromBasket(at offsets: IndexSet) {
        basket.remove(atOffsets: offsets)
    }
}
