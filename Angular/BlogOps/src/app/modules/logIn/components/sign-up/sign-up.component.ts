import { Component } from '@angular/core';
import { ValidationMessageComponent } from "../../../../components/base/validation-message/validation-message.component";
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { LogInService } from '../../service/log-in.service';
import { CreateUserRequestDto } from '../../../../shared/interfaces/create-user-request-dto';
import { RoleType } from '../../../../shared/enums/role-type';
import { UserStatus } from '../../../../shared/enums/user-status';
import { Router, RouterLink } from '@angular/router';
import { finalize } from 'rxjs';
import { ManageToastrService } from '../../../../core/service/manage-toastr.service';
import { AccountCreated } from '../../../../shared/constants/constant';

@Component({
  selector: 'app-sign-up',
  standalone: true,
  imports: [
    CommonModule,
    ValidationMessageComponent,
    ReactiveFormsModule,
    MatButtonModule,
    RouterLink,
  ],
  templateUrl: './sign-up.component.html',
  styleUrl: './sign-up.component.css'
})
export class SignUpComponent {
  signUpForm!: FormGroup;
  isShowPassword: boolean = false;
  isShowConformPassword: boolean = false;
  isButtonClick: boolean = false;

  constructor(private logInService: LogInService, private router: Router, private toasterService: ManageToastrService) { }

  ngOnInit(): void {
    this.signUpForm = new FormGroup({
      firstName: new FormControl('', [Validators.required]),
      lastName: new FormControl('', [Validators.required]),
      email: new FormControl('', [Validators.required, Validators.email]),
      password: new FormControl('', [Validators.required, Validators.minLength(8)]),
      conformPassword: new FormControl('', [Validators.required]),
    });
  }

  onPasswordButtonClick() {
    this.isShowPassword = !this.isShowPassword;
  }

  onConformPasswordPasswordButtonClick() {
    this.isShowConformPassword = !this.isShowConformPassword;
  }

  onFormSubmit() {
    if (this.signUpForm.valid) {
      this.isButtonClick = true;
      const createUserRequestDto: CreateUserRequestDto = {
        firstName: this.signUpForm.controls['firstName'].value,
        lastName: this.signUpForm.controls['lastName'].value,
        email: this.signUpForm.controls['email'].value,
        password: this.signUpForm.controls['password'].value,
        profileName: null,
        role: RoleType.Author,
        status: UserStatus.DeActive,
      };
      this.logInService.SignUp(createUserRequestDto).pipe(
        finalize(() => {
          this.isButtonClick = false;
        })
      ).subscribe({
        next: (response) => {
          this.toasterService.ShowSuccess(AccountCreated);
          this.router.navigate(['account/login']);
        },
      })
    }
    else {
      this.signUpForm.markAllAsTouched();
    }
  }
}
