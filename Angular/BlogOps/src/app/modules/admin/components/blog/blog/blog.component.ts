import { Component, Input, ViewChild } from '@angular/core';
import { RouterLink } from '@angular/router';
import { PaginationDto } from '../../../../../shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../../shared/enums/blog-status';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { CommonModule } from '@angular/common';
import { RejectModalComponent } from "../reject-modal/reject-modal.component";
import { MatButtonModule } from '@angular/material/button';
import { BlogStatusIntToValuePipe } from '../../../../../core/pipe/blog-status-int-to-value.pipe';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { largeDisplay, StatusWiseClasses } from '../../../../../shared/constants/constant';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { BlogService } from '../../../service/blog.service';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { Blog } from '../../../../../shared/interfaces/blog';
import { UserFilterDto } from '../../../../../shared/interfaces/user-filter-dto';
import { UserStatus } from '../../../../../shared/enums/user-status';
import { RoleType } from '../../../../../shared/enums/role-type';
import { NgSelectModule } from '@ng-select/ng-select';
import { debounceTime, distinctUntilChanged, map, Observable, shareReplay, Subject } from 'rxjs';
import { BreakpointObserver } from '@angular/cdk/layout';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-blog',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    MatButtonModule,
    BlogStatusIntToValuePipe,
    MatPaginatorModule,
    MatProgressBarModule,
    NgxSkeletonLoaderModule,
    NgSelectModule,
    MatExpansionModule
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
    pageSize: 10,
  };
  userFilterDto: UserFilterDto = {
    status: UserStatus.Active,
    searchContent: null,
    role: RoleType.Author,
    pageNo: 1,
    pageSize: 7,
  };
  userSearchInput$ = new Subject<string>();

  constructor(private blogService: BlogService, private breakObserver: BreakpointObserver, private modal: MatDialog,) { }

  isLargeDevice$: Observable<boolean> = this.breakObserver.observe(largeDisplay).pipe(
    map(result => result.matches),
    shareReplay()
  );

  getData() {
    this.blogService.GetBlogs(this.blogFilterDto).subscribe({
      next: (response: PaginationDto<Blog>) => {
        this.blogResponse = response;
      }
    });
  }

  getUserData() {
    this.blogService.GetAllAuthors(this.userFilterDto).subscribe({
      next: (response: PaginationDto<UserDto>) => {
        this.authorResponse = response;
        this.selectSearchAuthors = [...this.selectSearchAuthors, ...response.dtoList];
      }
    });
  }

  ngOnInit(): void {
    this.getData();
    this.getUserData();
    this.userSearchInput$.pipe(debounceTime(300), distinctUntilChanged()).subscribe((searchInput) => {
      this.selectSearchAuthors = [];
      this.userFilterDto.pageNo = 1;
      this.userFilterDto.searchContent = searchInput;
      this.getUserData();
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
    if (event == undefined) {
      this.blogFilterDto.userId = 0;
    }
    else {
      this.blogFilterDto.userId = event.id;
    }
    this.getData();
  }

  onOptionScroll() {
    if (this.authorResponse.isNext) {
      this.userFilterDto.pageNo++;
      this.getUserData();
    }
  }

  onBlogStatusChange(id: number, isApprove: boolean) {
    const dialogRef = this.modal.open(RejectModalComponent, {
      width: '500px',
      data: {
        blogId: id,
        isApprove: isApprove,
      },
    });
    dialogRef.afterClosed().subscribe(() => this.getData());
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
