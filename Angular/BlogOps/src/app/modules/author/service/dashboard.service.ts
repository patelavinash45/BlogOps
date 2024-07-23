import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BlogFilterDto } from '../../../shared/interfaces/blog-filter-dto';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';
import { Blog } from '../../../shared/interfaces/blog';
import { PaginationDto } from '../../../shared/interfaces/pagination-dto';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogs(blogFilterDto: BlogFilterDto, pageNo: number) : Observable<PaginationDto> {
    return this.httpClient.post<PaginationDto>(`${baseUrl}/blogs/${pageNo}`, blogFilterDto);
  }
}
