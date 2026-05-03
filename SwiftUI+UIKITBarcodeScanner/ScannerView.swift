//
//  ScannerView.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 3.05.2026.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

    @Binding var scanResult : String

    typealias UIViewControllerType = ScannerVC

    func makeUIViewController(context: Context) -> ScannerVC {
       return ScannerVC(scannerDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerVC,context: Context) {}

    final class Coordinator : NSObject, ScannerVCDelegate {
        private let scannerVview: ScannerView

        init(scannerVview: ScannerView) {
            self.scannerVview = scannerVview
        }

        func didFind(code: String) {
            scannerVview.scanResult = code
        }

        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(scannerVview: self)
    }
}

#Preview {
    ScannerView(scanResult: .constant("123456"))
}
