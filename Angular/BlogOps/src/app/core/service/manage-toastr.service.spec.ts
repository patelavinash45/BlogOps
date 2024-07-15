import { TestBed } from '@angular/core/testing';

import { ManageToastrService } from './manage-toastr.service';

describe('ManageToastrService', () => {
  let service: ManageToastrService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ManageToastrService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
