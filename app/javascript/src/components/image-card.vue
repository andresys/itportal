<template>
<div>
  <div class="app-card app-card-doc shadow-sm h-100">
    <div class="app-card-thumb-holder p-3">
      <div class="app-card-thumb">
        <img class="thumb-image" :src="thumb" alt="">
      </div>
      <span v-if="tag" class="badge bg-success">{{ tag }}</span>
      <a data-fancybox="gallery" :href="url" ref="link" class="app-card-link-mask"></a>
    </div>
    <div class="app-card-body p-3 has-card-actions">
      <div class="app-doc-meta">
        <ul class="list-unstyled mb-0">
          <li v-if="size"><span class="text-muted">{{ size_text }}:</span> {{ size }}</li>
          <li v-if="uploaded"><span class="text-muted">{{ uploaded_text }}:</span> {{ uploaded }}</li>
        </ul>
      </div>
      <div class="app-card-actions">
        <div class="dropdown">
          <div data-bs-toggle="dropdown" aria-expanded="false" class="dropdown-toggle no-toggle-arrow">
            <svg width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="bi bi-three-dots-vertical">
              <path fill-rule="evenodd" d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"></path>
            </svg>
          </div>
          <ul class="dropdown-menu">
            <li>
              <a href="#" @click.prevent.stop="$refs.link.click()" class="dropdown-item">
                <svg width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="bi bi-eye me-2">
                  <path fill-rule="evenodd" d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.134 13.134 0 0 0 1.66 2.043C4.12 11.332 5.88 12.5 8 12.5c2.12 0 3.879-1.168 5.168-2.457A13.134 13.134 0 0 0 14.828 8a13.133 13.133 0 0 0-1.66-2.043C11.879 4.668 10.119 3.5 8 3.5c-2.12 0-3.879 1.168-5.168 2.457A13.133 13.133 0 0 0 1.172 8z"></path>
                  <path fill-rule="evenodd" d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"></path>
                </svg>
                {{ view_text }}
              </a>
            </li>
            <li>
              <a href="#" @click.prevent.stop="downloadImg()" class="dropdown-item">
                <svg width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="bi bi-download me-2">
                  <path fill-rule="evenodd" d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"></path>
                  <path fill-rule="evenodd" d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z"></path>
                </svg>
                {{ download_text }}
              </a>
            </li>
            <li v-if="deleted"><hr class="dropdown-divider"></li>
            <li v-if="deleted">
              <a href="#" @click.prevent.stop="deleteImg()" class="dropdown-item">
                <svg width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="bi bi-trash me-2">
                  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"></path>
                  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"></path>
                </svg>
                {{ delete_text }}
              </a>
            </li>
          </ul>
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
    url: String,
    thumb: String,
    size: String,
    uploaded: String,
    deleted: {default: false},
    tag: {default: false},
    view_text: {default: "View"},
    download_text: {default: "Download"},
    delete_text: {default: "Delete"},
    size_text: {default: "Size"},
    uploaded_text: {default: "Uploaded"},
    image_name: {default: "Image"},
  },
  data: function () {
    return { }
  },
  methods: {
    downloadImg() {
      fetch(this.url)
        .then((response) => response.blob())
        .then((blob) => {
          require("downloadjs")(blob, this.image_name, "image/png");
        })
    },
    deleteImg() {
      http.delete(this.deleted)
        .then( (response) => {
          this.$destroy()
          this.$el.parentNode.removeChild(this.$el)
        })
    },
  },
}
</script>

<style scoped>
</style>
