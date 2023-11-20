import { Controller } from '@hotwired/stimulus';

export default class TabsController extends Controller {
  static targets = ['tab', 'panel'];

  static classes = ['active', 'inactive'];

  initialize() {
    this.showTab();
  }

  change(event) {
    this.index = this.tabTargets.indexOf(event.target);
    this.showTab(this.index);
  }

  showTab() {
    this.panelTargets.forEach((el, i) => {
      if (i === this.index) {
        el.classList.remove(this.inactiveClass);
      } else {
        el.classList.add(this.inactiveClass);
      }
    });

    this.tabTargets.forEach((el, i) => {
      if (i === this.index) {
        el.classList.add(...this.activeClasses);
      } else {
        el.classList.remove(...this.activeClasses);
      }
    });
  }

  get index() {
    return parseInt(this.data.get('index'), 10);
  }

  set index(value) {
    this.data.set('index', value);
    this.showTab();
  }
}
