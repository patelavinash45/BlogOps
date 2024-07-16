export interface UpdateBlogRequestDto {
    id: number,
    title: string,
    content: string,
    isDraft: boolean,
    adminComment: string | null,
    blogCategories: number[] | null,
}
