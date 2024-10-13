import { Component, OnInit, inject } from '@angular/core'
import { Page } from '@nativescript/core'

import { Book } from './book'
import { BookService } from './book.service'

@Component({
  selector: 'ns-books',
  templateUrl: './book-list.component.html',
})
export class BookListComponent implements OnInit {
  page = inject(Page);
  bookService = inject(BookService);
  books: Array<Book>;

  constructor() {
    this.page.on('loaded', (args) => {
      if (__IOS__) {
        const navigationController: UINavigationController =
          this.page.frame.ios.controller;
        navigationController.navigationBar.prefersLargeTitles = true;
      }
    });
  }

  ngOnInit(): void {
    this.books = this.bookService.getBooks()
  }
}