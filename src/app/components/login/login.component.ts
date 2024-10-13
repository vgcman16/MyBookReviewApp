import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'ns-login',
  templateUrl: './login.component.html',
})
export class LoginComponent {
  username: string = '';
  password: string = '';
  isLoading: boolean = false;
  errorMessage: string = '';

  constructor(private userService: UserService, private router: Router) {}

  login(): void {
    this.isLoading = true;
    this.errorMessage = '';

    this.userService.login(this.username, this.password).subscribe(
      (success) => {
        this.isLoading = false;
        if (success) {
          this.router.navigate(['/books']);
        } else {
          this.errorMessage = 'Invalid username or password';
        }
      },
      (error) => {
        this.isLoading = false;
        this.errorMessage = 'An error occurred. Please try again.';
      }
    );
  }
}