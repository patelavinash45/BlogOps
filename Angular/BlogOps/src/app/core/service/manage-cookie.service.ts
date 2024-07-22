import { Injectable } from '@angular/core';
import { CookieService } from 'ngx-cookie-service';
import { LogInResponseDto } from '../../shared/interfaces/log-in-response-dto';
import { Router } from '@angular/router';
import * as cryptoJS from 'crypto-js';

@Injectable({
  providedIn: 'root'
})
export class ManageCookieService {
  private key: string = 'hbchj@#%^76$#%bdhcbhdb@*(nfdsmk454';

  constructor(private cookieService: CookieService, private router: Router) { }

  public SetCookies(logInResponseDto: LogInResponseDto, keepMeSignIn: boolean) {
    var date = new Date();
    keepMeSignIn
      ? date.setMinutes(date.getMinutes() + 60)
      : date.setMinutes(date.getMinutes() + 20);
    this.cookieService.set('JwtToken', logInResponseDto.jwtToken, date, '/');
    this.cookieService.set('FirstName', this.encryptData(logInResponseDto.firstName), date, '/');
    this.cookieService.set('LastName', this.encryptData(logInResponseDto.lastName), date, '/');
    this.cookieService.set('Role', this.encryptData(logInResponseDto.roleType.toString()), date, '/');
  }

  public GetJwtToken() {
    return this.cookieService.get('JwtToken');
  }

  public GetFirstName() {
    const firstName = this.cookieService.get('FirstName');
    return this.decryptData(firstName);
  }

  public GetLastName() {
    const lastName = this.cookieService.get('LastName');
    return this.decryptData(lastName);
  }

  public GetRoleType() {
    const role = this.cookieService.get('Role');
    return this.decryptData(role);
  }

  public RemoveAllCookie() {
    this.cookieService.delete('JwtToken', '/', 'localhost', false, 'Lax');
    this.cookieService.delete('FirstName', '/', 'localhost', false, 'Lax');
    this.cookieService.delete('LastName', '/', 'localhost', false, 'Lax');
    this.cookieService.delete('Role', '/', 'localhost', false, 'Lax');
    this.router.navigate(['/login']);
  }

  private encryptData(data: string): string {
    console.log(cryptoJS.AES.encrypt(data, this.key).toString());
    return cryptoJS.AES.encrypt(data, this.key).toString();
  }

  private decryptData(data: string): string {
    const bytes = cryptoJS.AES.decrypt(data, this.key);
    return bytes.toString(cryptoJS.enc.Utf8);
  }
}
