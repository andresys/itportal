import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "@popperjs/core"
import "bootstrap/js/dist/dropdown"
import "bootstrap/js/dist/collapse"
import "bootstrap/js/dist/modal"
import "bootstrap/js/dist/button"
import "bootstrap/js/dist/alert"

import "../plugins/index-charts"
import "../plugins/itportal"
import "../plugins/select"
import "../plugins/fancybox"

Rails.start()
Turbolinks.start()
ActiveStorage.start()