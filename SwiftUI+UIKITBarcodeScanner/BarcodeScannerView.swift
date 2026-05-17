//
//  ContentView.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 27.04.2026.
//

import SwiftUI
import CoreData

struct BarcodeScannerView: View {

    @StateObject var viewModel = BarcodeScannerViewModel()

    var body : some View {
        NavigationStack {
            VStack {
                ScannerView(scanResult: $viewModel.scannedBarcode, alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 300)

                Spacer().frame(height:60)

                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)

                Text(viewModel.statusContext)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(viewModel.statusTextColor)
                    .padding()

            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(
                    title: Text(alertItem.title),
                    message: Text(alertItem.message),
                    dismissButton: alertItem.dismissButton
                )
            }
        }
    }
}
#Preview {
    BarcodeScannerView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
