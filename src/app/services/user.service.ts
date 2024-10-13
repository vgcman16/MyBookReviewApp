import { Injectable } from '@angular/core';
import { User } from '../models/user';
import { Observable, of } from 'rxjs';
import { delay } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private users: User[] = [
    { id: 1, username: 'john_doe', email: 'john@example.com', password: 'password123' },
    { id: 2, username: 'jane_smith', email: 'jane@example.com', password: 'password456' },
  ];

  private currentUser: User | null = null;

  constructor() {}

  login(username: string, password: string): Observable<boolean> {
    const user = this.users.find(u => u.username === username && u.password === password);
    if (user) {
      this.currentUser = user;
      return of(true).pipe(delay(1000)); // Simulate network delay
    }
    return of(false).pipe(delay(1000));
  }

  logout(): void {
    this.currentUser = null;
  }

  getCurrentUser(): User | null {
    return this.currentUser;
  }

  isLoggedIn(): boolean {
    return this.currentUser !== null;
  }

  register(username: string, email: string, password: string): Observable<boolean> {
    if (this.users.some(u => u.username === username || u.email === email)) {
      return of(false).pipe(delay(1000));
    }
    const newUser: User = {
      id: this.users.length + 1,
      username,
      email,
      password
    };
    this.users.push(newUser);
    this.currentUser = newUser;
    return of(true).pipe(delay(1000));
  }
}