import { Routes } from '@angular/router';
import { LogInComponent } from './modules/logIn/components/log-in/log-in.component';
import { AuthorRoutes } from './modules/author/route/author.routes';
import { authGuard } from './core/guard/auth.guard';
import { AdminRoutes } from './modules/admin/route/admin.routes';

export const routes: Routes = [
    {
        path: '',
        redirectTo: 'login',
        pathMatch: 'full'
    },
    {
        path: 'login',
        component: LogInComponent,
    },
    {
        path: 'admin',
        children: AdminRoutes,
        canActivateChild: [authGuard],
    },
    {
        path: 'author',
        children: AuthorRoutes,
        canActivateChild: [authGuard],
    }
];
