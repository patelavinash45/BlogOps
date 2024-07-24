import { Routes } from '@angular/router';
import { ViewBlogComponent } from '../../../components/view-blog/view-blog.component';
import { AddEditBlogComponent } from '../../../components/add-edit-blog/add-edit-blog.component';
import { UserComponent } from '../components/user/user/user.component';
import { AddEditUserComponent } from '../components/user/add-edit-user/add-edit-user.component';
import { BlogComponent } from '../components/blog/blog/blog.component';

export const AdminRoutes: Routes = [
    {
        path: 'blog',
        children: [
            {
                path: '',
                component: BlogComponent,
            },
            {
                path: 'view/:blogId',
                component: ViewBlogComponent,
            },
            {
                path: 'new',
                component: AddEditBlogComponent,
            },
        ]
    },
    {
        path: 'user',
        children: [
            {
                path: '',
                component: UserComponent,
            },
            {
                path: 'new',
                component: AddEditUserComponent,
            },
            {
                path: 'view/:userId',
                component: AddEditUserComponent,
            },
            {
                path: 'edit/:userId',
                component: AddEditUserComponent,
            },
        ]
    },
]