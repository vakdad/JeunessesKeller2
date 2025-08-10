import SwiftUI
import AVFoundation
struct SalesView: View {
    @EnvironmentObject var itemStore: ItemStore
    @EnvironmentObject var sessionStore: SessionStore
    @State private var basket: [BasketItem] = []
 @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
//        NavigationView {
            VStack {
             Text("Keller Shop2")
              .font(.largeTitle)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 10)], spacing: 10) {
                        ForEach(itemStore.items) { item in
                            Button(action: {
                                addToBasket(item: item)
                             let wav = getSoundName(product: item.name)
                             
                             playSound(wav: wav)
                            }) {
                                VStack {
                                    Text(item.name)
                                  .bold()
                                  .font(.system(size: 15, weight: .bold))
                                    Text("€\(item.price, specifier: "%.2f")")
                                  .font(.headline)
                                  .padding(.trailing)
                                }
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
//                                .padding(5)
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
                     Button("Total: €\(basketTotal, specifier: "%.2f")") {
                         sessionStore.addSession(items: basket)
                      playSound(wav: "cash3loudslo")
                         basket.removeAll()
                     }
                     .font(.largeTitle)
                     .padding()
                     .background(Color.green)
                     .foregroundColor(.white)
                     .cornerRadius(10)
                 }//hstack
                 .frame(width: 350)
                 .padding()
                    List {
                        ForEach(basket) { item in
                            HStack {
                                Text("\(item.name) x\(item.quantity)")
//                              .font(.largeTitle)
                                Spacer()
                                Text("€\(Double(item.quantity) * item.unitPrice, specifier: "%.2f")")
                              .font(.title3)
                            }
                            .frame(width: 200)
                        }
                        .onDelete(perform: removeFromBasket)
                    }//list
                    .frame(width: 350)

                 
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
 func playSound(wav: String) {
       guard let soundURL = Bundle.main.url(forResource: wav, withExtension: "wav") else {
           print("Sound file not found.")
           return
       }

       do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
           audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
           audioPlayer?.play()
       } catch {
           print("Error playing sound: \(error.localizedDescription)")
       }
   }//func playsound
 func getSoundName(product: String) -> String {
  switch product {
  case "Rotwein":
   return "redwine"
  case "Weißwein":
   return "whitewine"
  case "Bier":
   return "beerpst"
  case "Bier0":
   return "beer2"
  case "Nüße":
   return "checker01"
  case "Sprüdel":
   return "checker01"
  default:
   return "checker01"
  }

 }
}
