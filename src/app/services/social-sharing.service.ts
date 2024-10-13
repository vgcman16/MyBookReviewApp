import { Injectable } from '@angular/core';
import { SocialShare } from '@nativescript/social-share';

@Injectable({
  providedIn: 'root',
})
export class SocialSharingService {
  shareText(text: string): void {
    SocialShare.shareText(text);
  }

  shareUrl(url: string, text?: string): void {
    SocialShare.shareUrl(url, text);
  }
}