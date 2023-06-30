/* eslint-disable class-methods-use-this */
import { Controller } from '@hotwired/stimulus';
import { enter, leave } from 'el-transition';

export default class ModalController extends Controller {
  static targets = ['transitionable'];

  connect() {
    this.lockScroll();
    this.transitionableTargets.forEach((element) => enter(element));
  }

  close() {
    Promise.all(this.transitionableTargets.map((element) => leave(element))).then(() => {
      this.element.parentElement.removeAttribute('src');
      this.element.remove();
      this.unlockScroll();
    });
  }

  submitEnd(event) {
    if (event.detail.success) {
      this.close();
    }
  }

  lockScroll() {
    document.body.classList.add('overflow-hidden', 'pr-4');
  }

  unlockScroll() {
    document.body.classList.remove('overflow-hidden', 'pr-4');
  }
}
