/* eslint-disable import/extensions, import/no-unresolved */
import { Application } from '@hotwired/stimulus';
import controllers from './*_controller.js';
import componentControllers from '../../components/**/*_controller.js';

const application = Application.start();

// Register componentControllers from "../../components/**/*_controller.js"
componentControllers.forEach((controller) => {
  application.register(controller.name.replace('..--..--components--', ''), controller.module.default);
});

// Register controllers from "./*_controller.js"
controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default);
});

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export default application;
