import { Injectable } from '@angular/core';
import { BarcodeScanner } from '@nativescript/barcodescanner';

@Injectable({
  providedIn: 'root',
})
export class BarcodeScannerService {
  constructor(private barcodeScanner: BarcodeScanner) {}

  async scan(): Promise<string> {
    const available = await this.barcodeScanner.available();
    if (available) {
      const result = await this.barcodeScanner.scan({
        formats: 'EAN_13, EAN_8, QR_CODE',
        message: 'Place the barcode inside the rectangle to scan',
        showFlipCameraButton: true,
        preferFrontCamera: false,
        showTorchButton: true,
        beepOnScan: true,
        torchOn: false,
        resultDisplayDuration: 500,
      });
      if (result.text) {
        return result.text;
      }
    }
    throw new Error('Barcode scanner not available');
  }
}