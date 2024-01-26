import { Datepicker } from 'vanillajs-datepicker'

export default {
  el: 'input[data-provide="datepicker"]',
  props: {
    options: Object,
  },
  data: function () {
    return { dp: null }
  },
  mounted() {
    this.dp = new Datepicker(this.$el, {
      ...(this.options || {}),
    })
  },
  updated() {
  },
  unmounted() {
  },
};