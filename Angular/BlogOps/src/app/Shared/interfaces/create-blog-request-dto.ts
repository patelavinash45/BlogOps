export interface CreateBlogRequestDto {
    title: string | null,
    Content: string | null,
    isDraft: boolean,
    blogsCategoryIds: number[] | null,
}

