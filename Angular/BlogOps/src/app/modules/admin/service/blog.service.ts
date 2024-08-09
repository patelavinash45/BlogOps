import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BlogFilterDto } from '../../../shared/interfaces/blog-filter-dto';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';
import { UserFilterDto } from '../../../shared/interfaces/user-filter-dto';
import { ChangeBlogStatusRequestDto } from '../../../shared/interfaces/change-blog-status-request-dto';
import { UserDto } from '../../../shared/interfaces/user-dto';
import { PaginationDto } from '../../../shared/interfaces/pagination-dto';
import { Blog } from '../../../shared/interfaces/blog';

@Injectable({
  providedIn: 'root'
})
export class BlogService {

  constructor(private httpClient: HttpClient) { }

  public GetBlogs(blogFilterDto: BlogFilterDto): Observable<PaginationDto<Blog>> {
    return this.httpClient.post<PaginationDto<Blog>>(`${baseUrl}/blogs/filter`, blogFilterDto);
  }

  public GetAllAuthors(userFilterDto: UserFilterDto): Observable<PaginationDto<UserDto>> {
    return this.httpClient.post<PaginationDto<UserDto>>(`${baseUrl}/users/filter`, userFilterDto);
  }

  public ChangeStatus(blogId: number, isApproved: boolean, adminComment: string | null): Observable<void> {
    const changeBlogStatusRequestDto: ChangeBlogStatusRequestDto = {
      isApproved: isApproved,
      adminComment: adminComment,
    }
    return this.httpClient.put<void>(`${baseUrl}/blogs/change-status/${blogId}`, changeBlogStatusRequestDto);
  }
}
