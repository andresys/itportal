// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import Vue from 'vue/dist/vue.esm'
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"

// Import plugins
// import "../plugins/app"
import "../plugins/index-charts"

import ImageCard from "../components/image-card"
import UploadFiles from "../components/upload-files"
import Fancybox from "../components/fancybox"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#app',
//     data: {counter:0},
//     components: {
//       'image-card': ImageCard,
//     }
//   })
// })

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    data: {counter:0},
    components: {
      'image-card': ImageCard,
      'upload-files': UploadFiles,
      'Fancybox': Fancybox,
    },
    beforeMount() {
      if (this.$el.parentNode) {
        document.addEventListener('turbolinks:visit', () => this.$destroy(), { once: true });
        this.$originalEl = this.$el.outerHTML;
      }
    },
    destroyed() {
      this.$el.outerHTML = this.$originalEl;
    }
  })
})
