import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin"
export default class extends Controller {
  static targets = ["modal", "title", "userId"]

  openModal(event) {
    const userId = event.currentTarget.dataset.userId
    const username = event.currentTarget.dataset.userName
    const isAdd = event.currentTarget.classList.contains("add")

    this.userIdTarget.value = userId
    this.titleTarget.textContent =
        `${isAdd ? "Add" : "Remove"} Hours for ${username}`
  }

  workInProgress() {
    alert("W.I.P");
  }
}
