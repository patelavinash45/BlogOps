import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../shared/constants/constant';
import { CreateBlogRequestDto } from '../../shared/interfaces/create-blog-request-dto';
import { UpdateBlogRequestDto } from '../../shared/interfaces/update-blog-request-dto';
import { CategoryResponseDto } from '../../shared/interfaces/category-response-dto';
import { Blog } from '../../shared/interfaces/blog';

@Injectable({
  providedIn: 'root'
})
export class NewBlogService {

  constructor(private httpClient: HttpClient) { }

  public GetCategories(): Observable<CategoryResponseDto[]> {
    return this.httpClient.get<CategoryResponseDto[]>(`${baseUrl}/categories`);
  }

  public CreateNewBlog(createBlogRequestDto: CreateBlogRequestDto): Observable<void> {
    return this.httpClient.post<void>(`${baseUrl}/blogs`, createBlogRequestDto);
  }

  public GetBlogDetails(blogId: number): Observable<Blog> {
    return this.httpClient.get<Blog>(`${baseUrl}/blogs/${blogId}`);
  }

  public UpdateBlog(updateBlogRequestDto: UpdateBlogRequestDto): Observable<void> {
    return this.httpClient.put<void>(`${baseUrl}/blogs/${updateBlogRequestDto.id}`, updateBlogRequestDto);
  }
}
