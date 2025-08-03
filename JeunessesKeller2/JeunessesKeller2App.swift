//
//  JeunessesKeller2App.swift
//  JeunessesKeller2
//
//  Created by Geoffry Wharton on 02.08.25.
//
import SwiftUI

@main
struct JeunessesKeller2: App {
    @StateObject private var sessionStore = SessionStore()
    @StateObject private var itemStore = ItemStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionStore)
                .environmentObject(itemStore)
        }
    }
}

