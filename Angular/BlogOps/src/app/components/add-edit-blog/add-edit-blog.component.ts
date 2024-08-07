import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ManageToastrService } from '../../core/service/manage-toastr.service';
import { Blog } from '../../shared/interfaces/blog';
import { CreateBlogRequestDto } from '../../shared/interfaces/create-blog-request-dto';
import { UpdateBlogRequestDto } from '../../shared/interfaces/update-blog-request-dto';
import { BlogSaveMessage, BlogUpdateMessage, editorConfig } from '../../shared/constants/constant';
import { Location } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { BlogService } from '../../core/service/blog.service';
import { ValidationMessageComponent } from "../base/validation-message/validation-message.component";
import { CategoryDto } from '../../shared/interfaces/category-dto';
import { EditorModule } from '@tinymce/tinymce-angular';
import { PaginationDto } from '../../shared/interfaces/pagination-dto';
import { CategoriesFilterDto } from '../../shared/interfaces/categories-filter-dto';
import { CategoryStatus } from '../../shared/enums/category-status';
import { debounceTime, distinctUntilChanged, finalize, Subject } from 'rxjs';
import { NgSelectModule } from '@ng-select/ng-select';

@Component({
  selector: 'app-add-edit-blog',
  standalone: true,
  imports: [
    ReactiveFormsModule,
    MatButtonModule,
    ValidationMessageComponent,
    EditorModule,
    NgSelectModule
  ],
  templateUrl: './add-edit-blog.component.html',
  styleUrl: './add-edit-blog.component.css',
})
export class AddEditBlogComponent {
  isButtonClick: boolean = false;
  editorConfig = editorConfig;
  categoryResponse!: PaginationDto<CategoryDto>;
  selectSearchCategories: CategoryDto[] = [];
  blogForm!: FormGroup;
  blogId!: number;
  isDraft: boolean = true;
  createBlogRequestDto!: CreateBlogRequestDto;
  categorySearchInput$ = new Subject<string>();
  categoriesFilterDto: CategoriesFilterDto = {
    searchContent: null,
    status: CategoryStatus.Active,
    pageNo: 1,
    pageSize: 20,
  };

  constructor(
    private blogService: BlogService,
    private manageToastrService: ManageToastrService,
    private router: Router,
    private route: ActivatedRoute,
    private location: Location
  ) {
    this.blogId = this.route.snapshot.params['blogId'];
    if (this.blogId != undefined) {
      this.getBlogDetails();
    }
    this.blogForm = new FormGroup({
      title: new FormControl('', [Validators.required, Validators.maxLength(128)]),
      content: new FormControl('', [Validators.required]),
      blogCategories: new FormControl([], this.isDraft ? [] : [Validators.required]),
      isDraft: new FormControl(this.isDraft),
    });
  }

  getBlogDetails() {
    this.blogService.GetBlogDetails(this.blogId).subscribe({
      next: (response: Blog) => {
        this.isDraft = response.status == 4;
        this.blogForm.setValue({
          title: response.title,
          content: response.content,
          blogCategories: response.blogCategories,
          isDraft: this.isDraft,
        });
      }
    });
  }

  getCategories() {
    this.blogService.GetCategories(this.categoriesFilterDto).subscribe({
      next: (response: PaginationDto<CategoryDto>) => {
        this.categoryResponse = response;
        this.selectSearchCategories = [...this.selectSearchCategories, ...response.dtoList];
      }
    });
  }

  ngOnInit(): void {
    this.getCategories();
    this.categorySearchInput$.pipe(debounceTime(300), distinctUntilChanged()).subscribe((searchInput) => {
      this.selectSearchCategories = [];
      this.categoriesFilterDto.pageNo = 1;
      this.categoriesFilterDto.searchContent = searchInput;
      this.getCategories();
    });
  }

  onOptionScroll() {
    if (this.categoryResponse.isNext) {
      this.categoriesFilterDto.pageNo++;
      this.getCategories();
    }
  }

  onFormSubmit() {
    if (this.blogForm.valid) {
      this.isButtonClick = true;
      console.log(this.blogForm)
      if (this.blogId == undefined) {
        this.blogService.CreateNewBlog(this.blogForm.value).pipe(
          finalize(() => {
            this.isButtonClick = false;
          })
        ).subscribe({
          next: (response) => {
            this.manageToastrService.ShowSuccess(BlogSaveMessage);
            this.router.navigate(['/author/dashboard']);
          }
        });
      }
      else {
        const updateBlogRequestDto: UpdateBlogRequestDto = {
          id: this.blogId,
          title: this.blogForm.controls['title'].value,
          content: this.blogForm.controls['content'].value,
          adminComment: null,
          blogCategories: this.blogForm.controls['blogCategories'].value,
          status: this.blogForm.controls['isDraft'].value ? 4 : 0,
        };
        this.blogService.UpdateBlog(updateBlogRequestDto).pipe(
          finalize(() => {
            this.isButtonClick = false;
          })
        ).subscribe({
          next: (response) => {
            this.manageToastrService.ShowSuccess(BlogUpdateMessage);
            this.router.navigate(['/author/dashboard']);
          }
        });
      }
    }
    else {
      this.blogForm.markAllAsTouched();
    }
  }

  onBlogTypeChange(event: any) {
    if (event.target.value == 0) {
      this.blogForm.controls['isDraft'].setValue(true);
      this.blogForm.controls['blogCategories'].clearValidators();
    }
    else {
      this.blogForm.controls['isDraft'].setValue(false);
      this.blogForm.controls['blogCategories'].setValidators([Validators.required]);
    }
    this.blogForm.controls['blogCategories'].updateValueAndValidity();
  }

  onBackButtonClick() {
    this.location.back();
  }
}
