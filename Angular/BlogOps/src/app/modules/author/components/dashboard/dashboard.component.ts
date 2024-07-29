import { Component } from '@angular/core';
import { BlogCardComponent } from '../../../../components/base/blog-card/blog-card.component';
import { DashboardService } from '../../service/dashboard.service';
import { RouterLink } from '@angular/router';
import { PaginationDto } from '../../../../shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../shared/enums/blog-status';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { Blog } from '../../../../shared/interfaces/blog';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, BlogCardComponent, RouterLink, NgxSkeletonLoaderModule, MatButtonModule, MatPaginator ],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  response!: PaginationDto<Blog>;
  blogFilterDto: BlogFilterDto = {
    status: BlogStatus.All,
    searchContent: null,
    isAdmin: false,
    userId: 0,
    pageNo: 1,
    pageSize: 9,
  };

  constructor(private dashboardService: DashboardService) { }

  getData() {
    this.dashboardService.GetBlogs(this.blogFilterDto).subscribe((response: PaginationDto<Blog>) => {
      console.log(response);
      this.response = response;
    });
  }

  ngOnInit(): void {
    this.getData();
  };

  onSearchInputChange(event: any) {
    this.blogFilterDto.searchContent = event.target.value;
    this.getData();
  }

  onStatusChange(event: any) {
    this.blogFilterDto.status = event.target.value;
    this.getData();
  }

  changePage(event: PageEvent) {
    this.blogFilterDto.pageNo = event.pageIndex + 1;
    this.blogFilterDto.pageSize = event.pageSize;
    this.getData();
  }

}
