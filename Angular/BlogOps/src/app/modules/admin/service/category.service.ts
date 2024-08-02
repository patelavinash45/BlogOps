import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CategoriesFilterDto } from '../../../shared/interfaces/categories-filter-dto';
import { Observable } from 'rxjs';
import { CategoryDto } from '../../../shared/interfaces/category-dto';
import { baseUrl } from '../../../shared/constants/constant';
import { CreateCategoryRequestDto } from '../../../shared/interfaces/create-category-request-dto';
import { PaginationDto } from '../../../shared/interfaces/pagination-dto';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private httpClient: HttpClient) { }

  public GetCategories(categoriesFilterDto: CategoriesFilterDto): Observable<PaginationDto<CategoryDto>> {
    return this.httpClient.post<PaginationDto<CategoryDto>>(`${baseUrl}/categories/filter`, categoriesFilterDto);
  }

  public AddCategory(createCategoryRequestDto: CreateCategoryRequestDto): Observable<void>{
    return this.httpClient.post<void>(`${baseUrl}/categories`, createCategoryRequestDto);
  } 

  public UpdateCategory(categoryDto: CategoryDto): Observable<void>{
    return this.httpClient.put<void>(`${baseUrl}/categories/${categoryDto.id}`, categoryDto);
  } 

  public CategoryExist(name: string): Observable<boolean> {
    return this.httpClient.get<boolean>(`${baseUrl}/categories/category-exist/${name}`);
  }
}
