/* eslint-disable class-methods-use-this */
import { Controller } from '@hotwired/stimulus';

export default class CompleteController extends Controller {
  updateProgress() {
    const event = new CustomEvent('update-progress', { bubbles: true });
    window.dispatchEvent(event);
  }
}
