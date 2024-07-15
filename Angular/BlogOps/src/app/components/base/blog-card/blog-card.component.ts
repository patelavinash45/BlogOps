import { Component, Input, input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Blog } from '../../../shared/interfaces/blog';
import { EnumIntToValuePipe } from '../../../core/pipe/enum-int-to-value.pipe';
import { BlogStatus } from '../../../shared/enums/blog-status';

@Component({
  selector: 'app-blog-card',
  standalone: true,
  imports: [CommonModule, EnumIntToValuePipe],
  templateUrl: './blog-card.component.html',
  styleUrl: './blog-card.component.css'
})
export class BlogCardComponent {
  @Input() blogs: Blog[] = [];
}
