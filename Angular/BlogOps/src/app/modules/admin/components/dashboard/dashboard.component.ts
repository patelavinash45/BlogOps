import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { PaginationDto } from '../../../../shared/interfaces/pagination-dto';
import { DashboardService } from '../../service/dashboard.service';
import { BlogFilterDto } from '../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../shared/enums/blog-status';
import { EnumIntToValuePipe } from '../../../../core/pipe/enum-int-to-value.pipe';
import { UserDto } from '../../../../shared/interfaces/user-dto';
import { CommonModule } from '@angular/common';
import { Blog } from '../../../../shared/interfaces/blog';
import { HeaderComponent } from "../../../../components/base/header/header.component";

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, RouterLink, EnumIntToValuePipe, HeaderComponent],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  response!: PaginationDto;
  pageNo: number = 1;
  users: UserDto[] = [];
  blogFilterDto: BlogFilterDto = {
    status: BlogStatus.All,
    searchContent: null,
    isAdmin: true,
    userId: 0
  };

  constructor(private dashboardService: DashboardService) { }

  getData() {
    this.dashboardService.GetBlogs(this.blogFilterDto, this.pageNo).subscribe((response: PaginationDto) => {
      this.response = response;
    });
  }

  ngOnInit(): void {
    this.getData();
    this.dashboardService.GetUsers().subscribe((response: UserDto[]) => {
      this.users = response;
    });
  }

  onSearchInputChange(event: any) {
    this.blogFilterDto.searchContent = event.target.value;
    this.getData();
  }

  onStatusChange(event: any) {
    this.blogFilterDto.status = event.target.value;
    this.getData();
  }

  onUserChange(event: any) {
    this.blogFilterDto.userId = event.target.value;
    this.getData();
  }

  onNextPageButtonClick() {
    this.pageNo++;
    this.getData();
  }

  onPreviousPageButtonClick() {
    this.pageNo--;
    this.getData();
  }

  onBlogStatusChange(blog: Blog, isApprove: boolean) {
    blog.status = isApprove ? BlogStatus.Approved : BlogStatus.Rejected;
    this.dashboardService.UpdateBlog(blog).subscribe((response)=>{
      this.getData();
    });
  }
}
