import { Injectable } from '@angular/core';
import { CookieService } from 'ngx-cookie-service';
import { LogInResponseDto } from '../../shared/interfaces/log-in-response-dto';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class ManageCookieService {

  constructor(private cookieService: CookieService, private router:Router) { }

  public SetCookies(logInResponseDto: LogInResponseDto, keepMeSignIn: boolean) {
    var date = new Date();
    keepMeSignIn
      ? date.setMinutes(date.getMinutes() + 60)
      : date.setMinutes(date.getMinutes() + 20);
    this.cookieService.set('JwtToken', logInResponseDto.jwtToken, date, '/');
    this.cookieService.set('FirstName', logInResponseDto.firstName, date, '/');
    this.cookieService.set('LastName', logInResponseDto.lastName, date, '/');
    this.cookieService.set('Role', logInResponseDto.roleType.toString(), date, '/');
  }

  public GetJwtToken() {
    return this.cookieService.get('JwtToken');
  }

  public GetFirstName() {
    return this.cookieService.get('FirstName');
  }

  public GetLastName() {
    return this.cookieService.get('LastName');
  }

  public GetRoleType() {
    return this.cookieService.get('Role');
  }

  public RemoveAllCookie(){
    this.cookieService.deleteAll('/', 'http://localhost:4200');
    this.router.navigate(['/login']);
  }
}
