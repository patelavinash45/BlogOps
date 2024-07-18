import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Blog } from '../../../shared/interfaces/blog';
import { EnumIntToValuePipe } from '../../../core/pipe/enum-int-to-value.pipe';
import { RouterLink } from '@angular/router';
import { statusWiseClasses } from '../../../shared/constants/constant';

@Component({
  selector: 'app-blog-card',
  standalone: true,
  imports: [CommonModule, EnumIntToValuePipe, RouterLink],
  templateUrl: './blog-card.component.html',
  styleUrl: './blog-card.component.css'
})
export class BlogCardComponent {
  @Input() blogs: Blog[] = [];
  statusWiseClasses: string[] = statusWiseClasses;
}
