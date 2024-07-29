import { RoleType } from "../enums/role-type";
import { UserStatus } from "../enums/user-status";

export interface UserFilterDto {
    status: UserStatus,
    searchContent: string | null,
    role: RoleType,
    pageNo: number,
    pageSize: number,
}
