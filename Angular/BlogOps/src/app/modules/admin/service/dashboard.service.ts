import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BlogFilterDto } from '../../../shared/interfaces/blog-filter-dto';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';
import { Blog } from '../../../shared/interfaces/blog';
import { UpdateBlogRequestDto } from '../../../shared/interfaces/update-blog-request-dto';
import { BlogCardComponent } from '../../../components/base/blog-card/blog-card.component';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogs(blogFilterDto: BlogFilterDto, pageNo: number) : Observable<any> {
    return this.httpClient.post(`${baseUrl}/blogs/${pageNo}`, blogFilterDto);
  }

  public GetUsers() : Observable<any>{
    return this.httpClient.get(`${baseUrl}/users/Author`);
  }

  public UpdateBlog(blog:Blog) : Observable<any> {
    const updateBlogRequestDto : UpdateBlogRequestDto ={
      id : blog.id,
      title: blog.title,
      content: blog.content,
      status: blog.status,
      adminComment: blog.adminComment,
      blogCategories: blog.blogCategories,
    }
    return this.httpClient.put(`${baseUrl}/blogs/blog/${blog.id}`, updateBlogRequestDto);
  }
}
