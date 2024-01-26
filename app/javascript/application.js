// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"

import * as ActiveStorage from "@rails/activestorage"
import "./channels"

import "bootstrap/js/dist/dropdown"
import "bootstrap/js/dist/collapse"
import "bootstrap/js/dist/modal"
import "bootstrap/js/dist/button"
import "bootstrap/js/dist/alert"

import "./scripts/index-charts"
import "./scripts/side-panel"
import "./scripts/resize-window"
import "./scripts/alerts"
import "./scripts/select"
import "./scripts/fancybox"

ActiveStorage.start()