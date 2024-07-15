import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class ManageToastrService {

  constructor(private toasterService: ToastrService) { }

  showSuccess(toastMessage:string) {
    this.toasterService.success(toastMessage);
  }
}
