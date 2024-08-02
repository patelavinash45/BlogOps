import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { UserService } from '../../../service/user.service';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { ValidationMessageComponent } from "../../../../../components/base/validation-message/validation-message.component";
import { finalize } from 'rxjs';

@Component({
  selector: 'app-add-edit-user',
  standalone: true,
  imports: [
    CommonModule,
    MatButtonModule,
    ReactiveFormsModule,
    ValidationMessageComponent,
    RouterLink,
  ],
  templateUrl: './add-edit-user.component.html',
  styleUrl: './add-edit-user.component.css'
})
export class AddEditUserComponent {
  email!: string;
  isShowPassword: boolean = false;
  createUserForm!: FormGroup;
  userId!: number;
  isEmailExist: boolean = false;
  isButtonClick: boolean = false;

  constructor(private router: Router, private route: ActivatedRoute, private userService: UserService) {
    this.userId = this.route.snapshot.params['userId'];
    this.createUserForm = new FormGroup({
      firstName: new FormControl("", [Validators.required, Validators.maxLength(48)]),
      lastName: new FormControl("", [Validators.required, Validators.maxLength(48)]),
      profileName: new FormControl("", [Validators.maxLength(48)]),
      email: new FormControl("", [Validators.required, Validators.email, Validators.maxLength(256)]),
      password: new FormControl("", [Validators.required, Validators.maxLength(8)]),
      role: new FormControl("", [Validators.required]),
      status: new FormControl("", [Validators.required]),
    });
    if (this.userId != undefined) {
      this.getUserData();
    }
  }

  getUserData() {
    this.userService.GetUser(this.userId).subscribe({
      next: (response) => {
        this.createUserForm.setValue({
          firstName: response.firstName,
          lastName: response.lastName,
          profileName: response.profileName,
          email: response.email,
          role: response.role,
          password: "",
          status: response.status,
        });
        this.email = response.email;
      }
    });
    this.createUserForm.controls['password'].removeValidators(Validators.required);
    this.createUserForm.controls['password'].updateValueAndValidity();
  }

  onPasswordButtonClick() {
    this.isShowPassword = !this.isShowPassword;
  }

  ngOnChanges(): void {
    this.isButtonClick;
  }

  onFormSubmit() {
    if (this.createUserForm.valid && !this.isEmailExist) {
      this.isButtonClick = true;
      if (this.userId == undefined) {
        this.userService.CreateUser(this.createUserForm.value).pipe(
          finalize(() => {
            this.isButtonClick = false;
          })
        ).subscribe({
          next: (response) => {
            this.router.navigate(['/admin/user']);
          }
        });
      }
      else {
        const userDto: UserDto = this.createUserForm.value;
        userDto.id = this.userId;
        this.userService.UpdateUser(this.createUserForm.value).pipe(
          finalize(() => {
            this.isButtonClick = false;
          })
        ).subscribe({
          next: (response) => {
            this.router.navigate(['/admin/user']);
          }
        });
      }
    } else {
      this.createUserForm.markAllAsTouched();
    }
  }

  onEmailChange(event: any) {
    const email = event.target.value;
    if (email == this.email) {
      this.isEmailExist = false;
    }
    else if (email.length > 0) {
      this.userService.EmailExist(email).subscribe({
        next: (response: boolean) => {
          this.isEmailExist = response;
        }
      });
    }
  }
}
