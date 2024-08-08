import { Controller } from '@hotwired/stimulus';
import tippy from 'tippy.js';
import 'tippy.js/dist/tippy.css';

export default class TooltipController extends Controller {
  static values = { message: String };

  connect() {
    this.tippyInstance = tippy(this.element, {
      content: this.messageValue,
    });
  }

  destroy() {
    this.tippyInstance.destroy();
  }
}
