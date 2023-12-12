import TomSelect from 'tom-select/dist/js/tom-select.complete'
import Translations from '../i18n/select.json'

document.addEventListener('turbolinks:load', () => {
  const i18n = Translations[document.querySelector('body').dataset.lang]

  document.querySelectorAll('.js-select').forEach((element) => {
    var opts = {
      // valueField: 'id',
      // lebelField: 'name',
      // searchField: 'name',
      create: false,
      onChange: () => { if(element.dataset.autoSubmit) { element.form.submit() } },
      plugins: {
        'clear_button':{
          'title': i18n['clear_button'],
        }
      },
      // load: (query, callback) => {
      //   const url = element.dataset.ajaxUrl + '.json?term=' + encodeURIComponent(query)

      //   fetch(url)
      //     .then(response => response.json())
      //     .then(json => {
      //       callback(json)
      //     }).catch(() => {
      //       callback()
      //     })
      // },
      render: {
        no_results: (_date, _escape) => {
          return '<div class="no-results">' + i18n['no_results'] + '</div>'
        }
      }
    }

    new TomSelect(element, opts)
  })
})