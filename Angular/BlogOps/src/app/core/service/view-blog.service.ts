import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../shared/constants/constant';

@Injectable({
  providedIn: 'root'
})
export class ViewBlogService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogDetails(blogId: number): Observable<any> {
    return this.httpClient.get(`${baseUrl}/blogs/blog/${blogId}`);
  }
}
