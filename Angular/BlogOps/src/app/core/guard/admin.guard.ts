import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { ManageCookieService } from '../service/manage-cookie.service';

export const adminGuard: CanActivateFn = (route, state) => {
  const cookiesService = inject(ManageCookieService);
  const jwtToken = cookiesService.GetJwtToken();
  if (jwtToken.length == 0) {
    const router = inject(Router);
    router.navigate(["/login"]);
    return false;
  }
  const roleType = cookiesService.GetRoleType();
  if (roleType == '1') {
    return true;
  }
  const router = inject(Router);
  router.navigate(["/access/denied"]);
  return false;
};
