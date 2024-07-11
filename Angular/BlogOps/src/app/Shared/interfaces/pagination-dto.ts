import { Blog } from "./blog";

export interface PaginationDto {
    dtoList: Blog[],
    pageNo: number,
    totalBlogs: number
}
