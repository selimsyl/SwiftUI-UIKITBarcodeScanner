//
//  ContentView.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 27.04.2026.
//

import SwiftUI
import CoreData

struct BarcodeScannerView: View {

    @State var scannedBarcode : String = ""

    var body : some View {
        NavigationStack {
            VStack {
                ScannerView(scanResult: $scannedBarcode)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 300)

                Spacer().frame(height:60)

                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)

                Text(scannedBarcode.isEmpty ? "Not scanned yet" : scannedBarcode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(scannedBarcode.isEmpty ? .red : .green)
                    .padding()

            }.navigationTitle("Barcode Scanner")
        }
    }
}
#Preview {
    BarcodeScannerView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
