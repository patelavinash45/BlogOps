import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { LogInRequestDto } from '../../../Shared/interfaces/log-in-request-dto';
import { baseUrl } from '../../../Shared/consent/Consent';
import { Observable } from 'rxjs';
import { LogInResponseDto } from '../../../Shared/interfaces/log-in-response-dto';
import { CookieService } from 'ngx-cookie-service';

@Injectable({
  providedIn: 'root'
})
export class LogInService {

  constructor(private httpClient: HttpClient, private cookieService: CookieService) { }

  public LogIn(logInRequestDto: LogInRequestDto): Observable<any> {
    return this.httpClient.post(`${baseUrl}/users/login`, logInRequestDto);
  }

  public SetCookies(logInResponseDto: LogInResponseDto, keepMeSignIn: boolean) {
    var date = new Date();
    keepMeSignIn
      ? date.setMinutes(date.getMinutes() + 60)
      : date.setMinutes(date.getMinutes() + 20);
    this.cookieService.set('JwtToken', logInResponseDto.jwtToken, date, '/');
    this.cookieService.set('FirstName', logInResponseDto.firstName, date, '/');
    this.cookieService.set('LastName', logInResponseDto.lastName, date, '/');
  }
}
