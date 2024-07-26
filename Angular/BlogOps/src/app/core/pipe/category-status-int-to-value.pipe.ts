import { Pipe, PipeTransform } from '@angular/core';
import { CategoryStatus } from '../../shared/enums/category-status';

@Pipe({
  name: 'categoryStatusIntToValue',
  standalone: true
})
export class CategoryStatusIntToValuePipe implements PipeTransform {

  transform(value: number): string {
    return CategoryStatus[value];
  }

}
