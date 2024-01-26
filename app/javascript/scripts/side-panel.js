const rerender = () => {
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
}

document.addEventListener('turbo:load', rerender)