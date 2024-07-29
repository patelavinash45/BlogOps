export interface PaginationDto<T> {
    dtoList: T[],
    pageNo: number,
    totalCount: number,
    isNext: boolean,
    isPrevious: boolean,
}
