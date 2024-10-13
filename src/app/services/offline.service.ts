import { Injectable } from '@angular/core';
import { Book, BookReview } from '../models/book';

@Injectable({
  providedIn: 'root',
})
export class OfflineService {
  private cachedBooks: { [id: string]: Book } = {};
  private favoriteBooks: { [userId: number]: string[] } = {};
  private readingLists: { [userId: number]: string[] } = {};
  private readingProgress: { [userId: number]: { [bookId: string]: number } } = {};
  private bookReviews: { [bookId: string]: BookReview[] } = {};

  constructor() {
    this.loadFromStorage();
  }

  cacheBook(book: Book): void {
    this.cachedBooks[book.id] = book;
    this.saveToStorage();
  }

  getCachedBook(id: string): Book | undefined {
    return this.cachedBooks[id];
  }

  getAllBooks(): Book[] {
    return Object.values(this.cachedBooks);
  }

  searchCachedBooks(query: string): Book[] {
    const lowercaseQuery = query.toLowerCase();
    return this.getAllBooks().filter(book => 
      book.title.toLowerCase().includes(lowercaseQuery) ||
      book.author.toLowerCase().includes(lowercaseQuery)
    );
  }

  // ... (keep other methods as they are)

  private saveToStorage(): void {
    localStorage.setItem('cachedBooks', JSON.stringify(this.cachedBooks));
    localStorage.setItem('favoriteBooks', JSON.stringify(this.favoriteBooks));
    localStorage.setItem('readingLists', JSON.stringify(this.readingLists));
    localStorage.setItem('readingProgress', JSON.stringify(this.readingProgress));
    localStorage.setItem('bookReviews', JSON.stringify(this.bookReviews));
  }

  private loadFromStorage(): void {
    const cachedBooks = localStorage.getItem('cachedBooks');
    if (cachedBooks) {
      this.cachedBooks = JSON.parse(cachedBooks);
    }

    const favoriteBooks = localStorage.getItem('favoriteBooks');
    if (favoriteBooks) {
      this.favoriteBooks = JSON.parse(favoriteBooks);
    }

    const readingLists = localStorage.getItem('readingLists');
    if (readingLists) {
      this.readingLists = JSON.parse(readingLists);
    }

    const readingProgress = localStorage.getItem('readingProgress');
    if (readingProgress) {
      this.readingProgress = JSON.parse(readingProgress);
    }

    const bookReviews = localStorage.getItem('bookReviews');
    if (bookReviews) {
      this.bookReviews = JSON.parse(bookReviews);
    }
  }
}