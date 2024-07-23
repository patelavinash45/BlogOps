import { Component, ViewChild, viewChild } from '@angular/core';
import { RouterLink, RouterModule } from '@angular/router';
import { PaginationDto } from '../../../../../shared/interfaces/pagination-dto';
import { BlogFilterDto } from '../../../../../shared/interfaces/blog-filter-dto';
import { BlogStatus } from '../../../../../shared/enums/blog-status';
import { EnumIntToValuePipe } from '../../../../../core/pipe/enum-int-to-value.pipe';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { CommonModule } from '@angular/common';
import { HomeService } from '../../../service/home.service';
import { RejectModalComponent } from "../reject-modal/reject-modal.component";
import { MatButtonModule } from '@angular/material/button';
import { MatExpansionModule } from '@angular/material/expansion';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    EnumIntToValuePipe,
    RejectModalComponent,
    MatButtonModule,
    MatExpansionModule,
  ],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  response!: PaginationDto;
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

  onFilterButtonClick(){
    this.isFilterOptionsExpended = !this.isFilterOptionsExpended;
  }
}
