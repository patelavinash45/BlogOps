import { Component } from '@angular/core';
import { Blog } from '../../shared/interfaces/blog';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { CommonModule, Location } from '@angular/common';
import { EnumIntToValuePipe } from '../../core/pipe/enum-int-to-value.pipe';
import { ViewBlogService } from '../../core/service/view-blog.service';
import { HeaderComponent } from "../base/header/header.component";

@Component({
  selector: 'app-view-blog',
  standalone: true,
  imports: [CommonModule, RouterLink, EnumIntToValuePipe, HeaderComponent],
  templateUrl: './view-blog.component.html',
  styleUrl: './view-blog.component.css'
})
export class ViewBlogComponent {
  blog!: Blog;
  blogId!: number;

  constructor(private viewBlogService:ViewBlogService,private route: ActivatedRoute,private location:Location){}

  ngOnInit(): void {
    this.blogId = this.route.snapshot.params['blogId'];
    this.viewBlogService.GetBlogDetails(this.blogId).subscribe((response: Blog) => {
      this.blog = response;
    })
  }

  onBackButtonClick(){
    this.location.back();
  }
}
