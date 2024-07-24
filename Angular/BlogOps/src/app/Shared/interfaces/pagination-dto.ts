import { Blog } from "./blog";

export interface PaginationDto {
    dtoList: Blog[],
    pageNo: number,
    totalCount: number,
    isNext: boolean,
    isPrevious: boolean,
}
