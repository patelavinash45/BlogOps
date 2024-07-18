import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../shared/constants/constant';
import { CreateBlogRequestDto } from '../../shared/interfaces/create-blog-request-dto';
import { UpdateBlogRequestDto } from '../../shared/interfaces/update-blog-request-dto';



@Injectable({
  providedIn: 'root'
})
export class NewBlogService {

  constructor(private httpClient: HttpClient) { }

  public GetCategories(): Observable<any> {
    return this.httpClient.get(`${baseUrl}/categories`);
  }

  public CreateNewBlog(createBlogRequestDto: CreateBlogRequestDto): Observable<any> {
    return this.httpClient.post(`${baseUrl}/blogs/blog`, createBlogRequestDto);
  }

  public GetBlogDetails(blogId: number): Observable<any> {
    return this.httpClient.get(`${baseUrl}/blogs/blog/${blogId}`);
  }

  public UpdateBlog(updateBlogRequestDto : UpdateBlogRequestDto){
    return this.httpClient.put(`${baseUrl}/blogs/blog/${updateBlogRequestDto.id}`, updateBlogRequestDto);
  }
}
