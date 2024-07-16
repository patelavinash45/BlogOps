import { Component } from '@angular/core';
import { HeaderComponent } from '../../../../components/base/header/header.component';
import { AngularEditorConfig, AngularEditorModule } from '@kolkov/angular-editor';
import { NewBlogService } from '../../service/new-blog.service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CategoryResponseDto } from '../../../../shared/interfaces/category-response-dto';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ManageToastrService } from '../../../../core/service/manage-toastr.service';
import { Blog } from '../../../../shared/interfaces/blog';
import { CreateBlogRequestDto } from '../../../../shared/interfaces/create-blog-request-dto';
import { UpdateBlogRequestDto } from '../../../../shared/interfaces/update-blog-request-dto';
import { BlogSaveMessage, editorConfig } from '../../../../shared/constants/constant';

@Component({
  selector: 'app-new-blog',
  standalone: true,
  imports: [HeaderComponent, AngularEditorModule, ReactiveFormsModule, RouterLink],
  templateUrl: './new-blog.component.html',
  styleUrl: './new-blog.component.css'
})
export class NewBlogComponent {
  editConfig: AngularEditorConfig = editorConfig;
  categories: CategoryResponseDto[] = [];
  blogForm!: FormGroup;
  blogId!: number;
  createBlogRequestDto!: CreateBlogRequestDto;
  selectedCategories: number[] = [];

  constructor(
    private newBlogService: NewBlogService,
    private manageToastrService: ManageToastrService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.blogId = this.route.snapshot.params['blogId'];
    if (this.blogId != undefined) {
      this.getBlogDetails();
    }
    this.blogForm = new FormGroup({
      title: new FormControl('', [Validators.required, Validators.maxLength(128)]),
      content: new FormControl('', [Validators.required]),
      blogCategories: new FormControl([], [Validators.required]),
      isDraft: new FormControl(false),
    });
  }

  getBlogDetails() {
    this.newBlogService.GetBlogDetails(this.blogId).subscribe((response: Blog) => {
      this.blogForm.setValue({
        title: response.title,
        content: response.content,
        blogCategories: response.blogCategories,
        isDraft: response.status == 4,
      });
      this.selectedCategories = response.blogCategories;
    })
  }

  ngOnInit(): void {
    this.newBlogService.GetCategories().subscribe((response: CategoryResponseDto[]) => {
      this.categories = response;
    });
  }

  onCategoryChange(event: any) {
    this.blogForm.controls['blogCategories'].markAsTouched;
    if (event.target.checked) {
      this.selectedCategories.push(event.target.value);
    }
    else {
      this.selectedCategories = this.selectedCategories.filter(a => a != event.target.value);
    }
    this.blogForm.controls['blogCategories'].setValue(this.selectedCategories);
  }

  onFormSubmit() {
    if (this.blogForm.valid) {
      console.log(this.blogForm.value);
      if (this.blogId == undefined) {
        this.newBlogService.CreateNewBlog(this.blogForm.value).subscribe((response) => {
          this.manageToastrService.showSuccess(BlogSaveMessage);
          this.router.navigate(['/author/dashboard']);
        });
      }
      else{
        const updateBlogRequestDto: UpdateBlogRequestDto = {
          id: this.blogId,
          title: this.blogForm.controls['title'].value,
          content: this.blogForm.controls['content'].value,
          adminComment: null,
          blogCategories: this.blogForm.controls['blogsCategories'].value,
          isDraft: this.blogForm.controls['isDraft'].value,
        };
        this.newBlogService.UpdateBlog(updateBlogRequestDto).subscribe((response) => {
          this.manageToastrService.showSuccess(BlogSaveMessage);
          this.router.navigate(['/author/dashboard']);
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

}
