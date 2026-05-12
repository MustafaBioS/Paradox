import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modalCon", "redModal", "blueModal"]

  connect() {
    this.codeHrsBox = document.querySelector(".codeHrsBox")
    this.artHrsBox = document.querySelector(".artHrsBox")

    this.handleCodeClick = () => this.open("red")
    this.handleArtClick = () => this.open("blue")
    this.handleEscape = (event) => {
      if (event.key === "Escape") this.close()
    }

    this.codeHrsBox?.addEventListener("click", this.handleCodeClick)
    this.artHrsBox?.addEventListener("click", this.handleArtClick)
    document.addEventListener("keydown", this.handleEscape)

    this.close()
  }

  disconnect() {
    this.codeHrsBox?.removeEventListener("click", this.handleCodeClick)
    this.artHrsBox?.removeEventListener("click", this.handleArtClick)
    document.removeEventListener("keydown", this.handleEscape)
  }

  open(which) {
    this.modalConTarget.classList.add("open")
    this.redModalTarget.classList.toggle("open", which === "red")
    this.blueModalTarget.classList.toggle("open", which === "blue")
  }

  close(event) {
    if (event && event.target !== event.currentTarget) return

    this.modalConTarget.classList.remove("open")
    this.redModalTarget.classList.remove("open")
    this.blueModalTarget.classList.remove("open")
  }
}

