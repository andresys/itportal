<template>
  <div ref="container">
    <button type="button" :class="attrs.class" :style="attrs.style" :data-bs-target="'#'+id" data-bs-toggle="modal">
      <slot name="activator">{{text}}</slot>
    </button>
    <div :id="id" class="modal fade" :data-bs-backdrop="options.backdrop" :data-bs-keyboard="options.keyboard" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div :class="['modal-dialog', {'modal-dialog-centered': centered}, options.fullscreen, options.size]">
        <div class="modal-content">
          <div v-if="title || !!$slots.title" class="modal-header">
            <slot name="title">
              <h5 class="modal-title" id="staticBackdropLabel">{{ title }}</h5>
            </slot>
            <button v-if="close" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div v-if="content || !!$slots.default" class="modal-body">
            <slot>
              <div v-html="content"></div>
            </slot>
          </div>
          <div v-if="dialog || !!$slots.footer" class="modal-footer">
            <slot name="foother">
              <button type="button" class="btn btn-primary">Ok</button>
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </slot>            
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import http from '../util/http'

export default {
  inheritAttrs: false,
  props: {
    id: String,
    text: {default: "Open dialog"},
    title: String,
    backdrop: [Boolean, String],
    keyboard: Boolean,
    scrollable: Boolean,
    centered: Boolean,
    size: String,
    fullscreen: [Boolean, String],
    dialog: String,
    close: {type: Boolean, default: true},
    ajax: String,
  },
  computed: {
    attrs() {
      const attrs = { ...this.$attrs }
      attrs.class = this.$vnode.data.staticClass
      attrs.style = this.$vnode.data.staticStyle
      return attrs
    },
    options() {
      return {
        backdrop: this.backdrop ? this.backdrop : 'false',
        keyboard: this.keyboard ? 'true' : 'false',
        fullscreen: typeof this.fullscreen === 'string' ? this.fullscreen : (this.fullscreen ? 'modal-fullscreen' : false),
        size: this.size ? this.size : false,
      }
    },
  },
  data: function () {
    return { content: "" }
  },
  mounted() {
    this.$refs.container.removeAttribute('style')
    this.$refs.container.removeAttribute('class')

    if(this.ajax) {
      http.get(this.ajax)
        .then( (response) => {
          this.content = response.data
        })
    }
  },
}
</script>