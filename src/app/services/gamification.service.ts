import { Injectable } from '@angular/core';
import { UserService } from './user.service';
import { Achievement, UserAchievement } from '../models/achievement';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class GamificationService {
  private achievements: Achievement[] = [
    { id: 'first_book', title: 'First Steps', description: 'Read your first book', points: 10, isUnlocked: false },
    { id: 'five_books', title: 'Bookworm', description: 'Read 5 books', points: 50, isUnlocked: false },
    { id: 'ten_reviews', title: 'Critic', description: 'Write 10 book reviews', points: 100, isUnlocked: false },
    // Add more achievements as needed
  ];

  private userAchievements: { [userId: number]: UserAchievement[] } = {};
  private userPoints: { [userId: number]: number } = {};

  constructor(private userService: UserService) {}

  getAchievements(): Observable<Achievement[]> {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      const userAchievements = this.userAchievements[currentUser.id] || [];
      return of(this.achievements.map(achievement => ({
        ...achievement,
        isUnlocked: userAchievements.some(ua => ua.achievementId === achievement.id)
      })));
    }
    return of([]);
  }

  getUserPoints(): Observable<number> {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      return of(this.userPoints[currentUser.id] || 0);
    }
    return of(0);
  }

  unlockAchievement(achievementId: string): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      const achievement = this.achievements.find(a => a.id === achievementId);
      if (achievement && !this.isAchievementUnlocked(achievementId)) {
        if (!this.userAchievements[currentUser.id]) {
          this.userAchievements[currentUser.id] = [];
        }
        this.userAchievements[currentUser.id].push({
          userId: currentUser.id,
          achievementId: achievementId,
          dateUnlocked: new Date()
        });
        this.addPoints(achievement.points);
      }
    }
  }

  private isAchievementUnlocked(achievementId: string): boolean {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      const userAchievements = this.userAchievements[currentUser.id] || [];
      return userAchievements.some(ua => ua.achievementId === achievementId);
    }
    return false;
  }

  private addPoints(points: number): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      if (!this.userPoints[currentUser.id]) {
        this.userPoints[currentUser.id] = 0;
      }
      this.userPoints[currentUser.id] += points;
    }
  }
}