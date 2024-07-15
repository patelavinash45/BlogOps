import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ManageCookieService } from '../../../core/service/manage-cookie.service';

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

  constructor(private manageCookieService: ManageCookieService, private router: Router) { }

  ngOnInit(): void {
    this.firstName = this.manageCookieService.GetFirstName();
    this.lastName = this.manageCookieService.GetLastName();
  }

  onLogOutButtonClick() {
    this.manageCookieService.RemoveAllCookie();
  }
}
