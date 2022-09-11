/* eslint-disable */
import { Application } from 'stimulus';
/* eslint-enable */
import { ValidationController } from 'stimulus-validation';

export default class FormValidation extends ValidationController {
  static rules = {
    email: { email: { message: '^is not a valid email' } },
    username: {
      presence: true,
      length: {
        minimum: 4,
        message: '^is too short (minimum is 4 characters)',
      },
    },
    currentPassword: {
      presence: true,
    },
    password: {
      presence: true,
      length: {
        minimum: 6,
        maximum: 128,
        message: '^is too short (minimum is 6 characters)',
      },
    },
  };

  static validators = { passwordIsConfirmed: { attributes: ['password_confirmation'] } };

  passwordIsConfirmed({ attr, value }) {
    if (value !== document.getElementById('user_password').value) {
      this.errors.add(attr, 'The passwords do not match');
    }
  }

  afterValidate({ el, attr }) {
    if (this.errors.has(attr)) {
      FormValidation.errorMessageEl(el).textContent = this.errorMessage(attr);
    }
  }

  static errorMessageEl(el) {
    const errorField = el.parentElement.nextElementSibling;
    errorField.classList.remove('hidden');

    return errorField;
  }

  errorMessage(attr) {
    return this.errors.has(attr) ? this.errors.get(attr)[0] : '';
  }
}

const application = Application.start();
application.register('form-validation', FormValidation);
