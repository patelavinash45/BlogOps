import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BlogFilterDto } from '../../../shared/interfaces/blog-filter-dto';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';
import { Blog } from '../../../shared/interfaces/blog';
import { UpdateBlogRequestDto } from '../../../shared/interfaces/update-blog-request-dto';
import { UserFilterDto } from '../../../shared/interfaces/user-filter-dto';
import { UserStatus } from '../../../shared/enums/user-status';
import { RoleType } from '../../../shared/enums/role-type';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogs(blogFilterDto: BlogFilterDto, pageNo: number): Observable<any> {
    return this.httpClient.post(`${baseUrl}/blogs/${pageNo}`, blogFilterDto);
  }

  public GetAllAuthors(): Observable<any> {
    const userFilterDto: UserFilterDto = {
      status: UserStatus.All,
      searchContent: null,
      role: RoleType.Author
    }
    return this.httpClient.post(`${baseUrl}/users`, userFilterDto);
  }

  public ChangeStatus(blogId: number, isApproved: boolean): Observable<any> {
    return this.httpClient.put(`${baseUrl}/blogs/${blogId}`, null);
  }
}
