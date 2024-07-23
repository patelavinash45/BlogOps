import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { LogInService } from '../../service/log-in.service';
import { Router } from '@angular/router';
import { LogInResponseDto } from '../../../../shared/interfaces/log-in-response-dto';
import { LogInRequestDto } from '../../../../shared/interfaces/log-in-request-dto';
import { ManageToastrService } from '../../../../core/service/manage-toastr.service';
import { LogInSuccessMessage } from '../../../../shared/constants/constant';
import { RoleType } from '../../../../shared/enums/role-type';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-log-in',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, MatButtonModule],
  templateUrl: './log-in.component.html',
  styleUrl: './log-in.component.css'
})
export class LogInComponent {
  isShowPassword: boolean = false;
  loginForm!: FormGroup;

  constructor(private logInService: LogInService, private router: Router, private toastr: ManageToastrService) { }

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      email: new FormControl('', [Validators.required, Validators.email]),
      password: new FormControl('', [Validators.required, Validators.minLength(8)]),
      keepMeSignIn: new FormControl(false, [Validators.required]),
    });
  }

  onPasswordButtonClick() {
    this.isShowPassword = !this.isShowPassword;
  }

  onFormSubmit() {
    if (this.loginForm.valid) {
      const logInRequestDto: LogInRequestDto = this.loginForm.value;
      this.logInService.LogIn(logInRequestDto).subscribe((response: LogInResponseDto) => {
        this.toastr.ShowSuccess(LogInSuccessMessage);
        this.logInService.SetCookies(response, logInRequestDto.keepMeSignIn);
        if(response.roleType == RoleType.Author)
        {
          this.router.navigate(['/author/dashboard']);
        }
        else
        {
          this.router.navigate(['/admin/dashboard']);
        }
      })
    }else{
      this.loginForm.markAllAsTouched();
    }
  }
}
