import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class ManageToastrService {

  constructor(private toasterService: ToastrService) { }

  ShowSuccess(toastMessage:string) {
    this.toasterService.success(toastMessage);
  }

  ShowError(toastMessage:string) {
    this.toasterService.error(toastMessage);
  }
}
