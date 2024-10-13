import { Injectable } from '@angular/core';
import { UserService } from './user.service';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class BookQuotesService {
  private quotes: { [userId: number]: any[] } = {};

  constructor(private userService: UserService) {}

  getQuotes(): Observable<any[]> {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      return of(this.quotes[currentUser.id] || []);
    }
    return of([]);
  }

  addQuote(text: string, book: string): Observable<void> {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      if (!this.quotes[currentUser.id]) {
        this.quotes[currentUser.id] = [];
      }
      this.quotes[currentUser.id].push({ text, book, date: new Date() });
      return of(void 0);
    }
    return of(void 0);
  }
}