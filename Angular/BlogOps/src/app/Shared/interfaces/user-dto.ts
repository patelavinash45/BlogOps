import { UserEnum } from "../enums/user-enum";

export interface UserDto {
    id: number,
    firstName: string,
    lastName: string,
    profileName: string | null,
    email: string,
    status: UserEnum
}
