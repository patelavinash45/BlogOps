import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { ManageCookieService } from '../service/manage-cookie.service';

export const loginGuard: CanActivateFn = (route, state) => {
  const cookiesService = inject(ManageCookieService);
  const jwtToken = cookiesService.GetJwtToken();
  if (jwtToken.length > 0) {
    const role = cookiesService.GetRoleType();
    const router = inject(Router);
    if (role == '1') {
      router.navigate(["/admin/blog"]);
    }
    else {
      router.navigate(["/author/dashboard"]);
    }
  }
  return true;
};
