import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modalCon", "itemModal", "quantity"]

  connect() {
    const params = new URLSearchParams(window.location.search)
    if (params.get("shop_item_id")) {
      this.modalConTarget.style.display = "flex"
    }
  }

  close(event) {
    if (!this.itemModalTarget.contains(event.target)) {
      this.modalConTarget.style.display = "none"
      const url = new URL(window.location)
      url.searchParams.delete("shop_item_id")
      window.history.pushState({}, "", url)
    }
  }

  incrementQuantity(event) {
    event.preventDefault()
    this.quantityTarget.stepUp()
  }

  decrementQuantity(event) {
    event.preventDefault()
    if (Number(this.quantityTarget.value) <= Number(this.quantityTarget.min || 1)) return
    this.quantityTarget.stepDown()
  }

}