import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [ "content" ]
  connect() {
  }

  hide(event) {
    if (!this.contentTarget.contains(event.target)) {
      this.element.remove()
    }
  }
}
