import Alert from "bootstrap/js/dist/alert"
import Toast from "bootstrap/js/dist/toast"

const rerender = () => {
	/* ===== Enable Bootstrap Popover (on element  ====== */
	var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="popover"]'))
	popoverTriggerList.map(function (popoverTriggerEl) {
		return new bootstrap.Popover(popoverTriggerEl)
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