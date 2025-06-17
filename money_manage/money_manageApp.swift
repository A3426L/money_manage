//
//  money_manageApp.swift
//  money_manage
//
//  Created by aru on 2025/04/25.
//

import SwiftUI
import SwiftData

@main
struct money_manageApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Transaction.self,Category.self])
        }
    }
}
