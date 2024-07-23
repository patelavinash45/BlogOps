import { AngularEditorConfig } from "@kolkov/angular-editor";

export const baseUrl = 'http://localhost:5014/api';

export const LogInSuccessMessage = "LogIn SuccessFully.";

export const BlogSaveMessage = "Blog Created SuccessFully.";

export const BlogUpdateMessage = "Blog Updated SuccessFully.";

export const statusWiseClasses: string[] = ['bg-primary text-white border-white', 'bg-success text-white border-white', 'bg-danger text-white border-white', 'bg-secondary text-white border-white', 'bg-warning text-black border-black'];

export const editorConfig: AngularEditorConfig = {
  editable: true,
  spellcheck: true,
  height: '15rem',
  maxHeight: '20rem',
  minHeight: '5rem',
  placeholder: 'Enter text here...',
  translate: 'no',
  defaultParagraphSeparator: 'p',
  defaultFontName: 'Arial',
  defaultFontSize: '4',
};

export const adminSideBarItems: string[][] = [
  ['Dashboard', '/admin/dashboard'],
  ['User', '/admin/user/'],
  ['Categories', '/admin/category'],
];

export const authorSideBarItems: string[][] = [
  ['Dashboard', '/author/dashboard'],
  ['Profile', '/author/manage-user'],
];

