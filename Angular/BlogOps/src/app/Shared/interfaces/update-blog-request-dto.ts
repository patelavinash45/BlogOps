import { BlogStatus } from "../enums/blog-status";

export interface UpdateBlogRequestDto {
    id: number,
    title: string,
    content: string,
    status: BlogStatus,
    adminComment: string | null,
    blogCategories: number[] | null,
}
