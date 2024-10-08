import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = [ "target", "template" ]
  static values = { wrapperSelector: { type: String, default: ".nested-form-wrapper" } }
  connect() {
  }

  add(e) {
    e.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.targetTarget.insertAdjacentHTML('beforebegin', content)

    const event = new CustomEvent('rails-nested-form:add', { bubbles: true })
    this.element.dispatchEvent(event)
  }

  remove(e) {
    e.preventDefault()
    const wrapper = e.target.closest(this.wrapperSelectorValue)

    if (wrapper.dataset.newRecord == "true") {
      wrapper.remove()
    } else {
      wrapper.style.display = 'none'
      const input = wrapper.querySelector("input[name*='_destroy']")
      input.value = 1
    }

    const event = new CustomEvent('rails-nested-form:remove', { bubbles: true })
    this.element.dispatchEvent(event)
  }
}
