import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BlogFilterDto } from '../../../shared/interfaces/blog-filter-dto';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogs(blogFilterDto: BlogFilterDto, pageNo: number) : Observable<any> {
    return this.httpClient.post(`${baseUrl}/blogs/${pageNo}`, blogFilterDto);
  }
}
