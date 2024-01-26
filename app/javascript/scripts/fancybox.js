import { Fancybox } from "@fancyapps/ui"

window.addEventListener('turbo:load', () => {
  let opts = {}

  Fancybox.bind('[data-fancybox]', opts)
})