export interface CreateBlogRequestDto {
    title: string,
    Content: string,
    isDraft: boolean,
    blogsCategories: number[] | null,
}

