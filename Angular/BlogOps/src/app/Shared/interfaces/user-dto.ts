import { RoleType } from "../enums/role-type";
import { UserStatus } from "../enums/user-status";

export interface UserDto {
    id: number,
    firstName: string,
    lastName: string,
    profileName: string | null,
    email: string,
    status: UserStatus,
    role: RoleType,
    password: string | null,
}
