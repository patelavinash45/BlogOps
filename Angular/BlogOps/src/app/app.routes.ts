import { Routes } from '@angular/router';
import { LogInComponent } from './modules/logIn/components/log-in/log-in.component';
import { AuthorRoutes } from './modules/author/Route/author.routes';
import { authGuard } from './core/guard/auth.guard';

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
        path: 'author',
        children: AuthorRoutes,
        canActivateChild: [authGuard]
    }
];
