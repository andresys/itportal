// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"

import * as ActiveStorage from "@rails/activestorage"
import "./channels"

import "./controllers"
import "./custom_actions/dispatch_event"

import "bootstrap/js/dist/dropdown"
import "bootstrap/js/dist/collapse"
import "bootstrap/js/dist/modal"
import "bootstrap/js/dist/button"
import "bootstrap/js/dist/alert"

import "./libs/jquery"
import './libs/jquery-ui'
import './libs/nestedSortable'

import "./src/index-charts"
import "./src/side-panel"
import "./src/resize-window"
import "./src/alerts"
import "./src/select"
import "./src/fancybox"
import "./src/sortable"

ActiveStorage.start()
