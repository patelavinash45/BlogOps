import { Routes } from '@angular/router';
import { DashboardComponent } from '../components/dashboard/dashboard.component';
import { ViewBlogComponent } from '../../../components/view-blog/view-blog.component';
import { AddEditBlogComponent } from '../../../components/add-edit-blog/add-edit-blog.component';

export const AdminRoutes : Routes = [
    {
        path: 'dashboard',
        component: DashboardComponent
    },
    {
        path: 'view-blog:blogId',
        component: ViewBlogComponent
    },
    {
        path: 'new-blog',
        component: AddEditBlogComponent
    },
]