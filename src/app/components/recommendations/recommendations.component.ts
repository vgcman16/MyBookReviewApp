import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { BookService } from '../../services/book.service';
import { UserService } from '../../services/user.service';
import { Book } from '../../models/book';
import { ObservableArray } from '@nativescript/core';

@Component({
  selector: 'ns-recommendations',
  templateUrl: './recommendations.component.html',
})
export class RecommendationsComponent implements OnInit {
  recommendations: ObservableArray<Book> = new ObservableArray<Book>([]);
  isLoading: boolean = false;

  constructor(
    private bookService: BookService,
    private userService: UserService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loadRecommendations();
  }

  loadRecommendations(): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      this.isLoading = true;
      this.bookService.getRecommendations(currentUser.id).subscribe(
        (books) => {
          this.recommendations = new ObservableArray(books);
          this.isLoading = false;
        },
        (error) => {
          console.error('Error loading recommendations:', error);
          this.isLoading = false;
        }
      );
    } else {
      this.router.navigate(['/login']);
    }
  }

  addToReadingList(book: Book): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      this.bookService.addToReadingList(currentUser.id, book);
      // Remove the book from recommendations after adding to reading list
      this.recommendations = this.recommendations.filter(b => b.id !== book.id);
    }
  }

  onItemTap(args: any): void {
    const tappedItem = args.view.bindingContext;
    this.router.navigate(['/book', tappedItem.id]);
  }
}