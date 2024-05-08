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
      this.element.remove();
      this.unlockScroll();
    });
  }

  submitEnd(event) {
    if (event.detail.success) {
      this.close();
    }
  }

  onKeydown(event) {
    if (event.key === 'Escape') {
      this.close();
    }
  }

  lockScroll() {
    document.body.classList.add('overflow-hidden', 'sm:pr-4');
  }

  unlockScroll() {
    document.body.classList.remove('overflow-hidden', 'sm:pr-4');
  }
}
