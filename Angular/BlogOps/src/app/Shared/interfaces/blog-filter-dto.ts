import { BlogStatus } from "../enums/blog-status";

export interface BlogFilterDto {
    status: BlogStatus ,
    searchContent : string | null,
    isAdmin : boolean,
    userId : number,
}
