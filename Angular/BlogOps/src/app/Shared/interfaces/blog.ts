import { BlogStatus } from "../enums/blog-status";

export interface Blog {
    id: number,
    title: string,
    content: string,
    adminComment: string | null,
    status: BlogStatus,
    createdDate: string,
    blogCategories: number[],
}
