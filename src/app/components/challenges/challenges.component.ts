import { Component, OnInit } from '@angular/core';
import { ChallengeService } from '../../services/challenge.service';
import { Challenge } from '../../models/challenge';

@Component({
  selector: 'ns-challenges',
  templateUrl: './challenges.component.html',
})
export class ChallengesComponent implements OnInit {
  challenges: Challenge[] = [];
  newChallenge: Challenge = {
    id: '',
    title: '',
    description: '',
    goal: 0,
    currentProgress: 0,
    startDate: new Date(),
    endDate: new Date(),
    isCompleted: false,
  };

  constructor(private challengeService: ChallengeService) {}

  ngOnInit() {
    this.loadChallenges();
  }

  loadChallenges() {
    this.challengeService.getChallenges().subscribe(
      (challenges) => {
        this.challenges = challenges;
      },
      (error) => {
        console.error('Error loading challenges:', error);
      }
    );
  }

  addChallenge() {
    this.newChallenge.id = Date.now().toString();
    this.challengeService.addChallenge(this.newChallenge);
    this.loadChallenges();
    this.resetNewChallenge();
  }

  updateProgress(challenge: Challenge) {
    this.challengeService.updateChallengeProgress(challenge.id, challenge.currentProgress);
  }

  private resetNewChallenge() {
    this.newChallenge = {
      id: '',
      title: '',
      description: '',
      goal: 0,
      currentProgress: 0,
      startDate: new Date(),
      endDate: new Date(),
      isCompleted: false,
    };
  }
}