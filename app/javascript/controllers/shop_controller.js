import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modalCon", "itemModal"]

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

  updateQuantity(event) {
    const quantity = event.target.value
    const link = this.element.querySelector(".orderBtn")
    const url = new URL(link.href)
    url.searchParams.set("quantity", quantity)
    link.href = url.toString()
  }

}