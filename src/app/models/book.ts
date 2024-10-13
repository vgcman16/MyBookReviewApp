export interface Book {
  id: string;
  title: string;
  author: string;
  description: string;
  thumbnail: string;
  averageRating?: number;
}

export interface BookReview extends Book {
  userId: number;
  userRating: number;
  userReview: string;
}