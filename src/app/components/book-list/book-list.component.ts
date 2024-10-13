import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { BookService } from '../../services/book.service';
import { NetworkService } from '../../services/network.service';
import { Book } from '../../models/book';
import { ObservableArray } from '@nativescript/core';

@Component({
  selector: 'ns-book-list',
  templateUrl: './book-list.component.html',
})
export class BookListComponent implements OnInit {
  books: ObservableArray<Book> = new ObservableArray<Book>([]);
  searchQuery: string = '';
  isLoading: boolean = false;
  isOffline: boolean = false;

  constructor(
    private bookService: BookService,
    private router: Router,
    private networkService: NetworkService
  ) {}

  ngOnInit(): void {
    this.networkService.isConnected$.subscribe(isConnected => {
      this.isOffline = !isConnected;
    });
    this.searchBooks('bestsellers'); // Initial search for bestsellers
  }

  searchBooks(): void {
    if (this.searchQuery.trim()) {
      this.isLoading = true;
      this.bookService.searchBooks(this.searchQuery).subscribe(
        (books) => {
          this.books = new ObservableArray(books);
          this.isLoading = false;
        },
        (error) => {
          console.error('Error searching books:', error);
          this.isLoading = false;
        }
      );
    }
  }

  goToScanner(): void {
    this.router.navigate(['/barcode-scanner']);
  }

  onItemTap(args: any): void {
    const tappedItem = args.view.bindingContext;
    this.router.navigate(['/book', tappedItem.id]);
  }
}