import { Routes } from '@angular/router';
import { DashboardComponent } from '../components/dashboard/dashboard.component';
import { ViewBlogComponent } from '../../../components/view-blog/view-blog.component';
import { AddEditBlogComponent } from '../../../components/add-edit-blog/add-edit-blog.component';
import { UserComponent } from '../components/user/dashboard/user.component';
import { AddEditUserComponent } from '../components/user/add-edit-user/add-edit-user.component';

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
    {
        path: 'manage-user',
        component: UserComponent
    },
    {
        path: 'manage-user/view/:userId',
        component: AddEditUserComponent
    },
]