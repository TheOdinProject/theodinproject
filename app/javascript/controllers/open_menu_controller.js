import { Controller } from '@hotwired/stimulus';

export default class OpenMenuController extends Controller {
  static outlets = ['visibility'];

  open() {
    this.visibilityOutlet.on();
  }
}
