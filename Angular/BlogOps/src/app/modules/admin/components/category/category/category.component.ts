import { Component, ViewChild } from '@angular/core';
import { MatExpansionModule } from '@angular/material/expansion';
import { CommonModule } from '@angular/common';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { ValidationMessageComponent } from '../../../../../components/base/validation-message/validation-message.component';
import { CategoryStatusIntToValuePipe } from '../../../../../core/pipe/category-status-int-to-value.pipe';
import { CategoryDto } from '../../../../../shared/interfaces/category-dto';
import { StatusWiseClasses } from '../../../../../shared/constants/constant';
import { CategoriesFilterDto } from '../../../../../shared/interfaces/categories-filter-dto';
import { CategoryStatus } from '../../../../../shared/enums/category-status';
import { CategoryService } from '../../../service/category.service';
import { AddEditModalComponent } from '../add-edit-modal/add-edit-modal.component';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';

@Component({
  selector: 'app-category',
  standalone: true,
  imports: [
    CommonModule,
    MatExpansionModule,
    MatPaginatorModule,
    MatProgressBarModule,
    MatButtonModule,
    CategoryStatusIntToValuePipe,
    ValidationMessageComponent,
    AddEditModalComponent,
    NgxSkeletonLoaderModule
  ],
  templateUrl: './category.component.html',
  styleUrl: './category.component.css'
})
export class CategoryComponent {
  categories: CategoryDto[] = [];
  statusWiseClasses: string[] = StatusWiseClasses;
  categoriesFilterDto: CategoriesFilterDto = {
    searchContent: null,
    status: CategoryStatus.All,
  };
  isFilterOptionsExpended: boolean = false;
  isCreateCategory: boolean = false;
  editCategoryId: number | null = null;
  @ViewChild(AddEditModalComponent) addEditModalComponent!: AddEditModalComponent;

  constructor(private categoryService: CategoryService) { }

  getData() {
    this.categoryService.GetCategories(this.categoriesFilterDto).subscribe((response) => {
      this.categories = response;
    });
  }

  ngOnInit(): void {
    this.getData();
  }

  onSearchInputChange(event: any) {
    this.categoriesFilterDto.searchContent = event.target.value;
    this.getData();
  }

  onStatusChange(event: any) {
    this.categoriesFilterDto.status = event.target.value;
    this.getData();
  }

  onFilterButtonClick() {
    if (this.editCategoryId == null) {
      this.isFilterOptionsExpended = !this.isFilterOptionsExpended;
    }
  }

  openModal(category: CategoryDto | null = null, isCreate: boolean = false) {
    this.isFilterOptionsExpended = false;
    this.isCreateCategory = isCreate;
    this.editCategoryId = category?.id ?? null;
  }

  closeModal(isReload: boolean = false) {
    this.editCategoryId = null;
    this.isCreateCategory = false;
    if (isReload) {
      this.getData();
    }
  }

  onEditConform() {
    this.editCategoryId = null;
    this.addEditModalComponent.updateCategory();
  }
}
