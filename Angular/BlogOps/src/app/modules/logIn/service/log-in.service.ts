import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { LogInRequestDto } from '../../../shared/interfaces/log-in-request-dto';
import { Observable } from 'rxjs';
import { LogInResponseDto } from '../../../shared/interfaces/log-in-response-dto';
import { ManageCookieService } from '../../../core/service/manage-cookie.service';
import { baseUrl } from '../../../shared/constants/constant';
import { CreateUserRequestDto } from '../../../shared/interfaces/create-user-request-dto';
import { UserDto } from '../../../shared/interfaces/user-dto';

@Injectable({
  providedIn: 'root'
})
export class LogInService {

  constructor(private httpClient: HttpClient, private manageCookieService: ManageCookieService) { }

  public LogIn(logInRequestDto: LogInRequestDto): Observable<LogInResponseDto> {
    return this.httpClient.post<LogInResponseDto>(`${baseUrl}/users/login`, logInRequestDto);
  }

  public SetCookies(logInResponseDto: LogInResponseDto, keepMeSignIn: boolean) {
    this.manageCookieService.SetCookies(logInResponseDto, keepMeSignIn);
  }

  public SignUp(createUserRequestDto: CreateUserRequestDto): Observable<void> {
    return this.httpClient.post<void>(`${baseUrl}/users`, createUserRequestDto);
  }

  public GetUserDetails(token: string): Observable<UserDto> {
    return this.httpClient.get<UserDto>(`${baseUrl}/users/${token}`);
  }

  public VerifyEmail(id: number, token: string): Observable<void> {
    return this.httpClient.post<void>(`${baseUrl}/users/verify-email/id=${id}&token=${token}`, null);
  }
}
