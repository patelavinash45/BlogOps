import { TestBed } from '@angular/core/testing';

import { ManageCookieService } from './manage-cookie.service';

describe('ManageCookieService', () => {
  let service: ManageCookieService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ManageCookieService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
