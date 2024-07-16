import { Component } from '@angular/core';
import { BlogCardComponent } from '../../../../components/base/blog-card/blog-card.component';
import { HeaderComponent } from '../../../../components/base/header/header.component';
import { DashboardService } from '../../service/dashboard.service';
import { RouterLink } from '@angular/router';
import { PaginationDto } from '../../../../shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../shared/enums/blog-status';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [BlogCardComponent, HeaderComponent, RouterLink],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  response!: PaginationDto;
  pageNo: number = 1;
  blogFilterDto: BlogFilterDto = {
    status: BlogStatus.All,
    searchContent: null,
  };

  constructor(private dashboardService: DashboardService) { }

  getDate() {
    this.dashboardService.GetBlogs(this.blogFilterDto, this.pageNo).subscribe((response: PaginationDto) => {
      this.response = response;
      console.log(this.response);
    });
  }

  ngOnInit(): void {
    this.getDate();
  };

  onSearchInputChange(event: any) {
    this.blogFilterDto.searchContent = event.target.value;
    this.getDate();
  }

  onStatusChange(event : any){
    this.blogFilterDto.status = event.target.value;
    this.getDate();
  }

}
