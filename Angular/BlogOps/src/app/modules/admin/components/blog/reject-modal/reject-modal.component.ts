import { Component, Inject, Input } from '@angular/core';
import { FormGroup, FormControl, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ValidationMessageComponent } from "../../../../../components/base/validation-message/validation-message.component";
import { BlogService } from '../../../service/blog.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { finalize } from 'rxjs';

@Component({
  selector: 'app-reject-modal',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, ValidationMessageComponent, MatDialogModule, MatButtonModule],
  templateUrl: './reject-modal.component.html',
  styleUrl: './reject-modal.component.css'
})
export class RejectModalComponent {
  @Input() blogId!: number;
  @Input() isApprove!: boolean;
  form!: FormGroup;
  isButtonClick: boolean = false;

  constructor(private blogService: BlogService, public dialogRef: MatDialogRef<RejectModalComponent>, private modalService: NgbModal, @Inject(MAT_DIALOG_DATA) public data: { blogId: number, isApprove: boolean }) {
    this.blogId = this.data.blogId;
    this.isApprove = this.data.isApprove;
  }

  ngOnInit(): void {
    this.form = new FormGroup({
      adminComment: new FormControl("", [Validators.maxLength(256)]),
    });
  }

  onFormSubmit() {
    if (this.isApprove) {
      this.blogService.ChangeStatus(this.blogId, true, null).pipe(
        finalize(() => {
          this.isButtonClick = false;
        })
      ).subscribe({
        next: (response) => {
          this.dialogRef.close();
        }
      });
    }
    else {
      if (this.form.valid) {
        this.isButtonClick = true;
        const adminComment = this.form.controls['adminComment'].value;
        this.blogService.ChangeStatus(this.blogId, false, adminComment).pipe(
          finalize(() => {
            this.isButtonClick = false;
          })
        ).subscribe(
          {
            next: (response) => {
              this.dialogRef.close();
            }
          });
      } else {
        this.form.markAllAsTouched();
      }
    }
  }
}
