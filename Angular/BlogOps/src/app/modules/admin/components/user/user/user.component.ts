import { Component } from '@angular/core';
import { UserService } from '../../../service/user.service';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { UserFilterDto } from '../../../../../shared/interfaces/user-filter-dto';
import { UserStatus } from '../../../../../shared/enums/user-status';
import { RoleType } from '../../../../../shared/enums/role-type';
import { MatButtonModule } from '@angular/material/button';
import { MatExpansionModule } from '@angular/material/expansion';
import { RouterLink } from '@angular/router';
import { UserStatusIntToValuePipe } from '../../../../../core/pipe/user-status-int-to-value.pipe';
import { UserStatusWiseClasses } from '../../../../../shared/constants/constant';
import { CommonModule } from '@angular/common';
import {MatProgressBarModule} from '@angular/material/progress-bar';

@Component({
  selector: 'app-user',
  standalone: true,
  imports: [
    UserStatusIntToValuePipe, 
    MatButtonModule, 
    MatExpansionModule, 
    RouterLink, 
    CommonModule,
    MatProgressBarModule,
  ],
  templateUrl: './user.component.html',
  styleUrl: './user.component.css'
})
export class UserComponent {
  users: UserDto[] = [];
  statusWiseClasses: string[] = UserStatusWiseClasses;
  isFilterOptionsExpended: boolean = false;
  userFilterDto: UserFilterDto = {
    status: UserStatus.All,
    searchContent: null,
    role: RoleType.All
  };

  constructor(private userService: UserService) { }

  getData() {
    this.userService.GetUsers(this.userFilterDto).subscribe((response: UserDto[]) => {
      this.users = response;
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

  onFilterButtonClick(){
    this.isFilterOptionsExpended = !this.isFilterOptionsExpended;
  }
}
