import { Pipe, PipeTransform } from '@angular/core';
import { BlogStatus } from '../../shared/enums/blog-status';

@Pipe({
  name: 'enumIntToValue',
  standalone: true
})
export class EnumIntToValuePipe implements PipeTransform {

  transform(value: number, enumType: any): any {
    return Object.values(enumType)[value];
  }

}
