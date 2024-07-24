import { Pipe, PipeTransform } from '@angular/core';
import { UserStatus } from '../../shared/enums/user-status';

@Pipe({
  name: 'userStatusIntToValue',
  standalone: true
})
export class UserStatusIntToValuePipe implements PipeTransform {

  transform(value: number): string {
    return UserStatus[value];
  }

}
