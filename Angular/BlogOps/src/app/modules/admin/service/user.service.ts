import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';
import { UserFilterDto } from '../../../shared/interfaces/user-filter-dto';
import { UserDto } from '../../../shared/interfaces/user-dto';
import { CreateUserRequestDto } from '../../../shared/interfaces/create-user-request-dto';
import { PaginationDto } from '../../../shared/interfaces/pagination-dto';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private httpClient: HttpClient) { }

  public GetUsers(userFilterDto: UserFilterDto): Observable<PaginationDto<UserDto>> {
    return this.httpClient.post<PaginationDto<UserDto>>(`${baseUrl}/users/filter`, userFilterDto);
  }

  public GetUser(userId: number): Observable<UserDto> {
    return this.httpClient.get<UserDto>(`${baseUrl}/users/${userId}`);
  }

  public CreateUser(createUserRequestDto: CreateUserRequestDto): Observable<void> {
    return this.httpClient.post<void>(`${baseUrl}/users`, createUserRequestDto);
  }

  public UpdateUser(useDto: UserDto): Observable<void> {
    return this.httpClient.put<void>(`${baseUrl}/users/${useDto.id}`, useDto);
  }

  public EmailExist(email: string): Observable<boolean> {
    return this.httpClient.get<boolean>(`${baseUrl}/users/email-exist/${email}`);
  }
}
