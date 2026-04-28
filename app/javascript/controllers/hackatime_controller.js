import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["project", "confirm"]
  static values = {projectId: Number}

  connect() {
    this.selected = new Set()

    const saved = JSON.parse(this.element.dataset.hackatimeSavedNames || "[]")
    this.projectTargets.forEach(el => {
      if (saved.includes(el.dataset.name)) {
        this.selected.add(el)
        el.classList.add("selected")
      }
    })
  }

  toggle(event) {
    const el = event.currentTarget
    if (this.selected.has(el)) {
      this.selected.delete(el)
      el.classList.remove("selected")
    } else {
      this.selected.add(el)
      el.classList.add("selected")
    }
  }

  confirm() {
    console.log("projectIdValue", this.projectIdValue)
    if (!this.projectIdValue) return
    const totalSeconds = [...this.selected].reduce((sum, el) => sum + Number(el.dataset.seconds), 0)
    const hours = (totalSeconds / 3600.0).toFixed(1)
    const names = [...this.selected].map(el => el.dataset.name)

    console.log("url:", `/projects/${this.projectIdValue}`)

    fetch(`/projects/${this.projectIdValue}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "X-HTTP-Method-Override": "PATCH"
      },
      body: JSON.stringify({project: { code_hours: hours, hackatime_projects: names } })
    }).then(() => {
      document.querySelectorAll(".hrsRed").forEach(el => el.textContent = `${hours} code hrs`)
    })
  }
}