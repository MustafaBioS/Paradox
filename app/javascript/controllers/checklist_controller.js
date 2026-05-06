import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "continueLink"]

  connect() {
	this.updateState()
  }

  updateState() {
	const allChecked = this.checkboxTargets.every((checkbox) => checkbox.checked)

	this.continueLinkTarget.classList.toggle("disabled", !allChecked)
	this.continueLinkTarget.setAttribute("aria-disabled", String(!allChecked))
	this.continueLinkTarget.tabIndex = allChecked ? 0 : -1
  }

  preventIfDisabled(event) {
	if (this.continueLinkTarget.classList.contains("disabled")) {
	  event.preventDefault()
	}
  }
}

