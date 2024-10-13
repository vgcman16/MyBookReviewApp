import { Component } from '@angular/core';
import { BarcodeScannerService } from '../../services/barcode-scanner.service';
import { BookService } from '../../services/book.service';
import { Router } from '@angular/router';
import { alert } from '@nativescript/core';

@Component({
  selector: 'ns-barcode-scanner',
  templateUrl: './barcode-scanner.component.html',
})
export class BarcodeScannerComponent {
  constructor(
    private barcodeScannerService: BarcodeScannerService,
    private bookService: BookService,
    private router: Router
  ) {}

  async scanBarcode() {
    try {
      const barcode = await this.barcodeScannerService.scan();
      const book = await this.bookService.getBookByISBN(barcode).toPromise();
      if (book) {
        this.router.navigate(['/book', book.id]);
      } else {
        await alert({
          title: 'Book Not Found',
          message: 'The scanned book was not found in our database.',
          okButtonText: 'OK'
        });
      }
    } catch (error) {
      console.error('Error scanning barcode:', error);
      await alert({
        title: 'Scan Error',
        message: 'An error occurred while scanning the barcode. Please try again.',
        okButtonText: 'OK'
      });
    }
  }
}