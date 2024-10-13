import { Injectable } from '@angular/core';
import { UserService } from './user.service';
import { BookService } from './book.service';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ReadingInsightsService {
  constructor(
    private userService: UserService,
    private bookService: BookService
  ) {}

  getReadingStats(): Observable<any> {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      const readBooks = this.bookService.getReadBooks(currentUser.id);
      return readBooks.pipe(
        map(books => {
          const totalPages = books.reduce((sum, book) => sum + (book.pageCount || 0), 0);
          const averageRating = books.reduce((sum, book) => sum + (book.userRating || 0), 0) / books.length;

          return {
            booksRead: books.length,
            totalPages: totalPages,
            averageRating: averageRating.toFixed(1),
            favoriteGenre: this.getFavoriteGenre(books),
          };
        })
      );
    }
    return of(null);
  }

  getMonthlyReadCount(): Observable<any[]> {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      return this.bookService.getReadBooks(currentUser.id).pipe(
        map(books => {
          const monthlyCount = {};
          books.forEach(book => {
            const month = new Date(book.dateFinished).toLocaleString('default', { month: 'long' });
            monthlyCount[month] = (monthlyCount[month] || 0) + 1;
          });
          return Object.entries(monthlyCount).map(([month, count]) => ({ month, count }));
        })
      );
    }
    return of([]);
  }

  private getFavoriteGenre(books: any[]): string {
    const genreCounts = books.reduce((counts, book) => {
      if (book.categories) {
        book.categories.forEach((category: string) => {
          counts[category] = (counts[category] || 0) + 1;
        });
      }
      return counts;
    }, {});

    return Object.entries(genreCounts).reduce((a, b) => a[1] > b[1] ? a : b)[0];
  }
}