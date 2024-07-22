import { Component } from '@angular/core';
import { BlogCardComponent } from '../../../../components/base/blog-card/blog-card.component';
import { DashboardService } from '../../service/dashboard.service';
import { RouterLink } from '@angular/router';
import { PaginationDto } from '../../../../shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../shared/enums/blog-status';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { CommonModule } from '@angular/common';
import { HeaderComponent } from "../../../../components/base/header/header.component";
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, BlogCardComponent, RouterLink, NgxSkeletonLoaderModule, HeaderComponent, MatButtonModule ],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  response!: PaginationDto;
  loopArray: number[] = Array.from({ length: 9 });
  pageNo: number = 1;
  blogFilterDto: BlogFilterDto = {
    status: BlogStatus.All,
    searchContent: null,
    isAdmin: false,
    userId: 0
  };

  constructor(private dashboardService: DashboardService) { }

  getData() {
    this.dashboardService.GetBlogs(this.blogFilterDto, this.pageNo).subscribe((response: PaginationDto) => {
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

  onNextPageButtonClick() {
    this.pageNo++;
    this.getData();
  }

  onPreviousPageButtonClick(){
    this.pageNo--;
    this.getData();
  }

}
