import { Component, OnInit } from '@angular/core';
import { BookQuotesService } from '../../services/book-quotes.service';
import { SocialSharingService } from '../../services/social-sharing.service';
import { ObservableArray } from '@nativescript/core';

@Component({
  selector: 'ns-book-quotes',
  templateUrl: './book-quotes.component.html',
})
export class BookQuotesComponent implements OnInit {
  quotes: ObservableArray<any>;
  newQuote: string = '';
  newBook: string = '';

  constructor(
    private bookQuotesService: BookQuotesService,
    private socialSharingService: SocialSharingService
  ) {}

  ngOnInit() {
    this.loadQuotes();
  }

  loadQuotes() {
    this.bookQuotesService.getQuotes().subscribe(
      (quotes) => {
        this.quotes = new ObservableArray(quotes);
      },
      (error) => {
        console.error('Error loading quotes:', error);
      }
    );
  }

  addQuote() {
    if (this.newQuote && this.newBook) {
      this.bookQuotesService.addQuote(this.newQuote, this.newBook).subscribe(
        () => {
          this.loadQuotes();
          this.newQuote = '';
          this.newBook = '';
        },
        (error) => {
          console.error('Error adding quote:', error);
        }
      );
    }
  }

  shareQuote(quote: any) {
    const shareText = `"${quote.text}" - ${quote.book}`;
    this.socialSharingService.shareText(shareText);
  }
}