import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["repoUrl"]

  connect() {
    this.highlightTimeout = null
  }

  focusRepoUrl(event) {
    event.preventDefault()

    const field = this.repoUrlTarget

    field.scrollIntoView({ behavior: "smooth", block: "center" })
    field.focus({ preventScroll: true })

    field.classList.add("repoHighlight")
    window.clearTimeout(this.highlightTimeout)
    this.highlightTimeout = window.setTimeout(() => {
      field.classList.remove("repoHighlight")
    }, 1500)
  }
}

