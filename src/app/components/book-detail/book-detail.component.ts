import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BookService } from '../../services/book.service';
import { UserService } from '../../services/user.service';
import { SocialSharingService } from '../../services/social-sharing.service';
import { NetworkService } from '../../services/network.service';
import { Book, BookReview } from '../../models/book';

@Component({
  selector: 'ns-book-detail',
  templateUrl: './book-detail.component.html',
})
export class BookDetailComponent implements OnInit {
  book: Book;
  reviews: BookReview[] = [];
  userRating: number = 0;
  userReview: string = '';
  isInFavorites: boolean = false;
  isInReadingList: boolean = false;
  isOffline: boolean = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private bookService: BookService,
    private userService: UserService,
    private socialSharingService: SocialSharingService,
    private networkService: NetworkService
  ) {}

  ngOnInit(): void {
    this.networkService.isConnected$.subscribe(isConnected => {
      this.isOffline = !isConnected;
    });

    const id = this.route.snapshot.params.id;
    this.bookService.getBookById(id).subscribe(
      (book) => {
        this.book = book;
        this.reviews = this.bookService.getBookReviews(id);
        this.checkBookStatus();
      },
      (error) => {
        console.error('Error fetching book details:', error);
      }
    );
  }

  // ... (keep other methods as they are)
}