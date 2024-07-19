import { RoleType } from "../enums/role-type";

export interface LogInResponseDto {
    email: string,
    jwtToken: string,
    firstName: string,
    lastName: string,
    roleType: RoleType
}
