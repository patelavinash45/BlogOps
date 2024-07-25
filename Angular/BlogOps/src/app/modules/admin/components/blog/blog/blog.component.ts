import { Component, ViewChild, viewChild } from '@angular/core';
import { RouterLink } from '@angular/router';
import { PaginationDto } from '../../../../../shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../../shared/enums/blog-status';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { CommonModule } from '@angular/common';
import { HomeService } from '../../../service/home.service';
import { RejectModalComponent } from "../reject-modal/reject-modal.component";
import { MatButtonModule } from '@angular/material/button';
import { MatExpansionModule } from '@angular/material/expansion';
import { BlogStatusIntToValuePipe } from '../../../../../core/pipe/blog-status-int-to-value.pipe';
import { MatPaginatorModule } from '@angular/material/paginator';
import { StatusWiseClasses } from '../../../../../shared/constants/constant';
import {MatProgressBarModule} from '@angular/material/progress-bar';

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
  ],
  templateUrl: './blog.component.html',
  styleUrl: './blog.component.css'
})
export class BlogComponent {
  response!: PaginationDto;
  statusWiseClasses: string[] = StatusWiseClasses;
  pageNo: number = 1;
  authors: UserDto[] = [];
  isFilterOptionsExpended: boolean = false;
  blogFilterDto: BlogFilterDto = {
    status: BlogStatus.All,
    searchContent: null,
    isAdmin: true,
    userId: 0
  };
  @ViewChild(RejectModalComponent) rejectModal!: RejectModalComponent;

  constructor(private homeService: HomeService) { }

  getData() {
    this.homeService.GetBlogs(this.blogFilterDto, this.pageNo).subscribe((response: PaginationDto) => {
      this.response = response;
      console.log(this.response)
    });
  }

  ngOnInit(): void {
    this.getData();
    this.homeService.GetAllAuthors().subscribe((response: UserDto[]) => {
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

  onNextPageButtonClick() {
    this.pageNo++;
    this.getData();
  }

  onPreviousPageButtonClick() {
    this.pageNo--;
    this.getData();
  }

  onBlogStatusChange(id: number, isApprove: boolean) {
    if (isApprove) {
      this.homeService.ChangeStatus(id, true, null).subscribe((response) => {
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
}
