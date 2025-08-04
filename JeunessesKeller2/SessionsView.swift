//
//  SessionsView.swift
//  JeunessesKeller2
//
//  Created by Geoffry Wharton on 02.08.25.
//


import SwiftUI
import Foundation
struct SessionsView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @State private var selectedDate = Date()

    var filteredSessions: [PurchaseSession] {
        sessionStore.sessions.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: selectedDate) }
    }

    var body: some View {
//        NavigationView {
            VStack {
                DatePicker("Filter by Date", selection: $selectedDate, displayedComponents: .date)
                    .padding()

                List {
                    ForEach(filteredSessions.reversed()) { session in
                        Section(header: Text(session.timestamp, style: .time)) {
                            ForEach(session.items) { item in
                                HStack {
                                    Text("\(item.name) x\(item.quantity)")
//                                    Spacer()
                                    Text("€\(String(format: "%.2f", item.unitPrice * Double(item.quantity)))")
                                }
                            }
                            HStack {
                                Spacer()
                                Text("Total: €\(String(format: "%.2f", session.total))").bold()
                            }
                        }
                    }
                }
            }
            .frame(width: 400)
            .background(Color.gray)
            .navigationTitle("Sessions")
//        }//nav view
    }
}

