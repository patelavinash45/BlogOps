import { Component } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { ActivatedRoute, Router } from '@angular/router';
import { LogInService } from '../../service/log-in.service';
import { UserDto } from '../../../../shared/interfaces/user-dto';
import { ManageToastrService } from '../../../../core/service/manage-toastr.service';
import { AccountVerify, EmailVerifyText1, EmailVerifyText2 } from '../../../../shared/constants/constant';
import { RoutePathConstant } from '../../../../shared/constants/route-path.constant';
import { finalize } from 'rxjs';

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
  isVerified: boolean = false;
  isButtonClick: boolean = false;
  text1: string = EmailVerifyText1;
  text2: string = EmailVerifyText2;

  constructor(private route: ActivatedRoute, private logInService: LogInService, private toasterService: ManageToastrService, private router: Router) { }

  ngOnInit(): void {
    this.token = this.route.snapshot.params['token'];
    this.logInService.GetUserDetails(this.token).subscribe({
      next: (response) => {
        this.user = response;
      }
    });
  }

  onButtonClick() {
    this.isButtonClick = true;
    this.logInService.VerifyEmail(this.user.id, this.token).pipe(
      finalize(() => this.isButtonClick = false),
    ).subscribe({
      next: () => {
        this.toasterService.ShowSuccess(AccountVerify);
        this.isVerified = true;
      }
    });
  }

  onAnimationend() {
    this.router.navigate([RoutePathConstant.LogInPath]);
  }

}
