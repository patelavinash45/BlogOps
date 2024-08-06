import { Component } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { ActivatedRoute } from '@angular/router';
import { LogInService } from '../../service/log-in.service';
import { UserDto } from '../../../../shared/interfaces/user-dto';
import { ManageToastrService } from '../../../../core/service/manage-toastr.service';

@Component({
  selector: 'app-email-verify',
  standalone: true,
  imports: [MatButtonModule],
  templateUrl: './email-verify.component.html',
  styleUrl: './email-verify.component.css'
})
export class EmailVerifyComponent {
  token!: string;
  user!: UserDto;

  constructor(private route: ActivatedRoute, private logInService: LogInService, private toasterService: ManageToastrService) { }

  ngOnInit(): void {
    this.token = this.route.snapshot.params['token'];
    this.logInService.GetUserDetails(this.token).subscribe({
      next: (response) => {
        this.user = response;
      }
    });
  }

  onButtonClick() {
    
    // this.logInService.VerifyEmail(this.user.id, this.token).subscribe({
    //   next: (response) => {

    //    }
    // });
  }

}
