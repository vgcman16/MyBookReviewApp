export interface Achievement {
  id: string;
  title: string;
  description: string;
  points: number;
  isUnlocked: boolean;
}

export interface UserAchievement {
  userId: number;
  achievementId: string;
  dateUnlocked: Date;
}