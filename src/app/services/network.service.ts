import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject } from 'rxjs';
import { connectivity } from '@nativescript/core';

@Injectable({
  providedIn: 'root',
})
export class NetworkService {
  private connectionType = new BehaviorSubject<connectivity.connectionType>(connectivity.getConnectionType());

  constructor() {
    connectivity.startMonitoring((newConnectionType: connectivity.connectionType) => {
      this.connectionType.next(newConnectionType);
    });
  }

  get isConnected$(): Observable<boolean> {
    return new Observable<boolean>((observer) => {
      this.connectionType.subscribe((type) => {
        observer.next(type !== connectivity.connectionType.none);
      });
    });
  }

  get currentConnectionType$(): Observable<connectivity.connectionType> {
    return this.connectionType.asObservable();
  }
}