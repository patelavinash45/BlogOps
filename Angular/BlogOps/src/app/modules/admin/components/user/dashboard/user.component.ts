import { Component } from '@angular/core';
import { HeaderComponent } from "../../../../../components/base/header/header.component";
import { UserService } from '../../../service/user.service';
import { UserDto } from '../../../../../shared/interfaces/user-dto';
import { UserFilterDto } from '../../../../../shared/interfaces/user-filter-dto';
import { EnumIntToValuePipe } from '../../../../../core/pipe/enum-int-to-value.pipe';
import { UserStatus } from '../../../../../shared/enums/user-status';
import { RoleType } from '../../../../../shared/enums/role-type';

@Component({
  selector: 'app-user',
  standalone: true,
  imports: [HeaderComponent, EnumIntToValuePipe],
  templateUrl: './user.component.html',
  styleUrl: './user.component.css'
})
export class UserComponent {
  users: UserDto[] = [];
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
}
