import { Controller } from "@hotwired/stimulus"
import Lenis from "lenis"

export default class extends Controller {
    connect() {
        this.lenis = new Lenis()
        this.raf = (time) => {
            this.lenis.raf(time)
            this.rafId = requestAnimationFrame(this.raf)
        }
        this.rafId = requestAnimationFrame(this.raf)
    }

    disconnect() {
        cancelAnimationFrame(this.rafId)
        this.lenis?.destroy()
    }
}