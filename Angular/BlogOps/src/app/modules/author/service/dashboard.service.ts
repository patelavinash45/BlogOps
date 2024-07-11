import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BlogFilterDto } from '../../../Shared/interfaces/blog-filter-dto';
import { baseUrl } from '../../../Shared/consent/Consent';
import { Observable } from 'rxjs';
import { LogInResponseDto } from '../../../Shared/interfaces/log-in-response-dto';
import { CookieService } from 'ngx-cookie-service';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient, private cookieService: CookieService) { }

  public GetBlogs(blogFilterDto: BlogFilterDto, pageNo: number) : Observable<any> {
    return this.httpClient.post(`${baseUrl}/blogs/${pageNo}`, blogFilterDto);
  }

  public SetCookies(logInResponseDto: LogInResponseDto, keepMeSignIn : boolean){
    var date = new Date();
        keepMeSignIn
          ? date.setMinutes(date.getMinutes() + 60)
          : date.setMinutes(date.getMinutes() + 20);
        this.cookieService.set('JwtToken', logInResponseDto.jwtToken, date, '/');
        this.cookieService.set('FirstName', logInResponseDto.jwtToken, date, '/');
        this.cookieService.set('LastName', logInResponseDto.jwtToken, date, '/');
  }
}
