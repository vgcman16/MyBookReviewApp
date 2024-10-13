import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewRepresentable {
    @ObservedObject var scannerService: BarcodeScannerService
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        if let captureSession = scannerService.captureSession {
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ScannerView: View {
    @StateObject private var scannerService = BarcodeScannerService()
    @State private var isScanning = false
    
    var body: some View {
        VStack {
            if isScanning {
                BarcodeScannerView(scannerService: scannerService)
                    .frame(height: 300)
            }
            
            if let scannedCode = scannerService.scannedCode {
                Text("Scanned Code: \(scannedCode)")
            }
            
            Button(isScanning ? "Stop Scanning" : "Start Scanning") {
                isScanning.toggle()
                if isScanning {
                    scannerService.startScanning()
                } else {
                    scannerService.stopScanning()
                }
            }
        }
    }
}