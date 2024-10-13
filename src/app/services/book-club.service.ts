import { Injectable } from '@angular/core';
import { BookClub } from '../models/book-club';
import { UserService } from './user.service';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class BookClubService {
  private bookClubs: BookClub[] = [];

  constructor(private userService: UserService) {}

  getBookClubs(): Observable<BookClub[]> {
    return of(this.bookClubs);
  }

  createBookClub(bookClub: BookClub): void {
    this.bookClubs.push(bookClub);
  }

  joinBookClub(clubId: string): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      const club = this.bookClubs.find(c => c.id === clubId);
      if (club && !club.members.includes(currentUser.id.toString())) {
        club.members.push(currentUser.id.toString());
      }
    }
  }
}