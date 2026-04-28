import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
    static values = { url: String, projectId: Number }

    connect() {
        this.timer = null
    }

    save(e) {
        const desc = e.target.value
        clearTimeout(this.timer)

        this.timer = setTimeout(async () => {
            const response = await fetch(this.urlValue, {
                method: "PATCH",
                headers: {
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ project: { description: desc } })
            })

            if (!response.ok) return

            const data = await response.json()
        }, 800)
    }
}