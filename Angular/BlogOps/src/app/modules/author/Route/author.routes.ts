import { Routes } from "@angular/router"
import { DashboardComponent } from "../components/dashboard/dashboard.component"
import { AddEditBlogComponent } from "../../../components/add-edit-blog/add-edit-blog.component"
import { ViewBlogComponent } from "../../../components/view-blog/view-blog.component"

export const AuthorRoutes: Routes = [
    {
        path: 'dashboard',
        component: DashboardComponent
    },
    {
        path: 'blog',
        children: [
            {
                path: 'new',
                component: AddEditBlogComponent
            },
            {
                path: 'edit/:blogId',
                component: AddEditBlogComponent,
            },
            {
                path: 'view/:blogId',
                component: ViewBlogComponent,
            }
        ]
    },
]