//
//  BarcodeScannerViewModel.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 17.05.2026.
//

import Foundation
import SwiftUI
import Combine

final class BarcodeScannerViewModel : ObservableObject {

    @Published var scannedBarcode = ""
    @Published var alertItem: AlertItem?

    var statusContext : String {
        scannedBarcode.isEmpty ? "Not scanned yet" : scannedBarcode
    }

    var statusTextColor : Color {
        scannedBarcode.isEmpty ? .red : .green
    }
}

