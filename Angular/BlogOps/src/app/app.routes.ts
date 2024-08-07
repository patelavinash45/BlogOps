import { Routes } from '@angular/router';
import { AuthorRoutes } from './modules/author/route/author.routes';
import { AdminRoutes } from './modules/admin/route/admin.routes';
import { AccessDeniedComponent } from './components/base/access-denied/access-denied.component';
import { adminGuard } from './core/guard/admin.guard';
import { authorGuard } from './core/guard/author.guard';
import { HeaderComponent } from './components/base/header/header.component';
import { LogInRoute } from './modules/logIn/route/login.routes';

export const routes: Routes = [
    {
        path: '',
        redirectTo: 'account/login',
        pathMatch: 'full'
    },
    {
        path: 'account',
        children: LogInRoute,
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
