import { CategoryStatus } from "../enums/category-status";

export interface CategoriesFilterDto {
    searchContent : string | null,
    status : CategoryStatus,
}
