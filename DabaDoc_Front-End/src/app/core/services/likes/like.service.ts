import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';
import {devEnvironment} from '../../../../environments/environment';

interface LikeDataResponse {
    status: string,
    message: string,
}

@Injectable({
  providedIn: 'root'
})
export class LikesService{
    private apiUrl: string = devEnvironment.apiUrl;
    private likeEndpoint: string = `${this.apiUrl}/like`;
    
    constructor(private http: HttpClient) {}
    
    // Toggle like status for an item
    toggleLike(itemId: string , token: string): Observable<LikeDataResponse> {
        const headers = new HttpHeaders({'Authorization': token});
        return this.http.post<LikeDataResponse>(this.likeEndpoint, {question_id: itemId } , { headers: headers }).pipe(
            catchError(this.handleError)
          )
    }

    private handleError(error: any): Observable<never> {
        console.error('An error occurred:', error);
        throw new Error('Something bad happened; please try again later.');
    }
}