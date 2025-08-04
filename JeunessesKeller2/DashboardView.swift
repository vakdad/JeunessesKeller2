//
//  DashboardView.swift
//  JeunessesKeller
//
//  Created by Geoffry Wharton on 02.08.25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var sessionStore: SessionStore
@State var alertIsPresented: Bool = false
    var totalRevenue: Double {
        sessionStore.sessions.reduce(0) { $0 + $1.total }
    }

    var itemCounts: [String: Int] {
        var counts: [String: Int] = [:]
        for session in sessionStore.sessions {
            for item in session.items {
                counts[item.name, default: 0] += item.quantity
            }
        }
        return counts
    }

    var body: some View {
//        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
             ZStack(alignment: .bottom) {
              Image("kellershop image")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 200)
          
              Text("Total: €\(String(format: "%.2f", totalRevenue))")
                  .font(.title2)
             }

              

             
//             ShareFileButton(fileName: "Transactions.tsv")
                List(itemCounts.sorted { $0.value > $1.value }, id: \.key) { key, value in
                    HStack {
                        Text(key)
                        Spacer()
                        Text("\(value) sold")
                    }
                }
            }
            .frame(width: 300)
            .background(Color(.systemGray6))
            .padding()
     Button("Reset Data (Screenshot or copy first!)"){
      alertIsPresented.toggle()
//      resetData()
     }
     .alert("Reset?",isPresented: $alertIsPresented) {
     
      Button("Reset") {
       resetData( )
      
      }//button
      Button("Cancel") {
       print("Cancel")
       
      }
     } message: {
      Text("Copy or screenshot data before resetting!")
     }//.alert
//        }
    }//body view
 func resetData() {
  UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
  sessionStore.sessions.removeAll()
 }
}

