import { Component } from '@angular/core';
import { Router, RouterOutlet } from '@angular/router';
import { ManageCookieService } from '../../../core/service/manage-cookie.service';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { map, Observable, shareReplay } from 'rxjs';
import { AsyncPipe } from '@angular/common';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [
    RouterOutlet,
    MatToolbarModule,
    MatButtonModule,
    MatSidenavModule,
    MatListModule,
    MatIconModule,
    AsyncPipe
  ],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent {
  firstName!: string;
  lastName!: string;

  constructor(private manageCookieService: ManageCookieService, private router: Router, private breakObserver: BreakpointObserver) { }

  isHandSet$: Observable<boolean> = this.breakObserver.observe(Breakpoints.Handset).pipe(
    map(result => result.matches),
    shareReplay()
  )

  ngOnInit(): void {
    this.firstName = this.manageCookieService.GetFirstName();
    this.lastName = this.manageCookieService.GetLastName();
  }

  onLogOutButtonClick() {
    this.manageCookieService.RemoveAllCookie();
  }
}
