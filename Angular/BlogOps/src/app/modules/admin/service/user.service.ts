import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';
import { UserFilterDto } from '../../../shared/interfaces/user-filter-dto';
import { UserDto } from '../../../shared/interfaces/user-dto';
import { CreateUserRequestDto } from '../../../shared/interfaces/create-user-request-dto';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private httpClient: HttpClient) { }

  public GetUsers(userFilterDto: UserFilterDto): Observable<UserDto[]> {
    return this.httpClient.post<UserDto[]>(`${baseUrl}/users`, userFilterDto);
  }

  public GetUser(userId: number): Observable<UserDto> {
    return this.httpClient.get<UserDto>(`${baseUrl}/users/${userId}`);
  }

  public CreateUser(createUserRequestDto: CreateUserRequestDto): Observable<void> {
    return this.httpClient.post<void>(`${baseUrl}/users/user`, createUserRequestDto);
  }

  public UpdateUser(useDto: UserDto): Observable<void> {
    return this.httpClient.put<void>(`${baseUrl}/users/${useDto.id}`, useDto);
  }
}
