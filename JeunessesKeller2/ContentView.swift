// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink("Sell", destination: SalesView())
                NavigationLink("Sessions", destination: SessionsView())
                NavigationLink("Admin", destination: DashboardView())
                NavigationLink("Edit Items", destination: EditItemsView())
            }
            .navigationTitle("Menu")
        } detail: {
            SalesView()
        }
    }
}
