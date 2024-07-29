import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatExpansionModule } from '@angular/material/expansion';
import { CategoryDto } from '../../../../../shared/interfaces/category-dto';
import { ValidationMessageComponent } from "../../../../../components/base/validation-message/validation-message.component";
import { CategoryService } from '../../../service/category.service';
import { MatButtonModule } from '@angular/material/button';
import { CreateCategoryRequestDto } from '../../../../../shared/interfaces/create-category-request-dto';

@Component({
  selector: 'app-add-edit-modal',
  standalone: true,
  imports: [MatExpansionModule, ReactiveFormsModule, ValidationMessageComponent, MatButtonModule],
  templateUrl: './add-edit-modal.component.html',
  styleUrl: './add-edit-modal.component.css'
})
export class AddEditModalComponent {
  categoryForm!: FormGroup;
  @Input() isCreateCategory: boolean = false;
  @Input() category!: CategoryDto;
  @Output() conformUpdate = new EventEmitter<boolean>();

  constructor(private categoryService: CategoryService) { }

  ngOnInit(): void {
    this.categoryForm = new FormGroup({
      name: new FormControl('', [Validators.required, Validators.maxLength(48)]),
    });
    if (!this.isCreateCategory) {
      this.categoryForm.addControl('status', new FormControl('', [Validators.required]),)
      this.categoryForm.setValue({
        name: this.category.name,
        status: this.category.status,
      });
    }
  }

  updateCategory() {
    if (this.categoryForm.valid) {
      this.category.name = this.categoryForm.controls['name'].value;
      this.category.status = this.categoryForm.controls['status'].value;
      this.categoryService.UpdateCategory(this.category).subscribe((response) => this.conformUpdate.emit(false));
    } else {
      this.categoryForm.markAllAsTouched();
    }
  }

  onAddButtonClick() {
    console.log(this.categoryForm);
    if (this.categoryForm.valid) {
      const createCategoryRequestDto: CreateCategoryRequestDto = this.categoryForm.value;
      this.categoryService.AddCategory(createCategoryRequestDto).subscribe((response) => this.conformUpdate.emit(true));
    } else {
      this.categoryForm.markAllAsTouched();
    }
  }
}
