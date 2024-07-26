import { HttpClient, HttpEvent } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, tap } from 'rxjs';
import { baseUrl } from '../../shared/constants/constant';
import { CreateBlogRequestDto } from '../../shared/interfaces/create-blog-request-dto';
import { UpdateBlogRequestDto } from '../../shared/interfaces/update-blog-request-dto';
import { Blog } from '../../shared/interfaces/blog';
import { CategoriesFilterDto } from '../../shared/interfaces/categories-filter-dto';
import { CategoryStatus } from '../../shared/enums/category-status';
import { CategoryDto } from '../../shared/interfaces/category-dto';

@Injectable({
  providedIn: 'root'
})
export class BlogService {

  constructor(private httpClient: HttpClient) { }

  public GetCategories(): Observable<CategoryDto[]> {
    const categoriesFilterDto: CategoriesFilterDto = {
      searchContent : null,
      status: CategoryStatus.Active,
    }
    return this.httpClient.post<CategoryDto[]>(`${baseUrl}/categories/filter`, categoriesFilterDto);
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
