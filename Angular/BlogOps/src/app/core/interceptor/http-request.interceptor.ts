import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { ManageCookieService } from '../service/manage-cookie.service';
import { ManageToastrService } from '../service/manage-toastr.service';

export const httpRequestInterceptor: HttpInterceptorFn = (req, next) => {
  const cookiesService = inject(ManageCookieService);
  const jwtToken = cookiesService.GetJwtToken();
  const toasterService = inject(ManageToastrService);
  const newRequest = req.clone({
    setHeaders: {
      'Content-Type': 'application/json',
      Authorization: jwtToken,
    },
  });
  return next(newRequest).pipe(
    catchError(errorResponse => {
      toasterService.ShowError(errorResponse.error.Message);
      return throwError(errorResponse);
    })
  );
};
