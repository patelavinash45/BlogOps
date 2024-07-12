import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../Shared/consent/Consent';
import { CreateBlogRequestDto } from '../../../Shared/interfaces/create-blog-request-dto';

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
}