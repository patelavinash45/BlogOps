import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUrl } from '../../../shared/constants/constant';
import { UserFilterDto } from '../../../shared/interfaces/user-filter-dto';
import { UserDto } from '../../../shared/interfaces/user-dto';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private httpClient: HttpClient) { }

  public GetUsers(userFilterDto: UserFilterDto) : Observable<UserDto[]>{
    return this.httpClient.post<UserDto[]>(`${baseUrl}/users`, userFilterDto);
  }
}
