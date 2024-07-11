import { BlogStatus } from "../Enums/blog-status";

export interface BlogFilterDto {
    status: BlogStatus | null,
    searchContent : string | null,
}
