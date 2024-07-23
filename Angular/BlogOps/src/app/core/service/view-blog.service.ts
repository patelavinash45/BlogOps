import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../shared/constants/constant';
import { Blog } from '../../shared/interfaces/blog';

@Injectable({
  providedIn: 'root'
})
export class ViewBlogService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogDetails(blogId: number): Observable<Blog> {
    return this.httpClient.get<Blog>(`${baseUrl}/blogs/${blogId}`);
  }
}
