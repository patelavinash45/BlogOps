import { Breakpoints } from "@angular/cdk/layout";
import { RoutePathConstant } from "./route-path.constant";

export const baseUrl = 'http://localhost:5014/api';

export const LogInSuccessMessage = "LogIn Successfully.";

export const BlogSaveMessage = "Blog Created Successfully.";

export const BlogUpdateMessage = "Blog Updated Successfully.";

export const SessionExpired = "Session is Expired.";

export const AccountCreated = "Account Created Successfully.";

export const AccountVerify = "Account Verify Successfully.";

export const InValidLink = "InValid Link";

export const EmailVerifyText1 = "Please click the button below to confirm your email address and activate your account";

export const EmailVerifyText2 = "If you received this in error, simply ignore this email and do not click the button.";

export const StatusWiseClasses: string[] = ['bg-primary text-white border-white', 'bg-success text-white border-white', 'bg-danger text-white border-white', 'bg-secondary text-white border-white', 'bg-warning text-black border-black'];

export const UserStatusWiseClasses: string[] = ['bg-success text-white border-white', 'bg-warning text-black border-black', 'bg-danger text-white border-white'];

export const editorConfig = {
  base_url: '/tinymce',
  suffix: '.min',
  plugins: 'lists link image table code help wordcount'
}

export const adminSideBarItems: string[][] = [
  ['Dashboard', RoutePathConstant.AdminDashboardPath, '<i class="fa-solid fa-house-chimney"></i>'],
  ['Blog', RoutePathConstant.AdminBlogPath, '<i class="fa-brands fa-blogger-b"></i>'],
  ['User', RoutePathConstant.AdminUserPath, '<i class="fa-solid fa-user-group"></i>'],
  ['Categories', RoutePathConstant.AdminCategoryPath, '<i class="fa-solid fa-table-list"></i>'],
];

export const authorSideBarItems: string[][] = [
  ['Dashboard', RoutePathConstant.AuthorDashboardPath, '<i class="fa-solid fa-house-chimney"></i>'],
  ['Profile', '/author/manage-user', '<i class="fa-solid fa-user"></i>'],
];

export const largeDisplay: string[] = [
  Breakpoints.Medium,
  Breakpoints.Large,
  Breakpoints.XLarge,
  Breakpoints.Web,
  Breakpoints.WebPortrait,
  Breakpoints.TabletLandscape,
  Breakpoints.WebLandscape,
];

export const displayForWelcomeText: string[] = [
  Breakpoints.XSmall,
  Breakpoints.Small,
  Breakpoints.Handset,
  Breakpoints.Tablet,
  Breakpoints.TabletPortrait,
  Breakpoints.HandsetPortrait,
  Breakpoints.HandsetLandscape,
];


