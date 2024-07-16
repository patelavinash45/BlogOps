import { AngularEditorConfig } from "@kolkov/angular-editor";

export const baseUrl = 'http://localhost:5014/api';

export const LogInSuccessMessage = "LogIn SuccessFully.";

export const BlogSaveMessage = "Blog Created SuccessFully.";

export const editorConfig: AngularEditorConfig =  {
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

 