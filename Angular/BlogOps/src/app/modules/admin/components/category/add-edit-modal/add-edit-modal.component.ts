import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatExpansionModule } from '@angular/material/expansion';
import { CategoryDto } from '../../../../../shared/interfaces/category-dto';
import { ValidationMessageComponent } from "../../../../../components/base/validation-message/validation-message.component";
import { CategoryService } from '../../../service/category.service';
import { MatButtonModule } from '@angular/material/button';
import { CreateCategoryRequestDto } from '../../../../../shared/interfaces/create-category-request-dto';
import { finalize } from 'rxjs';

@Component({
  selector: 'app-add-edit-modal',
  standalone: true,
  imports: [MatExpansionModule, ReactiveFormsModule, ValidationMessageComponent, MatButtonModule],
  templateUrl: './add-edit-modal.component.html',
  styleUrl: './add-edit-modal.component.css'
})
export class AddEditModalComponent {
  isCategoryExist: boolean = false;
  categoryForm!: FormGroup;
  name!: string;
  @Input() isCreateCategory: boolean = false;
  @Input() category!: CategoryDto;
  localCategory !: CategoryDto;
  isAddButtonClick: boolean = false;
  @Output() conformUpdate = new EventEmitter<boolean>();

  constructor(private categoryService: CategoryService) { }

  ngOnInit(): void {
    this.categoryForm = new FormGroup({
      name: new FormControl('', [Validators.required, Validators.maxLength(48)]),
    });
    if (!this.isCreateCategory) {
      this.name = this.category.name;
      this.localCategory = JSON.parse(JSON.stringify(this.category));
      this.categoryForm.addControl('status', new FormControl('', [Validators.required]),)
      this.categoryForm.setValue({
        name: this.category.name,
        status: this.category.status,
      });
    }
  }

  updateCategory() {
    if (this.categoryForm.valid && !this.isCategoryExist) {
      this.localCategory.name = this.categoryForm.controls['name'].value;
      this.localCategory.status = this.categoryForm.controls['status'].value;
      this.categoryService.UpdateCategory(this.localCategory).pipe(
        finalize(() => {
          this.isAddButtonClick = false;
          this.conformUpdate.emit(false);
        })
      ).subscribe({
        next: (response) => this.conformUpdate.emit(true),
      });
    } else {
      this.categoryForm.markAllAsTouched();
    }
  }

  onAddButtonClick() {
    console.log(this.isCategoryExist);
    if (this.categoryForm.valid && !this.isCategoryExist) {
      this.isAddButtonClick = true
      const createCategoryRequestDto: CreateCategoryRequestDto = this.categoryForm.value;
      this.categoryService.AddCategory(createCategoryRequestDto).pipe(
        finalize(() => {
          this.isAddButtonClick = false;
          this.conformUpdate.emit(false);
        })
      ).subscribe({
        next: (response) => this.conformUpdate.emit(true),
      });
    } else {
      this.categoryForm.markAllAsTouched();
    }
  }

  onCategoryNameChange(event: any) {
    const name = event.target.value;
    if (name == this.name) {
      this.isCategoryExist = false;
    }
    else if (name.length > 0) {
      this.categoryService.CategoryExist(name).subscribe({
        next: (response: boolean) => {
          this.isCategoryExist = response;
        }
      });
    }
  }
}
