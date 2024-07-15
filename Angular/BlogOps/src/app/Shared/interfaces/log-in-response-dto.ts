import { RoleEnum } from "../enums/role-enum";

export interface LogInResponseDto {
    email: string,
    jwtToken: string,
    firstName: string,
    lastName: string,
    roleType: RoleEnum
}
