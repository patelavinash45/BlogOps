import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { CookieService } from 'ngx-cookie-service';
import { catchError, throwError } from 'rxjs';

export const httpRequestInterceptor: HttpInterceptorFn = (req, next) => {
  const cookiesService = inject(CookieService);
  const jwtToken = cookiesService.get("JwtToken");
  console.log(jwtToken);
  const newRequest = req.clone({
    setHeaders: {
      'Content-Type': 'application/json',
      Authorization: jwtToken,
    },
  });
  return next(newRequest).pipe(
    catchError(errorResponse => {
      return throwError(errorResponse);
    })
  );
};
