import { Component } from '@angular/core';
import { ManageCookieService } from '../../../core/service/manage-cookie.service';
import { Router } from '@angular/router';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-access-denied',
  standalone: true,
  imports: [MatButtonModule],
  templateUrl: './access-denied.component.html',
  styleUrl: './access-denied.component.css'
})
export class AccessDeniedComponent {
  constructor(private cookieService:ManageCookieService,private route:Router){ }

  onHomeButtonClick(){
    const roleType = this.cookieService.GetRoleType();
    if(roleType == '1'){
      this.route.navigate(['/admin/dashboard']);
    }
    else{
      this.route.navigate(['/author/dashboard']);
    }
  }
}
