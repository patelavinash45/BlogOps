import { Routes } from '@angular/router';
import { DashboardComponent } from '../components/home/dashboard/dashboard.component';
import { ViewBlogComponent } from '../../../components/view-blog/view-blog.component';
import { AddEditBlogComponent } from '../../../components/add-edit-blog/add-edit-blog.component';
import { UserComponent } from '../components/user/dashboard/user.component';
import { AddEditUserComponent } from '../components/user/add-edit-user/add-edit-user.component';

export const AdminRoutes: Routes = [
    {
        path: 'dashboard',
        component: DashboardComponent
    },
    {
        path: 'blog',
        children: [
            {
                path: 'view/:blogId',
                component: ViewBlogComponent
            },
            {
                path: 'new',
                component: AddEditBlogComponent
            },
        ]
    },
    {
        path: 'user',
        children: [
            {
                path: '',
                component: UserComponent
            },
            {
                path: 'view/:userId',
                component: AddEditUserComponent
            },
        ]
    },
]