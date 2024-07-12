import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BlogFilterDto } from '../../../Shared/interfaces/blog-filter-dto';
import { baseUrl } from '../../../Shared/consent/Consent';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogs(blogFilterDto: BlogFilterDto, pageNo: number) : Observable<any> {
    return this.httpClient.post(`${baseUrl}/blogs/${pageNo}`, blogFilterDto);
  }
}
