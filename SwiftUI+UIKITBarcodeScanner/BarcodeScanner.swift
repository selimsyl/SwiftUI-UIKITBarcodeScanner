//
//  ContentView.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 27.04.2026.
//

import SwiftUI
import CoreData

struct BarcodeScanner: View {
    var body : some View {
        NavigationStack {
            VStack {
                Rectangle().frame(width: .infinity, height: 300)

                Spacer().frame(height:60)

                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)

                Text("Not scanned yet")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()

            }.navigationTitle("Barcode Scanner")
        }
    }
}
#Preview {
    BarcodeScanner().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
