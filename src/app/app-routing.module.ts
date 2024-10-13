import { NgModule } from '@angular/core';
import { Routes } from '@angular/router';
import { NativeScriptRouterModule } from '@nativescript/angular';

import { BookListComponent } from './components/book-list/book-list.component';
import { BookDetailComponent } from './components/book-detail/book-detail.component';
import { LoginComponent } from './components/login/login.component';
import { ProfileComponent } from './components/profile/profile.component';
import { ReadingListComponent } from './components/reading-list/reading-list.component';
import { RecommendationsComponent } from './components/recommendations/recommendations.component';
import { BarcodeScannerComponent } from './components/barcode-scanner/barcode-scanner.component';
import { ReadingProgressComponent } from './components/reading-progress/reading-progress.component';
import { ChallengesComponent } from './components/challenges/challenges.component';
import { BookClubsComponent } from './components/book-clubs/book-clubs.component';
import { ReadingInsightsComponent } from './components/reading-insights/reading-insights.component';
import { BookQuotesComponent } from './components/book-quotes/book-quotes.component';

const routes: Routes = [
  { path: '', redirectTo: '/(searchTab:books//readingListTab:reading-list//recommendationsTab:recommendations//profileTab:profile//challengesTab:challenges//bookClubsTab:book-clubs//insightsTab:reading-insights//quotesTab:book-quotes)', pathMatch: 'full' },
  { path: 'books', component: BookListComponent, outlet: 'searchTab' },
  { path: 'reading-list', component: ReadingListComponent, outlet: 'readingListTab' },
  { path: 'recommendations', component: RecommendationsComponent, outlet: 'recommendationsTab' },
  { path: 'profile', component: ProfileComponent, outlet: 'profileTab' },
  { path: 'challenges', component: ChallengesComponent, outlet: 'challengesTab' },
  { path: 'book-clubs', component: BookClubsComponent, outlet: 'bookClubsTab' },
  { path: 'reading-insights', component: ReadingInsightsComponent, outlet: 'insightsTab' },
  { path: 'book-quotes', component: BookQuotesComponent, outlet: 'quotesTab' },
  { path: 'book/:id', component: BookDetailComponent },
  { path: 'login', component: LoginComponent },
  { path: 'barcode-scanner', component: BarcodeScannerComponent },
  { path: 'reading-progress/:id', component: ReadingProgressComponent },
];

@NgModule({
  imports: [NativeScriptRouterModule.forRoot(routes)],
  exports: [NativeScriptRouterModule],
})
export class AppRoutingModule {}