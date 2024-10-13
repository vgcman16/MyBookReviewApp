import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BookService } from '../../services/book.service';
import { UserService } from '../../services/user.service';
import { Book } from '../../models/book';

@Component({
  selector: 'ns-reading-progress',
  templateUrl: './reading-progress.component.html',
})
export class ReadingProgressComponent implements OnInit {
  book: Book;
  progress: number = 0;

  constructor(
    private route: ActivatedRoute,
    private bookService: BookService,
    private userService: UserService
  ) {}

  ngOnInit() {
    const bookId = this.route.snapshot.params.id;
    this.bookService.getBookById(bookId).subscribe((book) => {
      this.book = book;
      this.loadProgress();
    });
  }

  loadProgress() {
    const user = this.userService.getCurrentUser();
    if (user) {
      this.progress = this.bookService.getReadingProgress(user.id, this.book.id);
    }
  }

  updateProgress() {
    const user = this.userService.getCurrentUser();
    if (user) {
      this.bookService.updateReadingProgress(user.id, this.book.id, this.progress);
    }
  }
}