import { Controller } from "@hotwired/stimulus"
import { useTransition } from "../helpers/use-transition";

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    useTransition(this)
    this.enter()
    this.timeout = setTimeout(() => {
      this.dismiss();
    }, 5000);
  }

  async dismiss() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
    await this.leave()
    this.element.remove()
  }
}
