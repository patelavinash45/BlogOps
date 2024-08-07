import { Component } from '@angular/core';
import { Router, RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';
import { ManageCookieService } from '../../../core/service/manage-cookie.service';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { map, Observable, shareReplay } from 'rxjs';
import { AsyncPipe, CommonModule } from '@angular/common';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatMenuModule } from '@angular/material/menu';
import { adminSideBarItems, authorSideBarItems, largeDisplay } from '../../../shared/constants/constant';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    RouterLinkActive,
    RouterOutlet,
    MatToolbarModule,
    MatButtonModule,
    MatSidenavModule,
    MatListModule,
    MatIconModule,
    MatButtonModule,
    MatMenuModule,
    AsyncPipe
  ],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent {
  profileName!: string;
  roleType!: string;
  isUpArrow: boolean = true;
  sideNavItems!: string[][];

  constructor(private manageCookieService: ManageCookieService, private breakObserver: BreakpointObserver, private router: Router) { }

  isLargeDisplay$: Observable<boolean> = this.breakObserver.observe(largeDisplay).pipe(
    map(result => result.matches),
    shareReplay()
  );

  isSmallDisplay$: Observable<boolean> = this.breakObserver.observe(Breakpoints.XSmall).pipe(
    map(result => result.matches),
    shareReplay()
  );

  ngOnInit(): void {
    this.profileName = this.manageCookieService.GetProfileName();
    this.roleType = this.manageCookieService.GetRoleType();
    if (this.roleType == '1') {
      this.sideNavItems = adminSideBarItems;
    }
    else {
      this.sideNavItems = authorSideBarItems;
    }
  }

  onLogOutButtonClick() {
    this.manageCookieService.RemoveAllCookie();
  }

  onLogoImageClick() {
    this.router.navigate([this.sideNavItems[0][1]]);
  }
}
