import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Blog } from '../../../shared/interfaces/blog';
import { RouterLink } from '@angular/router';
import { StatusWiseClasses } from '../../../shared/constants/constant';

@Component({
  selector: 'app-blog-card',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './blog-card.component.html',
  styleUrl: './blog-card.component.css'
})
export class BlogCardComponent {
[x: string]: any;
  @Input() blogs: Blog[] = [];
  statusWiseClasses: string[] = StatusWiseClasses;
}
