import { UserStatus } from "../enums/user-status";

export interface UserDto {
    id: number,
    firstName: string,
    lastName: string,
    profileName: string | null,
    email: string,
    status: UserStatus,
    password: string | null,
}
