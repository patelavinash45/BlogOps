import { BlogStatus } from "../enums/blog-status";

export interface Blog {
    id: number,
    title: string,
    content: string,
    status: BlogStatus,
    adminComment: string | null,
    createdDate: string,
    blogCategories: number[],
    createdBy: string,
    updatedBy: string,
}
