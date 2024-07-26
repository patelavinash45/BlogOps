import { AngularEditorConfig } from "@kolkov/angular-editor";
import { RoutePathConstant } from "./route-path.constant";

export const baseUrl = 'http://localhost:5014/api';

export const LogInSuccessMessage = "LogIn SuccessFully.";

export const BlogSaveMessage = "Blog Created SuccessFully.";

export const BlogUpdateMessage = "Blog Updated SuccessFully.";

export const SessionExpired = "Session is Expired."

export const StatusWiseClasses: string[] = ['bg-primary text-white border-white', 'bg-success text-white border-white', 'bg-danger text-white border-white', 'bg-secondary text-white border-white', 'bg-warning text-black border-black'];

export const UserStatusWiseClasses: string[] = ['bg-success text-white border-white', 'bg-warning text-black border-black', 'bg-danger text-white border-white'];

export const editorConfig: AngularEditorConfig = {
  editable: true,
  spellcheck: true,
  height: '23rem',
  maxHeight: '23rem',
  minHeight: '5rem',
  placeholder: 'Enter text here...',
  translate: 'no',
  defaultParagraphSeparator: 'p',
  defaultFontName: 'Arial',
  defaultFontSize: '4',
};

export const adminSideBarItems: string[][] = [
  ['Dashboard', RoutePathConstant.AdminDashboardPath],
  ['Blog', RoutePathConstant.AdminBlogPath],
  ['User', RoutePathConstant.AdminUserPath],
  ['Categories', RoutePathConstant.AdminCategoryPath],
];

export const authorSideBarItems: string[][] = [
  ['Dashboard', RoutePathConstant.AuthorDashboardPath],
  ['Profile', '/author/manage-user'],
];

