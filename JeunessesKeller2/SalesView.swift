import SwiftUI

struct SalesView: View {
    @EnvironmentObject var itemStore: ItemStore
    @EnvironmentObject var sessionStore: SessionStore
    @State private var basket: [BasketItem] = []

    var body: some View {
//        NavigationView {
            VStack {
             Text("Keller Shop2")
              .font(.largeTitle)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 5)], spacing: 16) {
                        ForEach(itemStore.items) { item in
                            Button(action: {
                                addToBasket(item: item)
                            }) {
                                VStack {
                                    Text(item.name)
                                  .bold()
                                  .font(.system(size: 18, weight: .bold))
                                  .padding(10)
                                    Text("€\(item.price, specifier: "%.2f")")
                                  .font(.headline)
//                                  .padding(5)
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
                 HStack {
//                        Text("Total: $\(basketTotal, specifier: "%.2f")")
//                            .font(.title2)
//                        Spacer()
                     Button("Total: $\(basketTotal, specifier: "%.2f")") {
                         sessionStore.addSession(items: basket)
                         basket.removeAll()
                     }
                     .font(.largeTitle)
                     .padding()
                     .background(Color.green)
                     .foregroundColor(.white)
                     .cornerRadius(10)
                 }
                 .frame(width: 350)
                 .padding()
                    List {
                        ForEach(basket) { item in
                            HStack {
                                Text("\(item.name) x\(item.quantity)")
//                              .font(.largeTitle)
                                Spacer()
                                Text("$\(Double(item.quantity) * item.unitPrice, specifier: "%.2f")")
                              .font(.title3)
                            }
                            .frame(width: 200)
                        }
                        .onDelete(perform: removeFromBasket)
                    }

                 
                }
            }
            .background(Color.orange)
//            .navigationTitle("Keller Shop2")
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
