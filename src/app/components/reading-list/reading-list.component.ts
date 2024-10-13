import { Component, OnInit } from '@angular/core';
import { BookService } from '../../services/book.service';
import { UserService } from '../../services/user.service';
import { Book } from '../../models/book';

@Component({
  selector: 'ns-reading-list',
  templateUrl: './reading-list.component.html',
})
export class ReadingListComponent implements OnInit {
  readingList: Book[] = [];

  constructor(
    private bookService: BookService,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      this.readingList = this.bookService.getReadingList(currentUser.id);
    }
  }

  removeFromReadingList(book: Book): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      this.bookService.removeFromReadingList(currentUser.id, book.id);
      this.readingList = this.readingList.filter(b => b.id !== book.id);
    }
  }
}