import { Routes } from "@angular/router";
import { LogInComponent } from "../components/log-in/log-in.component";
import { SignUpComponent } from "../components/sign-up/sign-up.component";
import { EmailVerifyComponent } from "../components/email-verify/email-verify.component";
import { loginGuard } from "../../../core/guard/login.guard";

export const LogInRoute: Routes = [
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
        path: 'email-verify/:token',
        component: EmailVerifyComponent,
    },
]