import React from 'react';
import { object, func, string, bool } from 'prop-types';
import { kebabCase } from 'lodash';

const UrlField = ({ name, label, icon, register, errors, autoFocus, placeholder }) => {
  const styles = () => (
    errors[name]
      ? 'pr-10 border-red-300 text-red-900 placeholder-red-400 focus:ring-red-500 focus:border-red-500'
      : 'border-gray-300 focus:ring-indigo-500 focus:border-indigo-500'
    );

  return (
    <div>
      <label htmlFor={name} className="block text-sm font-medium text-gray-700 text-left">{ label }</label>
      <div className="mt-1 relative rounded-md shadow-sm">
        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <span className={`text-gray-700 odin-dark-icon ${icon}`} />
        </div>
        <input
          type="url"
          autoFocus={autoFocus}
          id={name}
          className={`block w-full pl-10 rounded-md dark-form-input ${styles()}`}
          placeholder={placeholder}
          data-test-id={`${kebabCase(name)}-field`}
          {...register(name)}
        />
      </div>

      {errors[name] && (
        <div className="mt-2 text-sm text-red-600" data-test-id="error-message">
          {' '}
          {errors[name].message}
        </div>
      )}
    </div>
  );
};

UrlField.defaultProps = {
  autoFocus: false,
  placeholder: '',
}

UrlField.propTypes = {
  name: string.isRequired,
  label: string.isRequired,
  icon: string.isRequired,
  register: func.isRequired,
  errors: object.isRequired,
  placeholder: string,
  autoFocus: bool,
};

export default UrlField;
