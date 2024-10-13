import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { map, tap, catchError, switchMap } from 'rxjs/operators';
import { Book, BookReview } from '../models/book';
import { OfflineService } from './offline.service';
import { NetworkService } from './network.service';

@Injectable({
  providedIn: 'root',
})
export class BookService {
  private apiKey = 'AIzaSyBszXDXhqmm2yxPoGlG11Ie6MRQlcnkgYU';
  private apiUrl = 'https://www.googleapis.com/books/v1/volumes';

  constructor(
    private http: HttpClient,
    private offlineService: OfflineService,
    private networkService: NetworkService
  ) {}

  // ... (keep existing methods)

  getRecommendations(userId: number): Observable<Book[]> {
    // In a real app, this would use a more sophisticated recommendation algorithm
    // For now, we'll return a mix of popular books and books similar to the user's reading history
    return this.getReadBooks(userId).pipe(
      switchMap(readBooks => {
        const genres = this.extractGenres(readBooks);
        return this.searchBooks(genres.join(' OR ')).pipe(
          map(books => books.filter(book => !readBooks.some(rb => rb.id === book.id)).slice(0, 10))
        );
      })
    );
  }

  private extractGenres(books: Book[]): string[] {
    const genreSet = new Set<string>();
    books.forEach(book => {
      if (book.categories) {
        book.categories.forEach(category => genreSet.add(category));
      }
    });
    return Array.from(genreSet);
  }

  // Add this method to get books read by a user
  getReadBooks(userId: number): Observable<Book[]> {
    // In a real app, this would fetch from a backend API
    // For now, we'll return some mock data
    const mockReadBooks: Book[] = [
      {
        id: '1',
        title: 'To Kill a Mockingbird',
        author: 'Harper Lee',
        description: 'A classic of modern American literature',
        thumbnail: 'https://example.com/mockingbird.jpg',
        categories: ['Fiction', 'Classic'],
      },
      {
        id: '2',
        title: '1984',
        author: 'George Orwell',
        description: 'A dystopian social science fiction novel',
        thumbnail: 'https://example.com/1984.jpg',
        categories: ['Science Fiction', 'Dystopian'],
      },
    ];
    return of(mockReadBooks);
  }
}