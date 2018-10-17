import {Component, OnInit} from '@angular/core';
import {PredictionService} from './services/prediction.service';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {ResponseDto} from './dto/response';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  public selectedValue: any;
  public myForm: FormGroup;
  public result: ResponseDto;
  predictions: any[] = [
    {label: 'All', value: 'predictall'},
    {label: 'Ticket type', value: 'tickettype'},
    {label: 'Category', value: 'category'},
	{label: 'Business Service', value: 'business_service'}
  ];
  
  

  constructor(private predictionService: PredictionService, private _fb: FormBuilder) {

  }

  predict() {
    this.predictionService.prediction(this.myForm.get("text").value, this.selectedValue.value).subscribe(value => this.result = value,
      error => {

      });
  }

  clearP() {
    this.result = null;
  }

  ngOnInit(): void {
    this.myForm = this._fb.group({
      'text': [undefined, Validators.required]
    });
  }
}
