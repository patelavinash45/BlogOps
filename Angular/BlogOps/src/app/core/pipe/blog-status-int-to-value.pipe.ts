import { Pipe, PipeTransform } from '@angular/core';
import { BlogStatus } from '../../shared/enums/blog-status';

@Pipe({
  name: 'blogStatusIntToValue',
  standalone: true
})
export class BlogStatusIntToValuePipe implements PipeTransform {

  transform(value: number): string {
    return BlogStatus[value];
  }

}
