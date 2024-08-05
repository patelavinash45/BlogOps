import { RoleType } from "../enums/role-type";
import { UserStatus } from "../enums/user-status";

export interface CreateUserRequestDto {
    email: string,
    password: string,
    firstName: string,
    lastName: string,
    profileName: string | null,
    role: RoleType,
    status: UserStatus,
}
