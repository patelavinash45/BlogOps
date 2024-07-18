import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { ManageCookieService } from '../service/manage-cookie.service';

export const httpRequestInterceptor: HttpInterceptorFn = (req, next) => {
  const cookiesService = inject(ManageCookieService);
  const jwtToken = cookiesService.GetJwtToken();
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
