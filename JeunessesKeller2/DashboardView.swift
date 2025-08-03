//
//  DashboardView.swift
//  JeunessesKeller
//
//  Created by Geoffry Wharton on 02.08.25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var sessionStore: SessionStore

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
                Text("Admin Dashboard")
                    .font(.largeTitle)
                    .bold()

                Text("Total Revenue: $\(String(format: "%.2f", totalRevenue))")
                    .font(.title2)

                Text("Top Selling Items:")
                    .font(.title3)

                List(itemCounts.sorted { $0.value > $1.value }, id: \.key) { key, value in
                    HStack {
                        Text(key)
                        Spacer()
                        Text("\(value) sold")
                    }
                }
            }
            .padding()
//        }
    }
}

