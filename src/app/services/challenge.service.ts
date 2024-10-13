import { Injectable } from '@angular/core';
import { Challenge } from '../models/challenge';
import { UserService } from './user.service';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ChallengeService {
  private challenges: { [userId: number]: Challenge[] } = {};

  constructor(private userService: UserService) {}

  getChallenges(): Observable<Challenge[]> {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      return of(this.challenges[currentUser.id] || []);
    }
    return of([]);
  }

  addChallenge(challenge: Challenge): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      if (!this.challenges[currentUser.id]) {
        this.challenges[currentUser.id] = [];
      }
      this.challenges[currentUser.id].push(challenge);
    }
  }

  updateChallengeProgress(challengeId: string, progress: number): void {
    const currentUser = this.userService.getCurrentUser();
    if (currentUser) {
      const challenge = this.challenges[currentUser.id].find(c => c.id === challengeId);
      if (challenge) {
        challenge.currentProgress = progress;
        challenge.isCompleted = progress >= challenge.goal;
      }
    }
  }
}