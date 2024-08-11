import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="input-switcher"
export default class extends Controller {
  static targets = [ "input" ]
  connect() {
  }

  switch(event) {
    this.inputTargets.forEach((input) => {
      if (event.params.id !== input.id) {
        input.classList.add('hidden')
        input.required = false
        input.disabled = true
      } else {
        input.classList.remove('hidden')
        input.required = true
        input.disabled = false
      }
    })
  }
}
