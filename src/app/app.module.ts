import { NgModule, NO_ERRORS_SCHEMA } from '@angular/core';
import { NativeScriptModule } from '@nativescript/angular';
import { NativeScriptFormsModule } from '@nativescript/angular';
import { NativeScriptHttpClientModule } from '@nativescript/angular';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
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

import { BookService } from './services/book.service';
import { UserService } from './services/user.service';
import { OfflineService } from './services/offline.service';
import { BarcodeScannerService } from './services/barcode-scanner.service';
import { SocialSharingService } from './services/social-sharing.service';
import { ChallengeService } from './services/challenge.service';
import { BookClubService } from './services/book-club.service';
import { ReadingInsightsService } from './services/reading-insights.service';
import { BookQuotesService } from './services/book-quotes.service';

@NgModule({
  bootstrap: [AppComponent],
  imports: [
    NativeScriptModule,
    NativeScriptFormsModule,
    NativeScriptHttpClientModule,
    AppRoutingModule
  ],
  declarations: [
    AppComponent,
    BookListComponent,
    BookDetailComponent,
    LoginComponent,
    ProfileComponent,
    ReadingListComponent,
    RecommendationsComponent,
    BarcodeScannerComponent,
    ReadingProgressComponent,
    ChallengesComponent,
    BookClubsComponent,
    ReadingInsightsComponent,
    BookQuotesComponent
  ],
  providers: [
    BookService,
    UserService,
    OfflineService,
    BarcodeScannerService,
    SocialSharingService,
    ChallengeService,
    BookClubService,
    ReadingInsightsService,
    BookQuotesService
  ],
  schemas: [NO_ERRORS_SCHEMA],
})
export class AppModule {}