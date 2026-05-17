//
//  ScannerView.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 3.05.2026.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

    @Binding var scanResult : String
    @Binding var alertItem: AlertItem?

    typealias UIViewControllerType = ScannerVC

    func makeUIViewController(context: Context) -> ScannerVC {
       return ScannerVC(scannerDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerVC,context: Context) {}

    final class Coordinator : NSObject, ScannerVCDelegate {
        private let scannerView: ScannerView

        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }

        func didFind(code: String) {
            scannerView.scanResult = code
        }

        func didSurface(error: CameraError) {
            switch error {
            case .invalideDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalideScannedValue:
                scannerView.alertItem = AlertContext.invalidScannedType
            }
        }
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
}
