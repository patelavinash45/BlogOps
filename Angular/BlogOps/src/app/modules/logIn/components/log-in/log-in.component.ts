import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { LogInService } from '../../service/log-in.service';
import { Router } from '@angular/router';
import { LogInResponseDto } from '../../../../Shared/interfaces/log-in-response-dto';
import { LogInRequestDto } from '../../../../Shared/interfaces/log-in-request-dto';


@Component({
  selector: 'app-log-in',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './log-in.component.html',
  styleUrl: './log-in.component.css'
})
export class LogInComponent {
  isShowPassword: boolean = false;
  loginForm!: FormGroup;

  constructor(private logInService: LogInService, private router: Router) { }

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      email: new FormControl('', [Validators.required, Validators.email]),
      password: new FormControl('', [Validators.required, Validators.minLength(8)]),
      keepMeSignIn: new FormControl(false, [Validators.required]),
    })
  }

  onPasswordButtonClick() {
    this.isShowPassword = !this.isShowPassword;
  }

  onFormSubmit() {
    if (this.loginForm.valid) {
      const logInRequestDto: LogInRequestDto = this.loginForm.value;
      this.logInService.LogIn(logInRequestDto).subscribe((response: LogInResponseDto) => {
        this.logInService.SetCookies(response,logInRequestDto.keepMeSignIn);
        this.router.navigate(['/author/dashboard']);
      })
    }
  }
}
