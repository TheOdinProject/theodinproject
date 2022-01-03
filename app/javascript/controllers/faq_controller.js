import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  collapseHandler() {
    const foundElement = this.element.firstElementChild.childNodes;
    this.showIcon(foundElement);
    this.collapseIcon(foundElement);
    this.element.style.pointerEvents = 'none';
    setTimeout(() => this.allowEvents(this.element), 300);
  }

  allowEvents(element) {
    element.style.pointerEvents = 'all';
  }

  showIcon(element) {
    const children = element[3];
    const computedStyles = window.getComputedStyle(children);
    const foundStyle = computedStyles.getPropertyValue('display');
    if (foundStyle !== 'none') {
      children.style.display = 'none';
    } else {
      children.style.display = 'block';
    }
  }

  collapseIcon(element) {
    const children = element[5];
    const computedStyles = window.getComputedStyle(children);
    const foundStyle = computedStyles.getPropertyValue('display');
    if (foundStyle !== 'none') {
      children.style.display = 'none';
    } else {
      children.style.display = 'block';
    }
  }
}
