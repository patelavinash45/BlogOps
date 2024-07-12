import { Component } from '@angular/core';
import { HeaderComponent } from '../../../../components/base/header/header.component';
import { AngularEditorConfig, AngularEditorModule } from '@kolkov/angular-editor';
import { editorConfig } from '../../../../Shared/consent/Consent';
import { CategoryResponseDto } from '../../../../Shared/interfaces/category-response-dto';
import { NewBlogService } from '../../service/new-blog.service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { response } from 'express';

@Component({
  selector: 'app-new-blog',
  standalone: true,
  imports: [HeaderComponent, AngularEditorModule, ReactiveFormsModule],
  templateUrl: './new-blog.component.html',
  styleUrl: './new-blog.component.css'
})
export class NewBlogComponent {
  editConfig: AngularEditorConfig = editorConfig;
  categories: CategoryResponseDto[] = [];
  createBlogForm!: FormGroup;
  selectedCategories: number[] = [];

  constructor(private newBlogService: NewBlogService) { }

  ngOnInit(): void {
    this.newBlogService.GetCategories().subscribe((response: CategoryResponseDto[]) => {
      this.categories = response;
    });
    this.createBlogForm = new FormGroup({
      title: new FormControl('', [Validators.required, Validators.maxLength(128)]),
      content: new FormControl('', [Validators.required]),
      blogsCategoryIds: new FormControl([], [Validators.required]),
      isDraft: new FormControl(false),
    });
  }

  onCategoryChange(event: any) {
    this.createBlogForm.controls['blogsCategoryIds'].markAsTouched;
    if (event.target.checked) {
      this.selectedCategories.push(event.target.value);
    }
    else {
      this.selectedCategories = this.selectedCategories.filter(a => a != event.target.value);
    }
    this.createBlogForm.controls['blogsCategoryIds'].setValue(this.selectedCategories);
  }

  onFormSubmit() {
    if(this.createBlogForm.valid){
      this.newBlogService.CreateNewBlog(this.createBlogForm.value).subscribe((response)=>{
        console.log("response");
        console.log(response);
      })
    }
  }

}
