import axios from 'axios'

const http = axios.create({
  headers: {
    'Content-Type': 'application/json',
  }
})

http.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'

http.interceptors.request.use(function (config) {
  // config.headers[document.querySelector('meta[name="csrf-param"]').getAttribute('content')] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  config.headers['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  return config
}, function (error) {
  return Promise.reject(error.response)
})

export default http