import { Fancybox } from "@fancyapps/ui"

window.addEventListener('turbolinks:load', () => {
  let opts = {}

  Fancybox.bind('[data-fancybox="gallery"]', opts)
})