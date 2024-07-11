import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { CookieService } from 'ngx-cookie-service';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent {
  firstName!: string;
  lastName!: string;

  constructor(private cookieService: CookieService, private router: Router) { }

  ngOnInit(): void {
    this.firstName = this.cookieService.get('FirstName');
    this.lastName = this.cookieService.get('LastName');
  }

  onLogOutButtonClick() {
    this.cookieService.deleteAll('/', 'http://localhost:4200');
    this.router.navigate(['/login']);
  }
}
