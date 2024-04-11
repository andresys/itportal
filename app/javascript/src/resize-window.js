const rerender = () => {
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

document.addEventListener('load', rerender)
document.addEventListener('resize', rerender)