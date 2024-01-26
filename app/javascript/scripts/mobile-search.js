const rerender = () => {
	/* ====== Mobile search ======= */
	const searchMobileTrigger = document.querySelector('.search-mobile-trigger')
	const searchBox = document.querySelector('.app-search-box')
	if(searchMobileTrigger) {
		searchMobileTrigger.addEventListener('click', () => {
			if(searchBox) { searchBox.classList.toggle('is-visible') }
			let searchMobileTriggerIcon = document.querySelector('.search-mobile-trigger-icon')
			if(searchMobileTriggerIcon) {
				if(searchMobileTriggerIcon.classList.contains('fa-search')) {
					searchMobileTriggerIcon.classList.remove('fa-search')
					searchMobileTriggerIcon.classList.add('fa-times')
				} else {
					searchMobileTriggerIcon.classList.remove('fa-times')
					searchMobileTriggerIcon.classList.add('fa-search')
				}
			}
		})
	}
}

document.addEventListener('turbo:load', rerender)