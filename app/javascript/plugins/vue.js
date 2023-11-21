import Vue from 'vue/dist/vue.esm'

import ImageCard from "../components/image-card"
import UploadFiles from "../components/upload-files"
import Fancybox from "../components/fancybox"
import ModalDialog from "../components/modal-dialog"
import DatePicker from  "../components/datepicker"

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    data: {counter:0},
    components: {
      ImageCard,
      UploadFiles,
      Fancybox,
      ModalDialog,
      DatePicker,
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