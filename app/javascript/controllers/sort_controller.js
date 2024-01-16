import { Controller } from '@hotwired/stimulus';
import Sortable from 'sortablejs';

export default class extends Controller {
  static targets = ['item'];

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 300,
      easing: 'cubic-bezier(0.61, 1, 0.88, 1)',
      disabled: true,
    });
  }

  itemTargetConnected() {
    const items = Array.from(this.itemTargets);

    if (this.itemsAreSorted(items)) return;

    const sortedItems = items.sort((a, b) => this.compareItems(a, b)).map((item) => item.dataset.id);
    this.sortable.sort(sortedItems, true);
  }

  itemsAreSorted() {
    return this.itemSortCodes().every((sortCode, index, items) => {
      if (index === 0) return true;
      return sortCode <= items[index - 1];
    });
  }

  itemSortCodes() {
    return this.itemTargets.map((item) => this.getSortCode(item));
  }

  /* eslint-disable class-methods-use-this */
  getSortCode(item) {
    return parseFloat(item.getAttribute('data-sort-code')) || 0;
  }

  compareItems(left, right) {
    return this.getSortCode(right) - this.getSortCode(left);
  }
}
