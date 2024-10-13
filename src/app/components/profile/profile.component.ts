import { Component, OnInit } from '@angular/core';
import { UserService } from '../../services/user.service';
import { BookService } from '../../services/book.service';
import { GamificationService } from '../../services/gamification.service';
import { User } from '../../models/user';
import { Book } from '../../models/book';
import { Achievement } from '../../models/achievement';

@Component({
  selector: 'ns-profile',
  templateUrl: './profile.component.html',
})
export class ProfileComponent implements OnInit {
  user: User;
  favoriteBooks: Book[] = [];
  readingList: Book[] = [];
  achievements: Achievement[] = [];
  userPoints: number = 0;

  constructor(
    private userService: UserService,
    private bookService: BookService,
    private gamificationService: GamificationService
  ) {}

  ngOnInit(): void {
    this.user = this.userService.getCurrentUser();
    if (this.user) {
      this.favoriteBooks = this.bookService.getFavoriteBooks(this.user.id);
      this.readingList = this.bookService.getReadingList(this.user.id);
      this.loadAchievements();
      this.loadUserPoints();
    }
  }

  logout(): void {
    this.userService.logout();
    // Navigate to login page
  }

  private loadAchievements(): void {
    this.gamificationService.getAchievements().subscribe(
      (achievements) => {
        this.achievements = achievements;
      },
      (error) => {
        console.error('Error loading achievements:', error);
      }
    );
  }

  private loadUserPoints(): void {
    this.gamificationService.getUserPoints().subscribe(
      (points) => {
        this.userPoints = points;
      },
      (error) => {
        console.error('Error loading user points:', error);
      }
    );
  }
}