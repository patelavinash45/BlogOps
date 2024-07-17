import { Component } from '@angular/core';
import { HeaderComponent } from "../../../../components/base/header/header.component";
import { Blog } from '../../../../shared/interfaces/blog';
import { ViewBlogService } from '../../service/view-blog.service';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { EnumIntToValuePipe } from '../../../../core/pipe/enum-int-to-value.pipe';

@Component({
  selector: 'app-view-blog',
  standalone: true,
  imports: [CommonModule, HeaderComponent, RouterLink, EnumIntToValuePipe],
  templateUrl: './view-blog.component.html',
  styleUrl: './view-blog.component.css'
})
export class ViewBlogComponent {
  blog!: Blog;
  blogId!: number;

  constructor(private viewBlogService:ViewBlogService,private route: ActivatedRoute){}

  ngOnInit(): void {
    this.blogId = this.route.snapshot.params['blogId'];
    this.viewBlogService.GetBlogDetails(this.blogId).subscribe((response: Blog) => {
      this.blog = response;
    })
  }
}
