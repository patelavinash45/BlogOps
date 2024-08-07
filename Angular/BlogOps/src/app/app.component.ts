import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { EmailVerifyComponent } from "./modules/logIn/components/email-verify/email-verify.component";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, EmailVerifyComponent],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'BlogOps';
}
