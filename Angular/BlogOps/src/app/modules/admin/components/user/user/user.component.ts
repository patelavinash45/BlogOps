import { Component } from '@angular/core';
import { UserService } from '../../../service/user.service';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { UserFilterDto } from '../../../../../shared/interfaces/user-filter-dto';
import { UserStatus } from '../../../../../shared/enums/user-status';
import { RoleType } from '../../../../../shared/enums/role-type';
import { MatButtonModule } from '@angular/material/button';
import { RouterLink } from '@angular/router';
import { UserStatusIntToValuePipe } from '../../../../../core/pipe/user-status-int-to-value.pipe';
import { UserStatusWiseClasses } from '../../../../../shared/constants/constant';
import { CommonModule } from '@angular/common';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { PaginationDto } from '../../../../../shared/interfaces/pagination-dto';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';

@Component({
  selector: 'app-user',
  standalone: true,
  imports: [
    UserStatusIntToValuePipe,
    MatButtonModule,
    RouterLink,
    CommonModule,
    MatProgressBarModule,
    NgxSkeletonLoaderModule,
    MatPaginatorModule
  ],
  templateUrl: './user.component.html',
  styleUrl: './user.component.css'
})
export class UserComponent {
  userResponse!: PaginationDto<UserDto>;
  statusWiseClasses: string[] = UserStatusWiseClasses;
  isFilterOptionsExpended: boolean = false;
  userFilterDto: UserFilterDto = {
    status: UserStatus.All,
    searchContent: null,
    role: RoleType.All,
    pageNo: 1,
    pageSize: 5,
  };

  constructor(private userService: UserService) { }

  getData() {
    this.userService.GetUsers(this.userFilterDto).subscribe((response: PaginationDto<UserDto>) => {
      this.userResponse = response;
    });
  }

  ngOnInit(): void {
    this.getData();
  }

  onSearchInputChange(event: any) {
    this.userFilterDto.searchContent = event.target.value;
    this.getData();
  }

  onStatusChange(event: any) {
    this.userFilterDto.status = event.target.value;
    this.getData();
  }

  onRoleChange(event: any) {
    this.userFilterDto.role = event.target.value;
    this.getData();
  }

  onFilterButtonClick() {
    this.isFilterOptionsExpended = !this.isFilterOptionsExpended;
  }

  changePage(event: PageEvent) {
    this.userFilterDto.pageNo = event.pageIndex + 1;
    this.userFilterDto.pageSize = event.pageSize;
    this.getData();
  }
}
