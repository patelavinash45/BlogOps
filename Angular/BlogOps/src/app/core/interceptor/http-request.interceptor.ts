import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { ManageCookieService } from '../service/manage-cookie.service';
import { ManageToastrService } from '../service/manage-toastr.service';
import { Router } from '@angular/router';
import { RoutePathConstant } from '../../shared/constants/route-path.constant';
import { SessionExpired } from '../../shared/constants/constant';

export const httpRequestInterceptor: HttpInterceptorFn = (req, next) => {
  const cookiesService = inject(ManageCookieService);
  const jwtToken = cookiesService.GetJwtToken();
  const toasterService = inject(ManageToastrService);
  const router = inject(Router);
  const newRequest = req.clone({
    setHeaders: {
      'Content-Type': 'application/json',
      Authorization: jwtToken,
    },
  });
  return next(newRequest).pipe(
    catchError(errorResponse => {
      const statusCode = errorResponse.status;
      if (statusCode == 401) {
        toasterService.ShowError(SessionExpired);
        cookiesService.RemoveAllCookie();
        router.navigateByUrl(RoutePathConstant.LogInPath);
        return throwError(errorResponse);
      }
      toasterService.ShowError(errorResponse.error.Message);
      return throwError(errorResponse);
    })
  );
};
