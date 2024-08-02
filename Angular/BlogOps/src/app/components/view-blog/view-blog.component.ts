import { Component } from '@angular/core';
import { Blog } from '../../shared/interfaces/blog';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { CommonModule, Location } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { BlogService } from '../../core/service/blog.service';
import { BlogStatusIntToValuePipe } from '../../core/pipe/blog-status-int-to-value.pipe';

@Component({
  selector: 'app-view-blog',
  standalone: true,
  imports: [CommonModule, RouterLink, BlogStatusIntToValuePipe, MatButtonModule],
  templateUrl: './view-blog.component.html',
  styleUrl: './view-blog.component.css'
})
export class ViewBlogComponent {
  blog!: Blog;
  blogId!: number;
  userType!: string | null;

  constructor(private blogService: BlogService, private route: ActivatedRoute, private location: Location) { }

  ngOnInit(): void {
    this.userType = this.route.snapshot.data['role'];
    this.blogId = this.route.snapshot.params['blogId'];
    this.blogService.GetBlogDetails(this.blogId).subscribe({
      next: (response: Blog) => {
        this.blog = response;
      }
    });
  }

  onBackButtonClick() {
    this.location.back();
  }
}
