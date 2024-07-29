import { Component, ViewChild } from '@angular/core';
import { RouterLink } from '@angular/router';
import { PaginationDto } from '../../../../../shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../../shared/enums/blog-status';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { CommonModule } from '@angular/common';
import { RejectModalComponent } from "../reject-modal/reject-modal.component";
import { MatButtonModule } from '@angular/material/button';
import { MatExpansionModule } from '@angular/material/expansion';
import { BlogStatusIntToValuePipe } from '../../../../../core/pipe/blog-status-int-to-value.pipe';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { StatusWiseClasses } from '../../../../../shared/constants/constant';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { BlogService } from '../../../service/blog.service';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { Blog } from '../../../../../shared/interfaces/blog';
import { MatSelectModule } from '@angular/material/select';
import { NgxMatSelectSearchModule } from 'ngx-mat-select-search';

@Component({
  selector: 'app-blog',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    RejectModalComponent,
    MatButtonModule,
    MatExpansionModule,
    BlogStatusIntToValuePipe,
    MatPaginatorModule,
    MatProgressBarModule,
    NgxSkeletonLoaderModule,
    MatSelectModule,
    NgxMatSelectSearchModule
  ],
  templateUrl: './blog.component.html',
  styleUrl: './blog.component.css'
})
export class BlogComponent {
  response!: PaginationDto<Blog>;
  statusWiseClasses: string[] = StatusWiseClasses;
  authors: UserDto[] = [];
  isFilterOptionsExpended: boolean = false;
  blogFilterDto: BlogFilterDto = {
    status: BlogStatus.All,
    searchContent: null,
    isAdmin: true,
    userId: 0,
    pageNo: 1,
    pageSize: 10,
  };
  @ViewChild(RejectModalComponent) rejectModal!: RejectModalComponent;

  constructor(private blogService: BlogService) { }

  getData() {
    this.blogService.GetBlogs(this.blogFilterDto).subscribe((response: PaginationDto<Blog>) => {
      this.response = response;
    });
  }

  ngOnInit(): void {
    this.getData();
    this.blogService.GetAllAuthors().subscribe((response: UserDto[]) => {
      this.authors = response;
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

  onBlogStatusChange(id: number, isApprove: boolean) {
    if (isApprove) {
      this.blogService.ChangeStatus(id, true, null).subscribe((response) => {
        this.getData();
      });
    }
    else {
      this.rejectModal.blogId = id;
    }
  }

  onFilterButtonClick() {
    this.isFilterOptionsExpended = !this.isFilterOptionsExpended;
  }

  changePage(event: PageEvent) {
    this.blogFilterDto.pageNo = event.pageIndex + 1;
    this.blogFilterDto.pageSize = event.pageSize;
    this.getData();
  }
}
