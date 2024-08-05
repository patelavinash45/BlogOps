import { Routes } from '@angular/router';
import { LogInComponent } from './modules/logIn/components/log-in/log-in.component';
import { AuthorRoutes } from './modules/author/route/author.routes';
import { AdminRoutes } from './modules/admin/route/admin.routes';
import { loginGuard } from './core/guard/login.guard';
import { AccessDeniedComponent } from './components/base/access-denied/access-denied.component';
import { adminGuard } from './core/guard/admin.guard';
import { authorGuard } from './core/guard/author.guard';
import { HeaderComponent } from './components/base/header/header.component';
import { SignUpComponent } from './modules/logIn/components/sign-up/sign-up.component';

export const routes: Routes = [
    {
        path: '',
        redirectTo: 'login',
        pathMatch: 'full'
    },
    {
        path: 'login',
        component: LogInComponent,
        canActivate: [loginGuard],
    },
    {
        path: 'signup',
        component: SignUpComponent,
        canActivate: [loginGuard],
    },
    {
        path: 'admin',
        component: HeaderComponent,
        children: AdminRoutes,
        canActivateChild: [adminGuard],
    },
    {
        path: 'author',
        component: HeaderComponent,
        children: AuthorRoutes,
        canActivateChild: [authorGuard],
    },
    {
        path: 'access',
        component: HeaderComponent,
        children: [
            {
                path: 'denied',
                component: AccessDeniedComponent,
            }
        ],
    }
];
