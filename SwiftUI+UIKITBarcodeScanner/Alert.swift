//
//  Alert.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 17.05.2026.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Please check your device's camera settings", dismissButton: .default(Text("OK")))
    static let invalidScannedType = AlertItem(title: "Invalid Barcode", message: "Please scan a valid barcode EAN8 or EAN13", dismissButton: .default(Text("OK")))
}
