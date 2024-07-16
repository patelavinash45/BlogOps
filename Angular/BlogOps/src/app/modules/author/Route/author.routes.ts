import { Routes } from "@angular/router"
import { DashboardComponent } from "../components/dashboard/dashboard.component"
import { NewBlogComponent } from "../components/new-blog/new-blog.component"

export const AuthorRoutes: Routes = [
    {
        path: 'dashboard',
        component: DashboardComponent
    },
    {
        path: 'new-blog',
        component: NewBlogComponent
    },
    {
        path: 'edit-blog/:blogId',
        component: NewBlogComponent,
    }
]