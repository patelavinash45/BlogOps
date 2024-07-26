import { CategoryStatus } from "../enums/category-status";

export interface CategoryDto {
    id: number,
    name: string,
    status: CategoryStatus
}
