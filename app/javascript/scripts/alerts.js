import Alert from "bootstrap/js/dist/alert"
import Toast from "bootstrap/js/dist/toast"
import Popover from "bootstrap/js/dist/popover"

const rerender = () => {
	/* ===== Enable Bootstrap Popover (on element  ====== */
	var popoverList = document.querySelectorAll('[data-bs-toggle="popover"]')
	popoverList.forEach(function (popover) {
		new Popover(popover)
	})
	
	/* ==== Enable Bootstrap Alert ====== */
	var alertList = document.querySelectorAll('.alert')
	alertList.forEach(function (alert) {
		new Alert(alert)
	})

	var toastList = document.querySelectorAll('.toast')
	toastList.forEach(function (toast) {
		Toast.getOrCreateInstance(toast).show()
	})
}

document.addEventListener('turbo:load', rerender)
document.addEventListener('turbo:frame-render', rerender)
document.addEventListener('turbo:render', rerender)