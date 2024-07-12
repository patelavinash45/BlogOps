import { BlogStatus } from "../enums/blog-status";

export interface Blog {
    id : number,
    title: string | null,
    content: string | null,
    adminComment: string | null,
    status : BlogStatus | null,
    createdDate : string
}
