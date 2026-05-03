//
//  ScannerVC.swift
//  SwiftUI+UIKITBarcodeScanner
//
//  Created by Selim on 27.04.2026.
//

import UIKit
import AVFoundation

enum CameraError : String {
    case invalideDeviceInput = "Invalid device input"
    case invalideScannedValue = "Invalid scanned value"
}

protocol ScannerVCDelegate : AnyObject {
    func didFind(code: String)
    func didSurface(error: CameraError)
}

final class ScannerVC: UIViewController {

    let captureSession =  AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?

    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    deinit {
//        if captureSession.isRunning {
//            captureSession.stopRunning()
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCaptureSession()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if !captureSession.isRunning {
//            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//                self?.captureSession.startRunning()
//            }
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession.isRunning {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession.stopRunning()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalideDeviceInput)
            return
        }

        previewLayer.frame = view.layer.bounds
    }

    private func setCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: .invalideDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegate?.didSurface(error: .invalideDeviceInput)
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didSurface(error: .invalideDeviceInput)
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput
                .setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            scannerDelegate?.didSurface(error: .invalideDeviceInput)
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)

        // Don't start here - will start in viewWillAppear
    }

}

extension ScannerVC : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didSurface(error: .invalideScannedValue)
            return
        }

        guard let machineReadableCodeObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalideScannedValue)
            return
        }

        guard let barcode = machineReadableCodeObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalideScannedValue)
            return
        }

        scannerDelegate?.didFind(code: barcode)
    }
}
