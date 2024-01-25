// import * as Alert from "bootstrap/js/dist/alert"
// import * as Toast from "bootstrap/js/dist/toast"

const responsiveSidePanel = () => {
	const sidePanel = document.getElementById('app-sidepanel');  
	let w = window.innerWidth;
	console.log(w)
	
	if(w >= 1200) {
		sidePanel.classList.remove('sidepanel-hidden');
		sidePanel.classList.add('sidepanel-visible');
	} else {
		sidePanel.classList.remove('sidepanel-visible');
		sidePanel.classList.add('sidepanel-hidden');
	}
}

document.addEventListener('load', responsiveSidePanel)
document.addEventListener('resize', responsiveSidePanel, true)

const rerender = () => {
	/* ===== Enable Bootstrap Popover (on element  ====== */
	// var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="popover"]'))
	// var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
	// 	return new bootstrap.Popover(popoverTriggerEl)
	// })

	/* ==== Enable Bootstrap Alert ====== */
	// var alertList = document.querySelectorAll('.alert')
	// alertList.forEach(function (alert) {
	// 	new Alert(alert)
	// })

	// var toastList = document.querySelectorAll('.toast')
	// toastList.forEach(function (toast) {
	// 	Toast.getOrCreateInstance(toast).show()
	// })

	/* ===== Responsive Sidepanel ====== */
	const sidePanel = document.getElementById('app-sidepanel');  
	const sidePanelToggler = document.getElementById('sidepanel-toggler'); 
	const sidePanelDrop = document.getElementById('sidepanel-drop'); 
	const sidePanelClose = document.getElementById('sidepanel-close'); 

	if(sidePanelClose) {
		sidePanelClose.addEventListener('click', (e) => {
			e.preventDefault()
			sidePanelToggler.click()
		})
	}
	if(sidePanelDrop) {
		sidePanelDrop.addEventListener('click', (e) => {
			sidePanelToggler.click()
		})
	}

	if(sidePanelToggler) {
		sidePanelToggler.addEventListener('click', (e) => {
			e.preventDefault()
			if (sidePanel.classList.contains('sidepanel-visible')) {
				sidePanel.classList.remove('sidepanel-visible')
				sidePanel.classList.add('sidepanel-hidden')
			} else {
				sidePanel.classList.remove('sidepanel-hidden')
				sidePanel.classList.add('sidepanel-visible')
			}
		})
	}

	/* ====== Mobile search ======= */
	// const searchMobileTrigger = document.querySelector('.search-mobile-trigger')
	// const searchBox = document.querySelector('.app-search-box')
	// if(searchMobileTrigger) {
	// 	searchMobileTrigger.addEventListener('click', () => {
	// 		if(searchBox) { searchBox.classList.toggle('is-visible') }
	// 		let searchMobileTriggerIcon = document.querySelector('.search-mobile-trigger-icon')
	// 		if(searchMobileTriggerIcon) {
	// 			if(searchMobileTriggerIcon.classList.contains('fa-search')) {
	// 				searchMobileTriggerIcon.classList.remove('fa-search')
	// 				searchMobileTriggerIcon.classList.add('fa-times')
	// 			} else {
	// 				searchMobileTriggerIcon.classList.remove('fa-times')
	// 				searchMobileTriggerIcon.classList.add('fa-search')
	// 			}
	// 		}
	// 	})
	// }
}

document.addEventListener('turbo:load', rerender)