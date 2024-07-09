import { Controller } from '@hotwired/stimulus';
import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.css';

export default class DatePicker extends Controller {
  static values = {
    min: String,
    max: String,
  };

  connect() {
    this.picker = flatpickr(
      this.element,
      {
        altInput: true,
        altFormat: 'F j, Y',
        dateFormat: 'Y-m-d',
        defaultDate: this.element.value,
        minDate: this.minValue,
        maxDate: this.maxValue,
      },
    );
  }

  disconnect() {
    this.picker.destroy();
  }
}
