import { Component, Input } from '@angular/core';
import { AbstractControl } from '@angular/forms';

@Component({
  selector: 'app-validation-message',
  standalone: true,
  imports: [],
  templateUrl: './validation-message.component.html',
  styleUrl: './validation-message.component.css'
})
export class ValidationMessageComponent {
  @Input() control!: AbstractControl;

  shouldShowErrors(): boolean {
    return this.control && this.control.invalid && (this.control.dirty || this.control.touched);
  }

  hasError(errorCode: string): boolean {
    return this.control && this.control.hasError(errorCode);
  }

}
