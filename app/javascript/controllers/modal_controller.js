import { Controller } from "@hotwired/stimulus"
import Modal from "bootstrap/js/dist/modal"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [ "modal" ]

  open() {
    this.modal.show()
  }

  close(event) {
    this.modal.hide()
    event.preventDefault()
  }

  get modal() {
    return Modal.getOrCreateInstance(this.modalTarget)
  }
}
