import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = [ "content" ]
  connect() {
  }

  toggle() {
    this.contentTarget.classList.toggle('hidden')
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.contentTarget.classList.add('hidden')
    }
  }
}
