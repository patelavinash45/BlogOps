import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Blog } from '../../../shared/interfaces/blog';
import { EnumIntToValuePipe } from '../../../core/pipe/enum-int-to-value.pipe';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-blog-card',
  standalone: true,
  imports: [CommonModule, EnumIntToValuePipe, RouterLink],
  templateUrl: './blog-card.component.html',
  styleUrl: './blog-card.component.css'
})
export class BlogCardComponent {
  @Input() blogs: Blog[] = [];
  borderColors: string[] = ['bg-success text-white', 'bg-primary text-white', 'bg-success text-white', 'bg-secondary text-white', 'bg-warning text-black']
}
