import { Component, OnInit } from '@angular/core';
import { ReadingInsightsService } from '../../services/reading-insights.service';
import { ObservableArray } from '@nativescript/core';

@Component({
  selector: 'ns-reading-insights',
  templateUrl: './reading-insights.component.html',
})
export class ReadingInsightsComponent implements OnInit {
  readingStats: any;
  monthlyReadCount: ObservableArray<any>;

  constructor(private readingInsightsService: ReadingInsightsService) {}

  ngOnInit() {
    this.loadReadingStats();
    this.loadMonthlyReadCount();
  }

  loadReadingStats() {
    this.readingInsightsService.getReadingStats().subscribe(
      (stats) => {
        this.readingStats = stats;
      },
      (error) => {
        console.error('Error loading reading stats:', error);
      }
    );
  }

  loadMonthlyReadCount() {
    this.readingInsightsService.getMonthlyReadCount().subscribe(
      (data) => {
        this.monthlyReadCount = new ObservableArray(data);
      },
      (error) => {
        console.error('Error loading monthly read count:', error);
      }
    );
  }
}