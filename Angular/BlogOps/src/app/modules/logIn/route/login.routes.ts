import { Routes } from "@angular/router";
import { LogInComponent } from "../components/log-in/log-in.component";
import { SignUpComponent } from "../components/sign-up/sign-up.component";
import { EmailVerifyComponent } from "../components/email-verify/email-verify.component";

export const LogInRoute: Routes = [
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
        path: 'signup',
        component: SignUpComponent,
    },
    {
        path: 'email-verify/:token',
        component: EmailVerifyComponent,
    },
]