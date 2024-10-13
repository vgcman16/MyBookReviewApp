import { Component, OnInit } from '@angular/core';
import { BookClubService } from '../../services/book-club.service';
import { BookClub } from '../../models/book-club';

@Component({
  selector: 'ns-book-clubs',
  templateUrl: './book-clubs.component.html',
})
export class BookClubsComponent implements OnInit {
  bookClubs: BookClub[] = [];
  newClub: BookClub = {
    id: '',
    name: '',
    description: '',
    members: [],
    currentBook: '',
    meetingSchedule: '',
  };

  constructor(private bookClubService: BookClubService) {}

  ngOnInit() {
    this.loadBookClubs();
  }

  loadBookClubs() {
    this.bookClubService.getBookClubs().subscribe(
      (clubs) => {
        this.bookClubs = clubs;
      },
      (error) => {
        console.error('Error loading book clubs:', error);
      }
    );
  }

  createBookClub() {
    this.newClub.id = Date.now().toString();
    this.bookClubService.createBookClub(this.newClub);
    this.loadBookClubs();
    this.resetNewClub();
  }

  joinBookClub(clubId: string) {
    this.bookClubService.joinBookClub(clubId);
    this.loadBookClubs();
  }

  private resetNewClub() {
    this.newClub = {
      id: '',
      name: '',
      description: '',
      members: [],
      currentBook: '',
      meetingSchedule: '',
    };
  }
}