import { Component, Input } from '@angular/core';
import { FormGroup, FormControl, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { HomeService } from '../../../service/home.service';
import { Router } from '@angular/router';
import { ValidationMessageComponent } from "../../../../../components/base/validation-message/validation-message.component";

@Component({
  selector: 'app-reject-modal',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, ValidationMessageComponent],
  templateUrl: './reject-modal.component.html',
  styleUrl: './reject-modal.component.css'
})
export class RejectModalComponent {
  blogId!: number;
  rejectForm!: FormGroup;

  constructor(private homeService: HomeService, private router: Router) {}

  ngOnInit(): void {
    this.rejectForm = new FormGroup({
      adminComment: new FormControl("", [Validators.maxLength(256)]),
    });
  }

  onFormSubmit() {
    if (this.rejectForm.valid) {
      const adminComment = this.rejectForm.controls['adminComment'].value;
      this.homeService.ChangeStatus(this.blogId, false, adminComment).subscribe((response) => {
        //this.router.navigate(['/admin/dashboard']);
        this.router.navigate(['login']);
      });
    } else {
      this.rejectForm.markAllAsTouched();
    }
  }
}
