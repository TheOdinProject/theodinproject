import { Controller } from '@hotwired/stimulus'

export default class SidebarToggleController extends Controller {
  static outlets = ['visibility']
  static classes = ['collapsed']
  static targets = ['item']
  static values = { storageKey: String }

  connect () {
    if (this.isDesktop() && window.localStorage.getItem(this.storageKeyValue) === 'true') {
      this.element.classList.add(this.collapsedClass)
    }
  }

  itemTargetConnected (item) {
    if (item.getAttribute('href') === window.location.pathname) {
      item.setAttribute('aria-current', 'page')
      item.closest('details').open = true
    } else {
      item.removeAttribute('aria-current')
    }
  }

  toggle () {
    if (this.isDesktop()) {
      this.isCollapsed() ? this.expand() : this.collapse()
    } else if (this.hasVisibilityOutlet) {
      this.visibilityOutlet.toggle()
    }
  }

  collapse () {
    this.element.classList.add(this.collapsedClass)
    this.persist(true)
  }

  expand () {
    this.element.classList.remove(this.collapsedClass)
    this.persist(false)
  }

  isDesktop () {
    return window.matchMedia('(min-width: 1280px)').matches
  }

  isCollapsed () {
    return this.element.classList.contains(this.collapsedClass)
  }

  persist (collapsed) {
    window.localStorage.setItem(this.storageKeyValue, String(collapsed))
  }
}
