import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatExpansionModule } from '@angular/material/expansion';
import { CategoryDto } from '../../../../../shared/interfaces/category-dto';
import { ValidationMessageComponent } from "../../../../../components/base/validation-message/validation-message.component";

@Component({
  selector: 'app-add-edit-modal',
  standalone: true,
  imports: [MatExpansionModule, ReactiveFormsModule, ValidationMessageComponent],
  templateUrl: './add-edit-modal.component.html',
  styleUrl: './add-edit-modal.component.css'
})
export class AddEditModalComponent {
  editCategoryForm!: FormGroup;
  category: CategoryDto | null = null;

  ngOnInit(): void {
    this.editCategoryForm = new FormGroup({
      name: new FormControl('', [Validators.required, Validators.maxLength(48)]),
      status: new FormControl('', [Validators.required]),
    })
  }

  onEditButtonClick(category: CategoryDto) {
    this.editCategoryForm.setValue({
      name: category.name,
      status: category.status,
    });
  }
}
