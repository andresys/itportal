<template>
  <button @click="$refs.file.click()">
    <slot></slot>
    <input type="file" ref="file" v-bind="$attrs" @change="onFileChange">
  </button>
</template>

<script>
import http from '../util/http'

export default {
  inheritAttrs: false,
  props: {
    url: String,
    param: {default: 'files'}
  },
  data: () => {
    return { }
  },
  methods: {
    onFileChange(e) {
      var files = e.target.files || e.dataTransfer.files
      if (!files.length)
        return;
      let data = new FormData
      for (let i = 0; i < files.length; i++) { data.append(this.param, files[i]) }

      http.patch(this.url, data, { headers: { 'Content-Type': 'multipart/ form-data' } })
        .then( (response) => {
          location.reload()
          // var child = 
          // this.$el.parentNode.appendChild(child)
        })
    }
  }
}
</script>

<style scoped>
input[type="file"] {
  display: none;
}
</style>
