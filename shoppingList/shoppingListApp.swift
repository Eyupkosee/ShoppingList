//
//  shoppingListApp.swift
//  shoppingList
//
//  Created by eyüp köse on 6.01.2025.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

@main
struct shoppingListApp: App {
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_RWQPbkzteEcwjyOIEIADyEoeGhX")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light) // Zorla light mod kullan
        }
    }
    
}
