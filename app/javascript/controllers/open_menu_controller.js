import { Controller } from '@hotwired/stimulus';

export default class OpenMenuController extends Controller {
  static outlets = ['mobile-menu'];

  open() {
    this.mobileMenuOutlet.open();
  }
}
