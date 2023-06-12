/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Rails from '@rails/ujs';
import 'core-js/stable';
import 'regenerator-runtime/runtime';
import 'hint.css/hint.min.css';
import '@fortawesome/fontawesome-free/css/all.css';
import './src/js/axiosWithCsrf';
import 'controllers';
import '@hotwired/turbo-rails';

Rails.start();

const componentRequireContext = require.context('./components', true);
const ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(componentRequireContext);
ReactRailsUJS.handleEvent('turbo:load', ReactRailsUJS.handleMount);
ReactRailsUJS.handleEvent('turbo:before-render', ReactRailsUJS.handleUnmount);
ReactRailsUJS.handleEvent('turbo:frame-load', ReactRailsUJS.handleMount);
ReactRailsUJS.handleEvent('turbo:frame-render', ReactRailsUJS.handleUnmount);
