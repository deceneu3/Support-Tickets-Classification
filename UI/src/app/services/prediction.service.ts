import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import {ResponseDto} from '../dto/response';

@Injectable()
export class PredictionService {
  constructor(private httpClient: HttpClient) {

  }
  public prediction(data:string,method:string):Observable<ResponseDto>{
    return this.httpClient.post<ResponseDto>("http://localhost:5555/endava/api/v1.0/"+method, {description:data});
  }
}
