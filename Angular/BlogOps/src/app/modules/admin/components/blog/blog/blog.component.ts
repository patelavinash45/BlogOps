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
import { MatAutocomplete, MatOption } from '@angular/material/autocomplete';
import { UserFilterDto } from '../../../../../shared/interfaces/user-filter-dto';
import { UserStatus } from '../../../../../shared/enums/user-status';
import { RoleType } from '../../../../../shared/enums/role-type';
import { NgSelectModule } from '@ng-select/ng-select';

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
    NgSelectModule,
    MatOption
  ],
  templateUrl: './blog.component.html',
  styleUrl: './blog.component.css'
})
export class BlogComponent {
  blogResponse!: PaginationDto<Blog>;
  statusWiseClasses: string[] = StatusWiseClasses;
  authorResponse!: PaginationDto<UserDto>;
  selectSearchAuthors: UserDto[] = [];
  isFilterOptionsExpended: boolean = false;
  blogFilterDto: BlogFilterDto = {
    status: BlogStatus.All,
    searchContent: null,
    isAdmin: true,
    userId: 0,
    pageNo: 1,
    pageSize: 5,
  };
  userFilterDto: UserFilterDto = {
    status: UserStatus.Active,
    searchContent: null,
    role: RoleType.Author,
    pageNo: 1,
    pageSize: 20,
  };
  @ViewChild(RejectModalComponent) rejectModal!: RejectModalComponent;
  @ViewChild(MatAutocomplete) matAutoComplete!: MatAutocomplete;

  constructor(private blogService: BlogService) { }

  getData() {
    this.blogService.GetBlogs(this.blogFilterDto).subscribe((response: PaginationDto<Blog>) => {
      this.blogResponse = response;
    });
  }

  getUserData() {
    this.blogService.GetAllAuthors(this.userFilterDto).subscribe((response: PaginationDto<UserDto>) => {
      this.authorResponse = response;
      this.selectSearchAuthors = [...this.selectSearchAuthors,...response.dtoList];
    });
  }

  ngOnInit(): void {
    this.getData();
    this.getUserData();
  }

  onSearchInputChange(event: any) {
    this.blogFilterDto.searchContent = event.target.value;
    this.getData();
  }

  onStatusChange(event: any) {
    this.blogFilterDto.status = event.target.value;
    this.getData();
  }

  onUserChange(userId: number) {
    this.blogFilterDto.userId = userId;
    this.getData();
  }

  onUserSearch(event: any) {
    this.selectSearchAuthors = [];
    this.userFilterDto.searchContent = event.target.value;
    this.getUserData();
  }

  onOptionScroll() {
    console.log("event")
    
    // if (this.authorResponse.isNext) {
    //   this.authorResponse.pageNo++;
    //   this.getUserData();
    // }
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
