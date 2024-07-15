import { inject } from '@angular/core';
import { CanActivateChildFn, Router } from '@angular/router';
import { ManageCookieService } from '../service/manage-cookie.service';

export const authGuard: CanActivateChildFn = (childRoute, state) => {
  const cookiesService = inject(ManageCookieService);
  const jwtToken = cookiesService.GetJwtToken();
  if(jwtToken.length == 0){
    const router = inject(Router);
    router.navigate(["/login"]);
  }
  return true;
};
