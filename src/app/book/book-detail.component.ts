import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { Book } from './book';
import { BookService } from './book.service';

@Component({
  selector: 'ns-book-detail',
  templateUrl: './book-detail.component.html',
})
export class BookDetailComponent implements OnInit {
  book: Book;

  constructor(
    private bookService: BookService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    const id = +this.route.snapshot.params.id;
    this.book = this.bookService.getBook(id);
  }
}