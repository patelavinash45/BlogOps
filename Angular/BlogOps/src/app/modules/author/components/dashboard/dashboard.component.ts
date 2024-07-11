import { Component } from '@angular/core';
import { BlogCardComponent } from '../../../../components/base/blog-card/blog-card.component';
import { HeaderComponent } from '../../../../components/base/header/header.component';
import { DashboardService } from '../../service/dashboard.service';
import { PaginationDto } from '../../../../Shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../Shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../Shared/Enums/blog-status';
import { Blog } from '../../../../Shared/interfaces/blog';


@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [BlogCardComponent, HeaderComponent],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  response!: PaginationDto;
  pageNo: number = 1;
  blogFilterDto: BlogFilterDto = {
    status: null,
    searchContent: null,
  };

  constructor(private dashboardService: DashboardService) { }

  ngOnInit(): void {
    this.dashboardService.GetBlogs(this.blogFilterDto, this.pageNo).subscribe((response: PaginationDto) => {
      this.response = response;
      console.log(this.response);
    })
  }
}
