
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://localhost:3000/';

  constructor(private http: HttpClient) { }

  // Example methods for API calls
 
  // Add more methods as needed for your API endpoints
}