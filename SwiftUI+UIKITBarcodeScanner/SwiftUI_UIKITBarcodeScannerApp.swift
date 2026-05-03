//
//  SwiftUI_UIKITBarcodeScannerApp.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 27.04.2026.
//

import SwiftUI
import CoreData

@main
struct SwiftUI_UIKITBarcodeScannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BarcodeScannerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
